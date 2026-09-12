//+------------------------------------------------------------------+
//|                                     FleetToggleButton_v2_2.mq4   |
//|                        Fleet Standard Toggle Button v2.2         |
//|                        "The Sovereign Gate"                      |
//|                                                                  |
//|  Based on: v2.1 (Divergence Confluence v2.30 canonical lineage)  |
//|  Reviewed: Zhilin forensic review 2026-09-13 (6 findings fixed)  |
//|  Status:   Production-ready for Exocortex commit                 |
//|                                                                  |
//|  DOCTRINE: Button gates RENDERING only. Logic, beacons, alerts,  |
//|  and all computational state ALWAYS run. The fleet never sleeps. |
//|                                                                  |
//|  v2.2 2026-09-13 - Forensic review fixes:                        |
//|   H1: Persistence scope enum - GLOBAL keys survive restarts      |
//|       (ChartID-keyed GVs silently reset on terminal restart)     |
//|   M1: ChartRedraw moved AFTER FTB_OnToggle - callback visual     |
//|       work renders in the SAME frame (was one tick late)         |
//|   M2: Collision warning when pre-existing button shares our name |
//|   L1: Missing version GV now treated as stale (was unchecked)    |
//|   L2: InpButtonBorderColor input added (OBJPROP_BORDER_COLOR)    |
//|   L3: Tooltip simplified - raw ChartID digits removed            |
//+------------------------------------------------------------------+

// ==================================================================
// 001 - INPUTS (Fleet Standard - append at END of indicator inputs)
// ==================================================================

// [L1] Persistence scope for GV state keys:
//   FTB_SCOPE_CHART  - keyed "{ChartID}_{InstanceId}": per-chart isolation,
//                      survives timeframe change + reload, NOT terminal restart
//                      (ChartID is reassigned when a chart reopens).
//   FTB_SCOPE_GLOBAL - keyed "{InstanceId}": stable FOREVER across restarts,
//                      shared by every chart running the same InstanceId.
//   Choose GLOBAL when the operator wants "set once, remembered always";
//   choose CHART when different charts need independent visual states.
// [L2] SCOPE:Inputs;STATE:Active;DIRS:#4,#16,#46;ANCHORS:Default=GLOBAL;NEXT:Validation
enum ENUM_FTB_PERSIST_SCOPE
{
   FTB_SCOPE_CHART  = 0,   // Per-chart state (dies with chart)
   FTB_SCOPE_GLOBAL = 1    // Terminal-wide state (survives restart)
};

input string   InpSectionButton    = "=== Fleet Toggle Button v2.2 ===";
input ENUM_BASE_CORNER InpButtonCorner    = CORNER_RIGHT_UPPER;
input string   InpButtonText       = "FLEET";           // Button label
input string   InpButtonFont       = "Arial";
input int      InpButtonFontSize   = 8;
input color    InpButtonTextOn     = clrAqua;           // 16776960
input color    InpButtonTextOff    = clrRed;            // 255
input color    InpButtonBgColor    = C'40,40,40';       // 6908265
input color    InpButtonBgOff      = C'20,20,20';       // 5197615
input color    InpButtonBorderColor= C'70,70,70';       // L2 fix: explicit border
input int      InpButtonX          = 92;
input int      InpButtonY          = 2;                 // Stack position
input int      InpButtonWidth      = 89;
input int      InpButtonHeight     = 21;
input string   InpInstanceId       = "";                // Unique per indicator (multi-instance)
input bool     InpButtonPersist    = true;              // GV state persistence
input ENUM_FTB_PERSIST_SCOPE InpPersistScope = FTB_SCOPE_GLOBAL; // H1 fix
input bool     InpButtonDebug      = false;             // Debug telemetry

// ==================================================================
// 002 - GLOBALS (Fleet Standard - prefix all with g_FTB_)
// ==================================================================

string   g_FTB_buttonName;           // ChartID + InstanceId scoped name
string   g_FTB_instanceKey;          // Object-name key (always chart-scoped)
string   g_FTB_persistKey;           // GV key (chart- or global-scoped per input)
bool     g_FTB_showData    = true;   // RENDER gate (sovereignty: logic always runs)
bool     g_FTB_initialized = false;  // Init guard for deinit safety
uint     g_FTB_lastTick    = 0;      // Debounce: GetTickCount() ms
int      g_FTB_clickCount  = 0;      // Debug counter

// GV persistence keys (built in OnInit)
string   g_FTB_gvState;              // "FLEETBTN_{PersistKey}_State"
string   g_FTB_gvVersion;            // "FLEETBTN_{PersistKey}_Version"

// Module version - checked on restore
#define FTB_VERSION 2.2

// ==================================================================
// 003 - CORE MODULE
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_BuildInstanceKey - ChartID + optional InstanceId             |
//| Used for OBJECT names: objects live on one chart, so the key     |
//| must always be chart-scoped regardless of persistence scope.     |
//+------------------------------------------------------------------+
string FTB_BuildInstanceKey()
{
   if(StringLen(InpInstanceId) > 0)
      return(StringFormat("%I64d_%s", ChartID(), InpInstanceId));
   return(StringFormat("%I64d", ChartID()));
}

//+------------------------------------------------------------------+
//| FTB_BuildPersistKey - H1 fix: scope-aware GV key                 |
//| CHART  scope -> same as instance key (per-chart isolation)       |
//| GLOBAL scope -> InstanceId only (survives terminal restart;      |
//|                 falls back to chart key if InstanceId is empty)  |
//+------------------------------------------------------------------+
string FTB_BuildPersistKey()
{
   if(InpPersistScope == FTB_SCOPE_GLOBAL && StringLen(InpInstanceId) > 0)
      return(InpInstanceId);
   return(g_FTB_instanceKey);
}

//+------------------------------------------------------------------+
//| FTB_BuildName - Unique button name                               |
//+------------------------------------------------------------------+
string FTB_BuildName()
{
   return(StringFormat("FLEETBTN_%s_BTN", g_FTB_instanceKey));
}

//+------------------------------------------------------------------+
//| FTB_BuildGVKeys - GlobalVariable persistence keys                |
//+------------------------------------------------------------------+
void FTB_BuildGVKeys()
{
   g_FTB_persistKey = FTB_BuildPersistKey();
   g_FTB_gvState    = StringFormat("FLEETBTN_%s_State",   g_FTB_persistKey);
   g_FTB_gvVersion  = StringFormat("FLEETBTN_%s_Version", g_FTB_persistKey);
}

//+------------------------------------------------------------------+
//| FTB_ValidateInputs - Fail-fast on invalid parameters             |
//+------------------------------------------------------------------+
bool FTB_ValidateInputs()
{
   if(InpButtonWidth < 20 || InpButtonHeight < 10)
   {
      PrintFormat("[FTB v2.2] ERROR: Button too small (%dx%d). Min 20x10.",
                  InpButtonWidth, InpButtonHeight);
      return(false);
   }
   if(InpButtonFontSize < 6 || InpButtonFontSize > 24)
   {
      PrintFormat("[FTB v2.2] ERROR: Font size %d out of range [6,24].",
                  InpButtonFontSize);
      return(false);
   }
   if(InpButtonX < 0 || InpButtonY < 0)
   {
      PrintFormat("[FTB v2.2] ERROR: Negative position (%d,%d).",
                  InpButtonX, InpButtonY);
      return(false);
   }
   if(StringLen(InpButtonText) == 0)
   {
      Print("[FTB v2.2] ERROR: Empty button text.");
      return(false);
   }
   if(StringLen(InpButtonText) > 32)
   {
      PrintFormat("[FTB v2.2] ERROR: Button text too long (%d chars). Max 32.",
                  StringLen(InpButtonText));
      return(false);
   }
   // GLOBAL persistence requires a stable InstanceId - warn, don't fail,
   // because single-indicator use with chart scope fallback is legitimate.
   if(InpButtonPersist && InpPersistScope == FTB_SCOPE_GLOBAL &&
      StringLen(InpInstanceId) == 0)
   {
      Print("[FTB v2.2] WARN: GLOBAL persist scope with empty InpInstanceId - ",
            "falling back to chart-scoped key. Set InpInstanceId for restart-proof state.");
   }

   // Font whitelist (common safe fonts)
   string safeFonts[] = {"Arial", "Tahoma", "Verdana", "Courier New", "Times New Roman"};
   bool fontOK = false;
   for(int i = 0; i < ArraySize(safeFonts); i++)
      if(InpButtonFont == safeFonts[i]) { fontOK = true; break; }
   if(!fontOK)
      PrintFormat("[FTB v2.2] WARN: Font '%s' not in whitelist. May fallback to system default.", InpButtonFont);

   return(true);
}

//+------------------------------------------------------------------+
//| FTB_PurgeZombies - Collect corpse objects from faulted instances |
//+------------------------------------------------------------------+
void FTB_PurgeZombies()
{
   string myPrefix = StringFormat("FLEETBTN_%s_", g_FTB_instanceKey);
   int total = ObjectsTotal(0, -1, -1);  // All windows (explicit 3-arg: b1470 overload trap)
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
      PrintFormat("[FTB v2.2] [CANARY] ZOMBIE_PURGE;COUNT:%d;REASON:Faulted instance cleanup", purged);
}

//+------------------------------------------------------------------+
//| FTB_CheckCollision - M2 fix: detect name hijack risk             |
//| A pre-existing button with our exact name at init means either   |
//| (a) legitimate REASON_CHARTCHANGE reattach, or (b) a second live |
//| indicator with a colliding (usually empty) InstanceId. Case (b)  |
//| silently hijacks clicks. We cannot distinguish the two in OnInit,|
//| so we warn loudly - collision harm is silent, warning is cheap.  |
//+------------------------------------------------------------------+
void FTB_CheckCollision()
{
   if(ObjectFind(0, g_FTB_buttonName) < 0) return;

   PrintFormat("[FTB v2.2] WARN: Button '%s' already exists at init. ",
               g_FTB_buttonName,
               "If this is NOT a timeframe-change reattach, another indicator ",
               "shares this name - set a unique InpInstanceId on each instance.");
}

//+------------------------------------------------------------------+
//| FTB_RestoreState - GV-backed state persistence with version check|
//| L1 fix: missing version GV is now treated as STALE (state reset  |
//| to ON) instead of silently trusting an unversioned state GV.     |
//+------------------------------------------------------------------+
void FTB_RestoreState()
{
   if(!InpButtonPersist) return;

   // Version gate: missing OR older version => reject stale state
   if(!GlobalVariableCheck(g_FTB_gvVersion))
   {
      if(GlobalVariableCheck(g_FTB_gvState))
         PrintFormat("[FTB v2.2] [TRACE] STALE_VERSION;FOUND:None;EXPECTED:%.1f;STATE_RESET",
                     (double)FTB_VERSION);
      g_FTB_showData = true;  // Default to ON
      return;
   }

   double ver = GlobalVariableGet(g_FTB_gvVersion);
   if(ver < FTB_VERSION)
   {
      PrintFormat("[FTB v2.2] [TRACE] STALE_VERSION;FOUND:%.1f;EXPECTED:%.1f;STATE_RESET",
                  ver, (double)FTB_VERSION);
      g_FTB_showData = true;  // Default to ON
      return;
   }

   if(GlobalVariableCheck(g_FTB_gvState))
   {
      double val = GlobalVariableGet(g_FTB_gvState);
      g_FTB_showData = (val > 0.5);

      if(InpButtonDebug)
         PrintFormat("[FTB v2.2] [TRACE] STATE_RESTORED;VALUE:%s;FROM:%s;SCOPE:%s",
                     g_FTB_showData ? "ON" : "OFF", g_FTB_gvState,
                     InpPersistScope == FTB_SCOPE_GLOBAL ? "GLOBAL" : "CHART");
   }
}

//+------------------------------------------------------------------+
//| FTB_SaveState - Persist current state and version                |
//+------------------------------------------------------------------+
void FTB_SaveState()
{
   if(!InpButtonPersist) return;

   GlobalVariableSet(g_FTB_gvState, g_FTB_showData ? 1.0 : 0.0);
   GlobalVariableSet(g_FTB_gvVersion, (double)FTB_VERSION);

   if(InpButtonDebug)
      PrintFormat("[FTB v2.2] [TRACE] STATE_SAVED;VALUE:%s;TO:%s",
                  g_FTB_showData ? "ON" : "OFF", g_FTB_gvState);
}

//+------------------------------------------------------------------+
//| FTB_BuildTooltip - L3 fix: label + state only, no raw ChartID    |
//+------------------------------------------------------------------+
string FTB_BuildTooltip()
{
   return(StringFormat("Fleet Toggle v2.2 | %s | State:%s",
                       InpButtonText, g_FTB_showData ? "ON" : "OFF"));
}

//+------------------------------------------------------------------+
//| FTB_CreateButton - Atomic creation with 9999 placement trick     |
//+------------------------------------------------------------------+
bool FTB_CreateButton()
{
   // Pre-delete (idempotent)
   ObjectDelete(0, g_FTB_buttonName);

   ResetLastError();
   if(!ObjectCreate(0, g_FTB_buttonName, OBJ_BUTTON, 0, 0, 0))
   {
      int err = GetLastError();
      PrintFormat("[FTB v2.2] ERROR: ObjectCreate failed;ERR:%d;NAME:%s", err, g_FTB_buttonName);
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

   // Visual state (set BEFORE final position - no flicker)
   color bgColor  = g_FTB_showData ? InpButtonBgColor : InpButtonBgOff;
   color txtColor = g_FTB_showData ? InpButtonTextOn  : InpButtonTextOff;

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BGCOLOR,      bgColor);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_COLOR,        txtColor);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BORDER_COLOR, InpButtonBorderColor); // L2 fix
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TEXT,         InpButtonText);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TOOLTIP,      FTB_BuildTooltip());

   // Snap to final position
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XDISTANCE, InpButtonX);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YDISTANCE, InpButtonY);

   if(InpButtonDebug)
      PrintFormat("[FTB v2.2] [TRACE] BUTTON_CREATED;NAME:%s;POS:%d,%d;STATE:%s",
                  g_FTB_buttonName, InpButtonX, InpButtonY,
                  g_FTB_showData ? "ON" : "OFF");

   return(true);
}

//+------------------------------------------------------------------+
//| FTB_UpdateButtonVisual - ON/OFF colors, text, tooltip (no redraw)|
//+------------------------------------------------------------------+
void FTB_UpdateButtonVisual()
{
   if(ObjectFind(0, g_FTB_buttonName) < 0) return;

   color bgColor  = g_FTB_showData ? InpButtonBgColor : InpButtonBgOff;
   color txtColor = g_FTB_showData ? InpButtonTextOn  : InpButtonTextOff;

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BGCOLOR,      bgColor);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_COLOR,        txtColor);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BORDER_COLOR, InpButtonBorderColor);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TEXT,         InpButtonText);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TOOLTIP,      FTB_BuildTooltip());
   // No ChartRedraw here - caller batches
}

//+------------------------------------------------------------------+
//| FTB_DeleteButton - Clean removal with redraw                     |
//+------------------------------------------------------------------+
void FTB_DeleteButton()
{
   if(ObjectFind(0, g_FTB_buttonName) >= 0)
   {
      ObjectDelete(0, g_FTB_buttonName);
      ChartRedraw();
   }

   if(InpButtonDebug)
      PrintFormat("[FTB v2.2] [TRACE] BUTTON_DELETED;NAME:%s", g_FTB_buttonName);
}

//+------------------------------------------------------------------+
//| FTB_Toggle - Atomic state flip with proper debounce              |
//| M1 fix: ChartRedraw is now the LAST operation. The callback      |
//| FTB_OnToggle() typically deletes/redraws indicator visuals;      |
//| redrawing before it left those changes invisible for one tick.   |
//| Order: flip -> button visual -> persist -> callback -> redraw.   |
//+------------------------------------------------------------------+
void FTB_Toggle()
{
   // Debounce: 500ms minimum between toggles (GetTickCount, unsigned
   // subtraction is wraparound-safe across the ~49.7 day uint rollover)
   uint now = GetTickCount();
   if(now - g_FTB_lastTick < 500)
   {
      if(InpButtonDebug)
         Print("[FTB v2.2] [CANARY] CLICK_DEBOUNCED;REASON:500ms throttle");
      return;
   }
   g_FTB_lastTick = now;
   g_FTB_clickCount++;

   // Atomic transaction: flip state
   g_FTB_showData = !g_FTB_showData;

   // Update button visual (no redraw yet)
   FTB_UpdateButtonVisual();

   // Persist
   FTB_SaveState();

   // Notify indicator FIRST - sovereignty: indicator decides what to
   // render-gate. Its object deletions/creations must be included in
   // the single batched redraw below. (M1 fix)
   FTB_OnToggle(g_FTB_showData);

   // Single redraw after ALL updates (button + indicator visuals)
   ChartRedraw();

   if(InpButtonDebug)
      PrintFormat("[FTB v2.2] [TRACE] TOGGLED;COUNT:%d;NEW_STATE:%s",
                  g_FTB_clickCount, g_FTB_showData ? "ON" : "OFF");
}

//+------------------------------------------------------------------+
//| FTB_OnToggle - CALLBACK: Indicator implements render-gate logic  |
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
void FTB_OnToggle(bool show);  // Forward declaration - implement in indicator

// ==================================================================
// 004 - LIFECYCLE HOOKS
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_OnInit - Call from indicator OnInit()                        |
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

   // M2: collision detection BEFORE we touch anything
   FTB_CheckCollision();

   // Zombie purge (faulted instance recovery)
   FTB_PurgeZombies();

   // Restore persisted state
   FTB_RestoreState();

   // Create button - propagate failure
   if(!FTB_CreateButton())
      return(false);

   // Final redraw
   ChartRedraw();

   g_FTB_initialized = true;

   PrintFormat("[FTB v2.2] Initialized | Button:%s | ID:%s | Persist:%s | State:%s | Pos:%d,%d",
               g_FTB_buttonName, g_FTB_instanceKey,
               InpPersistScope == FTB_SCOPE_GLOBAL ? "GLOBAL" : "CHART",
               g_FTB_showData ? "ON" : "OFF",
               InpButtonX, InpButtonY);

   return(true);
}

//+------------------------------------------------------------------+
//| FTB_OnDeinit - Call from indicator OnDeinit()                    |
//+------------------------------------------------------------------+
void FTB_OnDeinit(const int reason)
{
   // Guard: never run before init
   if(!g_FTB_initialized) return;

   // Save state before removal
   FTB_SaveState();

   // Delete button (unless chart change - preserve for re-attachment)
   if(reason != REASON_CHARTCHANGE)
      FTB_DeleteButton();

   g_FTB_initialized = false;

   if(InpButtonDebug)
      PrintFormat("[FTB v2.2] [TRACE] DEINIT;REASON:%d;STATE_SAVED", reason);
}

// ==================================================================
// 005 - EVENT HOOK
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_OnChartEvent - Call from indicator OnChartEvent()            |
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
// input string   InpSectionButton    = "=== Fleet Toggle Button v2.2 ===";
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
//| 999 - STEP LOG                                                   |
//+------------------------------------------------------------------+
// [STEP] 001:v2.0 drafted from Divergence v2.30 canonical source.
//        MOD:001-005;STS:Complete;NEXT:Quality review
// [STEP] 002:External quality review - 14 issues found (2 P0, 4 P1, 8 P2).
//        MOD:001-005;STS:Reviewed;NEXT:Apply fixes
// [STEP] 003:v2.1 - P0/P1/P2 fixes applied; production-ready.
//        MOD:001-005,999;STS:Complete;NEXT:Exocortex commit
// [STEP] 004:Zhilin forensic review 2026-09-13 - 6 findings
//        (H1 persist-scope, M1 redraw-order, M2 collision, L1-L3).
//        MOD:ALL;STS:Reviewed;NEXT:Apply v2.2 fixes
// [STEP] 005:v2.2 - All 6 fixes applied. H1: ENUM_FTB_PERSIST_SCOPE
//        (GLOBAL keys survive restart). M1: ChartRedraw after callback.
//        M2: FTB_CheckCollision warn. L1: missing version GV = stale.
//        L2: InpButtonBorderColor. L3: tooltip simplified.
//        MOD:001-005;STS:Complete;NEXT:Exocortex commit
//
// [RECAP] PROJECT:FleetToggleButton_v2.2;TYPE:Standard_Module;
// ARCH:SelfContained+Sovereignty+ScopedGVPersistence+InstanceScoped+AtomicToggle;
// STATUS:Production_Ready;DONE:001-005,999;PEND:None;
// NEXT:Fleet_Integration;DIRS:#4,#16,#19,#38,#43,#44;
// ANCHORS:Source=v2.1,Version=2.2,Review=Zhilin_2026-09-13,Fixes=6,
// PersistScope=GLOBAL_default,Debounce=500ms,VersionGate=Strict;
// WARN:Collision_warn_only_not_enforced;LAST:v2.2_committed_to_Exocortex
//+------------------------------------------------------------------+
