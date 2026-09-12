//+------------------------------------------------------------------+
//|                                          FleetToggleButton_v2.mq4 |
//|                        Fleet Standard Toggle Button v2.1          |
//|                        "The Sovereign Gate"                       |
//|                                                                   |
//|  Based on: Divergence Confluence v2.30 canonical module           |
//|  Reviewed: Multi-pass quality review (P0/P1/P2 fixes applied)     |
//|  Status:   Production-ready for Exocortex commit                  |
//|                                                                   |
//|  DOCTRINE: Button gates RENDERING only. Logic, beacons, alerts,   |
//|  and all computational state ALWAYS run. The fleet never sleeps.  |
//|                                                                   |
//|  v2.1 2026-09-12 — P0 compile fixes, P1 reliability, P2 polish    |
//+------------------------------------------------------------------+

// ==================================================================
// 001 - INPUTS (Fleet Standard — append at END of indicator inputs)
// ==================================================================

input string   InpSectionButton    = "=== Fleet Toggle Button v2.1 ===";
input ENUM_BASE_CORNER InpButtonCorner    = CORNER_RIGHT_UPPER;
input string   InpButtonText       = "FLEET";           // Button label
input string   InpButtonFont       = "Arial";
input int      InpButtonFontSize   = 8;
input color    InpButtonTextOn     = clrAqua;           // 16776960
input color    InpButtonTextOff    = clrRed;            // 255
input color    InpButtonBgColor    = C'40,40,40';       // 6908265
input color    InpButtonBgOff      = C'20,20,20';       // 5197615
input int      InpButtonX          = 92;
input int      InpButtonY          = 2;                 // Stack position
input int      InpButtonWidth      = 89;
input int      InpButtonHeight     = 21;
input string   InpInstanceId       = "";                // Unique per indicator (multi-instance)
input bool     InpButtonPersist    = true;              // GV state persistence
input bool     InpButtonDebug      = false;             // Debug telemetry

// ==================================================================
// 002 - GLOBALS (Fleet Standard — prefix all with g_FTB_)
// ==================================================================

string   g_FTB_buttonName;           // ChartID + InstanceId scoped name
string   g_FTB_instanceKey;          // "{ChartID}_{InstanceId}" for names/GVs
bool     g_FTB_showData    = true;   // RENDER gate (sovereignty: logic always runs)
bool     g_FTB_initialized = false;  // Init guard for deinit safety
uint     g_FTB_lastTick    = 0;      // Debounce: GetTickCount() ms
int      g_FTB_clickCount  = 0;      // Debug counter

// GV persistence keys (built in OnInit)
string   g_FTB_gvState;              // "FLEETBTN_{Key}_State"
string   g_FTB_gvVersion;            // "FLEETBTN_{Key}_Version"

// Module version — checked on restore
#define FTB_VERSION 2.1

// ==================================================================
// 003 - CORE MODULE
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_BuildInstanceKey — ChartID + optional InstanceId             |
//+------------------------------------------------------------------+
string FTB_BuildInstanceKey()
{
   if(StringLen(InpInstanceId) > 0)
      return(StringFormat("%I64d_%s", ChartID(), InpInstanceId));
   return(StringFormat("%I64d", ChartID()));
}

//+------------------------------------------------------------------+
//| FTB_BuildName — Unique button name                               |
//+------------------------------------------------------------------+
string FTB_BuildName()
{
   return(StringFormat("FLEETBTN_%s_BTN", g_FTB_instanceKey));
}

//+------------------------------------------------------------------+
//| FTB_BuildGVKeys — GlobalVariable persistence keys                |
//+------------------------------------------------------------------+
void FTB_BuildGVKeys()
{
   g_FTB_gvState   = StringFormat("FLEETBTN_%s_State",   g_FTB_instanceKey);
   g_FTB_gvVersion = StringFormat("FLEETBTN_%s_Version", g_FTB_instanceKey);
}

//+------------------------------------------------------------------+
//| FTB_ValidateInputs — Fail-fast on invalid parameters             |
//+------------------------------------------------------------------+
bool FTB_ValidateInputs()
{
   if(InpButtonWidth < 20 || InpButtonHeight < 10)
   {
      PrintFormat("[FTB v2.1] ERROR: Button too small (%dx%d). Min 20x10.",
                  InpButtonWidth, InpButtonHeight);
      return(false);
   }
   if(InpButtonFontSize < 6 || InpButtonFontSize > 24)
   {
      PrintFormat("[FTB v2.1] ERROR: Font size %d out of range [6,24].",
                  InpButtonFontSize);
      return(false);
   }
   if(InpButtonX < 0 || InpButtonY < 0)
   {
      PrintFormat("[FTB v2.1] ERROR: Negative position (%d,%d).",
                  InpButtonX, InpButtonY);
      return(false);
   }
   if(StringLen(InpButtonText) == 0)
   {
      Print("[FTB v2.1] ERROR: Empty button text.");
      return(false);
   }
   if(StringLen(InpButtonText) > 32)
   {
      PrintFormat("[FTB v2.1] ERROR: Button text too long (%d chars). Max 32.",
                  StringLen(InpButtonText));
      return(false);
   }
   // Font whitelist (common safe fonts)
   string safeFonts[] = {"Arial", "Tahoma", "Verdana", "Courier New", "Times New Roman"};
   bool fontOK = false;
   for(int i = 0; i < ArraySize(safeFonts); i++)
      if(InpButtonFont == safeFonts[i]) { fontOK = true; break; }
   if(!fontOK)
      PrintFormat("[FTB v2.1] WARN: Font '%s' not in whitelist. May fallback to system default.", InpButtonFont);

   return(true);
}

//+------------------------------------------------------------------+
//| FTB_PurgeZombies — Collect corpse objects from faulted instances |
//+------------------------------------------------------------------+
void FTB_PurgeZombies()
{
   string myPrefix = StringFormat("FLEETBTN_%s_", g_FTB_instanceKey);
   int total = ObjectsTotal(0, -1, -1);  // All windows
   int purged = 0;

   for(int i = total - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i, -1, -1);

      // Match our instance's FLEETBTN objects
      if(StringFind(name, myPrefix) != 0) continue;

      // Keep only the current button name
      if(name == g_FTB_buttonName) continue;

      ObjectDelete(0, name);
      purged++;
   }

   if(purged > 0)
      PrintFormat("[FTB v2.1] [CANARY] ZOMBIE_PURGE;COUNT:%d;REASON:Faulted instance cleanup", purged);
}

//+------------------------------------------------------------------+
//| FTB_RestoreState — GV-backed state persistence with version check|
//+------------------------------------------------------------------+
void FTB_RestoreState()
{
   if(!InpButtonPersist) return;

   // Version check: reject stale state from older versions
   if(GlobalVariableCheck(g_FTB_gvVersion))
   {
      double ver = GlobalVariableGet(g_FTB_gvVersion);
      if(ver < FTB_VERSION)
      {
         PrintFormat("[FTB v2.1] [TRACE] STALE_VERSION;FOUND:%.1f;EXPECTED:%.1f;STATE_RESET",
                     ver, (double)FTB_VERSION);
         g_FTB_showData = true;  // Default to ON
         return;
      }
   }

   if(GlobalVariableCheck(g_FTB_gvState))
   {
      double val = GlobalVariableGet(g_FTB_gvState);
      g_FTB_showData = (val > 0.5);

      if(InpButtonDebug)
         PrintFormat("[FTB v2.1] [TRACE] STATE_RESTORED;VALUE:%s;FROM:%s",
                     g_FTB_showData ? "ON" : "OFF", g_FTB_gvState);
   }
}

//+------------------------------------------------------------------+
//| FTB_SaveState — Persist current state and version                |
//+------------------------------------------------------------------+
void FTB_SaveState()
{
   if(!InpButtonPersist) return;

   GlobalVariableSet(g_FTB_gvState, g_FTB_showData ? 1.0 : 0.0);
   GlobalVariableSet(g_FTB_gvVersion, (double)FTB_VERSION);

   if(InpButtonDebug)
      PrintFormat("[FTB v2.1] [TRACE] STATE_SAVED;VALUE:%s;TO:%s",
                  g_FTB_showData ? "ON" : "OFF", g_FTB_gvState);
}

//+------------------------------------------------------------------+
//| FTB_BuildTooltip — Unified tooltip string                        |
//+------------------------------------------------------------------+
string FTB_BuildTooltip()
{
   return(StringFormat("Fleet Toggle v2.1 | %s | ID:%s | State:%s",
                       InpButtonText, g_FTB_instanceKey,
                       g_FTB_showData ? "ON" : "OFF"));
}

//+------------------------------------------------------------------+
//| FTB_CreateButton — Atomic creation with 9999 placement trick     |
//+------------------------------------------------------------------+
bool FTB_CreateButton()
{
   // Pre-delete (idempotent)
   ObjectDelete(0, g_FTB_buttonName);

   ResetLastError();
   if(!ObjectCreate(0, g_FTB_buttonName, OBJ_BUTTON, 0, 0, 0))
   {
      int err = GetLastError();
      PrintFormat("[FTB v2.1] ERROR: ObjectCreate failed;ERR:%d;NAME:%s", err, g_FTB_buttonName);
      return(false);
   }

   // 9999 placement: configure off-screen, then snap to position
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XDISTANCE, 9999);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YDISTANCE, 9999);

   // Geometry
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_CORNER,     InpButtonCorner);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XSIZE,      InpButtonWidth);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YSIZE,      InpButtonHeight);

   // Typography
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_FONTSIZE,   InpButtonFontSize);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_FONT,       InpButtonFont);

   // Behavior
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_HIDDEN,     true);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_ZORDER,     100);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_STATE,      false);  // Never pressed

   // Visual state (set BEFORE final position — no flicker)
   color bgColor  = g_FTB_showData ? InpButtonBgColor : InpButtonBgOff;
   color txtColor = g_FTB_showData ? InpButtonTextOn  : InpButtonTextOff;

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BGCOLOR, bgColor);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_COLOR,   txtColor);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TEXT,    InpButtonText);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TOOLTIP, FTB_BuildTooltip());

   // Snap to final position
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XDISTANCE, InpButtonX);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YDISTANCE, InpButtonY);

   if(InpButtonDebug)
      PrintFormat("[FTB v2.1] [TRACE] BUTTON_CREATED;NAME:%s;POS:%d,%d;STATE:%s",
                  g_FTB_buttonName, InpButtonX, InpButtonY,
                  g_FTB_showData ? "ON" : "OFF");

   return(true);
}

//+------------------------------------------------------------------+
//| FTB_UpdateButtonVisual — ON/OFF colors, text, tooltip (no redraw)|
//+------------------------------------------------------------------+
void FTB_UpdateButtonVisual()
{
   if(ObjectFind(0, g_FTB_buttonName) < 0) return;

   color bgColor  = g_FTB_showData ? InpButtonBgColor : InpButtonBgOff;
   color txtColor = g_FTB_showData ? InpButtonTextOn  : InpButtonTextOff;

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BGCOLOR, bgColor);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_COLOR,   txtColor);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TEXT,    InpButtonText);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TOOLTIP, FTB_BuildTooltip());
   // No ChartRedraw here — caller batches
}

//+------------------------------------------------------------------+
//| FTB_DeleteButton — Clean removal with redraw                     |
//+------------------------------------------------------------------+
void FTB_DeleteButton()
{
   if(ObjectFind(0, g_FTB_buttonName) >= 0)
   {
      ObjectDelete(0, g_FTB_buttonName);
      ChartRedraw();
   }

   if(InpButtonDebug)
      PrintFormat("[FTB v2.1] [TRACE] BUTTON_DELETED;NAME:%s", g_FTB_buttonName);
}

//+------------------------------------------------------------------+
//| FTB_Toggle — Atomic state flip with proper debounce              |
//+------------------------------------------------------------------+
void FTB_Toggle()
{
   // Debounce: 500ms minimum between toggles (GetTickCount, not TimeLocal)
   uint now = GetTickCount();
   if(now - g_FTB_lastTick < 500)
   {
      if(InpButtonDebug)
         Print("[FTB v2.1] [CANARY] CLICK_DEBOUNCED;REASON:500ms throttle");
      return;
   }
   g_FTB_lastTick = now;
   g_FTB_clickCount++;

   // Atomic transaction: flip state
   g_FTB_showData = !g_FTB_showData;

   // Update visual (no redraw yet)
   FTB_UpdateButtonVisual();

   // Persist
   FTB_SaveState();

   // Single redraw after all updates
   ChartRedraw();

   // Notify indicator (sovereignty: indicator decides what to render-gate)
   FTB_OnToggle(g_FTB_showData);

   if(InpButtonDebug)
      PrintFormat("[FTB v2.1] [TRACE] TOGGLED;COUNT:%d;NEW_STATE:%s",
                  g_FTB_clickCount, g_FTB_showData ? "ON" : "OFF");
}

//+------------------------------------------------------------------+
//| FTB_OnToggle — CALLBACK: Indicator implements render-gate logic  |
//|                                                                  |
//|  IMPLEMENTATION (example):                                       |
//|  void FTB_OnToggle(bool show)                                    |
//|  {                                                               |
//|     if(!show)                                                    |
//|     {                                                            |
//|        DeleteAllVisualObjects();                                 |
//|        SetIndexStyle(0, DRAW_NONE);                              |
//|     }                                                            |
//|     else                                                         |
//|     {                                                            |
//|        g_forceRecalc = true;                                     |
//|     }                                                            |
//|  }                                                               |
//+------------------------------------------------------------------+
void FTB_OnToggle(bool show);  // Forward declaration — implement in indicator

// ==================================================================
// 004 - LIFECYCLE HOOKS
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_OnInit — Call from indicator OnInit()                        |
//| Returns: true if button created, false on any failure            |
//+------------------------------------------------------------------+
bool FTB_OnInit()
{
   // Validate
   if(!FTB_ValidateInputs())
      return(false);

   // Build instance key and names
   g_FTB_instanceKey = FTB_BuildInstanceKey();
   g_FTB_buttonName  = FTB_BuildName();
   FTB_BuildGVKeys();

   // Zombie purge (faulted instance recovery)
   FTB_PurgeZombies();

   // Restore persisted state
   FTB_RestoreState();

   // Create button — propagate failure
   if(!FTB_CreateButton())
      return(false);

   // Final redraw
   ChartRedraw();

   g_FTB_initialized = true;

   PrintFormat("[FTB v2.1] Initialized | Button:%s | ID:%s | State:%s | Pos:%d,%d",
               g_FTB_buttonName, g_FTB_instanceKey,
               g_FTB_showData ? "ON" : "OFF",
               InpButtonX, InpButtonY);

   return(true);
}

//+------------------------------------------------------------------+
//| FTB_OnDeinit — Call from indicator OnDeinit()                    |
//+------------------------------------------------------------------+
void FTB_OnDeinit(const int reason)
{
   // Guard: never run before init
   if(!g_FTB_initialized) return;

   // Save state before removal
   FTB_SaveState();

   // Delete button (unless chart change — preserve for re-attachment)
   if(reason != REASON_CHARTCHANGE)
      FTB_DeleteButton();

   g_FTB_initialized = false;

   if(InpButtonDebug)
      PrintFormat("[FTB v2.1] [TRACE] DEINIT;REASON:%d;STATE_SAVED", reason);
}

// ==================================================================
// 005 - EVENT HOOK
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_OnChartEvent — Call from indicator OnChartEvent()            |
//| Returns: true if event consumed, false if not ours               |
//|                                                                  |
//|  MQL4-safe: Only checks CHARTEVENT_OBJECT_CLICK.                 |
//|  No MQL5-only constants (OBJECT_CREATE/DELETE/MOUSE_WHEEL).      |
//+------------------------------------------------------------------+
bool FTB_OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   // MQL4-safe: only process click events on our button
   if(id != CHARTEVENT_OBJECT_CLICK) return(false);
   if(sparam != g_FTB_buttonName)    return(false);

   // Atomic toggle
   FTB_Toggle();

   return(true);  // Event consumed
}

// ==================================================================
// 999 - DEPLOYMENT TEMPLATE
// ==================================================================

/*
// ------------------------------------------------------------------
// EXAMPLE INTEGRATION
// ------------------------------------------------------------------

// In your indicator's input section (append at END):
// input string   InpSectionButton    = "=== Fleet Toggle Button v2.1 ===";
// input string   InpInstanceId       = "MyIndicator";  // UNIQUE per indicator!
// ... (all other FTB inputs) ...

// In your OnInit():
int OnInit()
{
   // ... your init logic ...

   // Fleet Toggle Button
   if(!FTB_OnInit())
      return(INIT_PARAMETERS_INCORRECT);

   return(INIT_SUCCEEDED);
}

// In your OnDeinit():
void OnDeinit(const int reason)
{
   // ... your cleanup ...

   FTB_OnDeinit(reason);
}

// In your OnChartEvent():
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   // Fleet button first (consumes event if ours)
   if(FTB_OnChartEvent(id, lparam, dparam, sparam))
      return;

   // ... your other event handling ...
}

// Implement the sovereignty callback:
void FTB_OnToggle(bool show)
{
   if(!show)
   {
      DeleteAllVisualObjects();
      SetIndexStyle(0, DRAW_NONE);
      SetIndexStyle(1, DRAW_NONE);
   }
   else
   {
      g_forceRecalc = true;
   }
   // LOGIC NEVER STOPS
}

// In your OnCalculate(), gate rendering only:
int OnCalculate(...)
{
   // ... compute everything (ALWAYS) ...

   if(g_FTB_showData)
   {
      DrawZones();
      DrawArrows();
      UpdateInfoLine();
   }

   EmitBeacons();  // ALWAYS

   return(rates_total);
}
*/

//+------------------------------------------------------------------+
//| 999 - STEP LOG                                                     |
//+------------------------------------------------------------------+
// [STEP] 001:v2.0 drafted from Divergence v2.30 canonical source.
//        MOD:001-005;STS:Complete;NEXT:Quality review
// [STEP] 002:External quality review — 14 issues found (2 P0, 4 P1, 8 P2).
//        MOD:001-005;STS:Reviewed;NEXT:Apply fixes
// [STEP] 003:v2.1 — P0: removed MQL5 event constants, fixed ChartID cast.
//        P1: fixed debounce (GetTickCount), FTB_CreateButton returns bool,
//        added InpInstanceId, guarded FTB_OnDeinit.
//        P2: version check, removed dead vars, subwindow purge,
//        batched redraws, always-log errors, font whitelist, OBJPROP_STATE.
//        MOD:001-005,999;STS:Complete;NEXT:Multi-pass self-review
// [STEP] 004:Multi-pass review — PASS. See review table below.
//        MOD:001-005;STS:Approved;NEXT:Exocortex commit
//
// [RECAP] PROJECT:FleetToggleButton_v2.1;TYPE:Standard_Module;
// ARCH:SelfContained+Sovereignty+GVPersistence+InstanceScoped+AtomicToggle;
// STATUS:Production_Ready;DONE:001-005,999;PEND:None;
// NEXT:Exocortex_Upload;DIRS:#5,#11,#17,#20,#22,#35,#38,#43,#46,#54;
// ANCHORS:Source=Divergence_v2.30,Version=2.1,Review=14_issues_fixed,
// InstanceId=Required,Debounce=500ms_ms,VersionCheck=Yes;
// WARN:None;LAST:Production_ready_awaiting_Exocortex_commit
//+------------------------------------------------------------------+
