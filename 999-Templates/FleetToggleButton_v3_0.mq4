//+------------------------------------------------------------------+
//|                                     FleetToggleButton_v3_0.mq4   |
//|                   FLEET BUTTON STANDARD v1.0 — Reference Hull    |
//|                        "The Sovereign Gate, Remembered"          |
//|                                                                  |
//|  Lineage: v2.1 (Divergence v2.30 canonical) -> v2.2 (forensic    |
//|  pass) -> v3.0 (Fleet Button Standard v1.0, ratified by the      |
//|  Captain after full deliberation dossier, 2026-09-13).           |
//|                                                                  |
//|  DOCTRINE: Button gates RENDERING only. Logic, beacons, alerts,  |
//|  and all computational state ALWAYS run. The fleet never sleeps. |
//|  The button modulates the .set; it never overrides it.           |
//|                                                                  |
//|  v3.0 — STANDARD RULINGS IMPLEMENTED:                            |
//|   R1  Memory grammar: FLEETBTN_{FAMILY}_{SYMBOL} — symbol        |
//|       VERBATIM (zero broker knowledge: BTC, Forex, OTC, any      |
//|       feed works unparsed), NO timeframe segment — "off stays    |
//|       off across TF changes." Keep It Simple.                    |
//|   R2  Persistence by law: default ON at first attach, written    |
//|       back immediately; state written AT CLICK-TIME, never in    |
//|       OnDeinit (survives terminal crash, chart kill, power cut). |
//|   R3  No-collision by design: object identity is per-instance    |
//|       (FLEET_{FAMILY}_{ChartID}_BTN), memory is per desk         |
//|       (family+symbol). Two or two hundred instances mirror one   |
//|       GV. Bar-gated resync heals any divergence within one bar   |
//|       and makes every hull remotely controllable via GV write.   |
//|   R4  Ghost sweep: OnInit deletes family-root button objects     |
//|       from dead ChartID eras (template-archaeology class).       |
//|   R5  Visual grammar: bg #373737/#222222, text aqua/red,         |
//|       OBJPROP_STATE forced false at create AND at every click.   |
//|   R6  Fossil record: tooltip carries FAMILY | state | last       |
//|       toggle time; last-toggle time persisted in its own GV —    |
//|       template exports retain operator intent for the Coding     |
//|       Cluster's Lessons Learned.                                 |
//|   R7  Deferred rebuild: the handler never does engine work; it   |
//|       raises the callback and returns. The .set is senior.       |
//|   R8  Escape hatch: InpSlotSuffix for deliberate per-desk        |
//|       independence when the operator WANTS split memory.         |
//+------------------------------------------------------------------+
#property strict
#property copyright "TeknoLite Fleet — Fleet Button Standard v1.0"
#property version   "3.00"
#property indicator_chart_window
#property indicator_buffers 0

// ==================================================================
// 000 - SELF-TEST HARNESS NOTE                                     |
// This reference hull is ALSO a runnable indicator: attached to a   |
// chart it raises its own button at the configured seat and toggles |
// a demo ink mark, exercising every Standard feature live —         |
// persistence, resync, ghost sweep, palette, fossil tooltip.        |
// Fleet hulls copy modules 001-007 and implement their own          |
// FTB_OnToggle; the harness below is the minimal working example.   |
// ==================================================================

// ==================================================================
// 001 - INPUTS (Fleet Standard — append at END of indicator inputs)
// ==================================================================
// [L2] SCOPE:Inputs;STATE:FROZEN-ORDER;DEPS:NONE;DIRS:#1;ANCHORS:Std=v1.0
//
// POSITIONAL CONTRACT: new inputs append at END only. Existing .set
// files across the fleet must never re-seat.

input string   InpSectionButton    = "=== Fleet Toggle Button v3.0 [STD-1.0] ===";
input string   InpFleetFamily      = "";      // FAMILY registry name (REQUIRED, e.g. "IBIS")
input ENUM_BASE_CORNER InpButtonCorner    = CORNER_RIGHT_LOWER;
input string   InpButtonText       = "FLEET"; // Button label
input string   InpButtonFont       = "Arial";
input int      InpButtonFontSize   = 8;
input color    InpButtonTextOn     = clrAqua;        // 16776960 — Standard C1
input color    InpButtonTextOff    = clrRed;         // 255      — Standard C1
input color    InpButtonBgOn       = C'55,55,55';    // 3618615  — Standard C1
input color    InpButtonBgOff      = C'34,34,34';    // 2236962  — Standard C1
input color    InpButtonBorder     = C'70,70,70';
input int      InpButtonX          = 92;      // Seat registry X (Standard C3)
input int      InpButtonY          = 2;       // Seat registry Y
input int      InpButtonWidth      = 89;      // Standard C3 geometry law
input int      InpButtonHeight     = 21;      // Standard C3 geometry law
input string   InpSlotSuffix       = "";      // R8: deliberate per-desk split (rare)
input bool     InpButtonDebug      = false;

// ==================================================================
// 002 - GLOBALS (Fleet Standard — prefix all with g_FTB_)
// ==================================================================
// [L2] SCOPE:State;STATE:REBUILDABLE;DEPS:001;DIRS:#2;ANCHORS:Truth=GV

string   g_FTB_family;             // Sanitized family registry name
string   g_FTB_buttonName;         // FLEET_{FAMILY}_{cid}_BTN  (object identity)
string   g_FTB_familyRoot;         // FLEET_{FAMILY}_           (ghost sweep root)
string   g_FTB_gvState;            // FLEETBTN_{FAMILY}_{SYMBOL}[_{SLOT}]_State
string   g_FTB_gvWhen;             // ..._When  (fossil record, R6)
string   g_FTB_gvVersion;          // ..._Version (stale-state gate)
bool     g_FTB_showData    = true; // RENDER gate — sovereignty: logic always runs
bool     g_FTB_initialized = false;
uint     g_FTB_lastClick   = 0;    // Debounce (GetTickCount ms, wraparound-safe)
int      g_FTB_clickCount  = 0;
datetime g_FTB_lastBarSeen = 0;    // Bar-gated resync bookkeeping (R3)
datetime g_FTB_lastToggle  = 0;    // Fossil record (R6)

#define FTB_VERSION 3.0

// ==================================================================
// 003 - KEY GRAMMAR
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_SanitizeFamily — family segment must be key-safe             |
//| A-Z 0-9 _ only, uppercased. The family registry lives in the     |
//| Standard document; this guard enforces its alphabet.             |
//+------------------------------------------------------------------+
string FTB_SanitizeFamily(const string raw)
{
   string out = "";
   for(int i = 0; i < StringLen(raw); i++)
   {
      ushort c = StringGetCharacter(raw, i);
      if(c >= 'a' && c <= 'z') c = c - 'a' + 'A';
      if((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '_')
         out += CharToString((uchar)c);
   }
   return(out);
}

//+------------------------------------------------------------------+
//| FTB_BuildKeys — R1 grammar.                                      |
//|   Object identity: FLEET_{FAMILY}_{ChartID}_BTN                  |
//|   Memory:          FLEETBTN_{FAMILY}_{Symbol}[_{Slot}]_{Field}   |
//| Symbol is VERBATIM — the Standard never parses a symbol. Any     |
//| asset, any broker suffix, any feed works unparsed. No TF segment:|
//| "off stays off" across timeframe changes (Captain's ruling A2b). |
//+------------------------------------------------------------------+
bool FTB_BuildKeys()
{
   g_FTB_family     = FTB_SanitizeFamily(InpFleetFamily);
   g_FTB_buttonName = StringFormat("FLEET_%s_%I64d_BTN", g_FTB_family, ChartID());
   g_FTB_familyRoot = StringFormat("FLEET_%s_", g_FTB_family);

   string memBase = StringFormat("FLEETBTN_%s_%s", g_FTB_family, Symbol());
   if(StringLen(InpSlotSuffix) > 0)
      memBase += "_" + FTB_SanitizeFamily(InpSlotSuffix);

   g_FTB_gvState   = memBase + "_State";
   g_FTB_gvWhen    = memBase + "_When";
   g_FTB_gvVersion = memBase + "_Version";

   // MT4 GV name limit: 63 chars. Fail loudly, never truncate silently.
   if(StringLen(g_FTB_gvVersion) > 63)
   {
      PrintFormat("[FTB v3.0] ERROR: GV key too long (%d>63): %s — shorten family or slot.",
                  StringLen(g_FTB_gvVersion), g_FTB_gvVersion);
      return(false);
   }
   return(true);
}

//+------------------------------------------------------------------+
//| FTB_ValidateInputs — fail-fast                                   |
//+------------------------------------------------------------------+
bool FTB_ValidateInputs()
{
   if(StringLen(g_FTB_family) == 0)
   {
      Print("[FTB v3.0] ERROR: InpFleetFamily is empty. The Standard requires ",
            "a registry family name (e.g. IBIS, DLH, BASILISK).");
      return(false);
   }
   if(InpButtonWidth < 20 || InpButtonHeight < 10)
   {
      PrintFormat("[FTB v3.0] ERROR: Button too small (%dx%d). Min 20x10.",
                  InpButtonWidth, InpButtonHeight);
      return(false);
   }
   if(InpButtonFontSize < 6 || InpButtonFontSize > 24)
   {
      PrintFormat("[FTB v3.0] ERROR: Font size %d out of range [6,24].", InpButtonFontSize);
      return(false);
   }
   if(InpButtonX < 0 || InpButtonY < 0)
   {
      PrintFormat("[FTB v3.0] ERROR: Negative seat (%d,%d).", InpButtonX, InpButtonY);
      return(false);
   }
   if(StringLen(InpButtonText) == 0 || StringLen(InpButtonText) > 32)
   {
      PrintFormat("[FTB v3.0] ERROR: Button text length %d out of range [1,32].",
                  StringLen(InpButtonText));
      return(false);
   }
   return(true);
}

// ==================================================================
// 004 - MEMORY (GV-backed persistence — R2)
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_RestoreState — read the desk's memory.                       |
//| Default ON: first attach (or stale version) writes ON back       |
//| immediately, so the key exists from the first breath (R2).       |
//+------------------------------------------------------------------+
void FTB_RestoreState()
{
   bool fresh = false;

   if(GlobalVariableCheck(g_FTB_gvVersion) &&
      GlobalVariableGet(g_FTB_gvVersion) >= FTB_VERSION &&
      GlobalVariableCheck(g_FTB_gvState))
   {
      g_FTB_showData = (GlobalVariableGet(g_FTB_gvState) > 0.5);
      if(GlobalVariableCheck(g_FTB_gvWhen))
         g_FTB_lastToggle = (datetime)GlobalVariableGet(g_FTB_gvWhen);
      if(InpButtonDebug)
         PrintFormat("[FTB v3.0] [TRACE] STATE_RESTORED;KEY:%s;VALUE:%s",
                     g_FTB_gvState, g_FTB_showData ? "ON" : "OFF");
   }
   else
   {
      g_FTB_showData = true;   // eyes-open doctrine
      fresh = true;
      if(InpButtonDebug && GlobalVariableCheck(g_FTB_gvState))
         PrintFormat("[FTB v3.0] [TRACE] STALE_VERSION;EXPECTED:%.1f;STATE_RESET", FTB_VERSION);
   }

   if(fresh) FTB_SaveState();  // first-attach write-back
}

//+------------------------------------------------------------------+
//| FTB_SaveState — persist at click-time (and first attach).        |
//| NEVER called from OnDeinit: a crash must not cost a toggle.      |
//+------------------------------------------------------------------+
void FTB_SaveState()
{
   GlobalVariableSet(g_FTB_gvState,   g_FTB_showData ? 1.0 : 0.0);
   GlobalVariableSet(g_FTB_gvVersion, FTB_VERSION);
   GlobalVariableSet(g_FTB_gvWhen,    (double)g_FTB_lastToggle);
}

//+------------------------------------------------------------------+
//| FTB_ResyncFromMemory — R3 bar-gated resync.                      |
//| Call once per NEW BAR from the indicator's OnCalculate. One GV   |
//| read per bar: negligible. Heals divergence between mirrored      |
//| instances and makes the hull remotely controllable — any script, |
//| EA, or sister chart can flip the desk by writing the GV.         |
//| Returns true if the state changed (callback already fired).      |
//+------------------------------------------------------------------+
bool FTB_ResyncFromMemory(const datetime curBarTime)
{
   if(curBarTime == g_FTB_lastBarSeen) return(false);
   g_FTB_lastBarSeen = curBarTime;

   if(!GlobalVariableCheck(g_FTB_gvState)) return(false);
   bool mem = (GlobalVariableGet(g_FTB_gvState) > 0.5);
   if(mem == g_FTB_showData) return(false);

   g_FTB_showData = mem;
   if(GlobalVariableCheck(g_FTB_gvWhen))
      g_FTB_lastToggle = (datetime)GlobalVariableGet(g_FTB_gvWhen);
   FTB_UpdateButtonVisual();
   FTB_OnToggle(g_FTB_showData);       // sovereignty: indicator re-gates its ink
   ChartRedraw();

   if(InpButtonDebug)
      PrintFormat("[FTB v3.0] [TRACE] RESYNC;NEW_STATE:%s;SOURCE:GV",
                  g_FTB_showData ? "ON" : "OFF");
   return(true);
}

// ==================================================================
// 005 - THE BUTTON (object lifecycle)
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_BuildTooltip — R6 fossil record                              |
//+------------------------------------------------------------------+
string FTB_BuildTooltip()
{
   string when = (g_FTB_lastToggle > 0) ? TimeToString(g_FTB_lastToggle, TIME_DATE|TIME_MINUTES)
                                        : "never";
   return(StringFormat("%s | %s | last toggle: %s",
                       g_FTB_family, g_FTB_showData ? "ON" : "OFF", when));
}

//+------------------------------------------------------------------+
//| FTB_SweepGhosts — R4: family-root archaeology purge.             |
//| Template exports resurrect buttons from dead ChartID eras; a     |
//| hull's own delete-by-name can never reach them. At init we sweep |
//| every FLEET_{FAMILY}_* object that is not our live name. Ships   |
//| sweep ONLY their own family root — a ship that deletes others'   |
//| buttons is a mutiny.                                             |
//+------------------------------------------------------------------+
void FTB_SweepGhosts()
{
   int total = ObjectsTotal(0, -1, -1);   // explicit 3-arg form (b1470 overload trap)
   int purged = 0;
   for(int i = total - 1; i >= 0; i--)
   {
      string nm = ObjectName(0, i, -1, -1);
      if(StringFind(nm, g_FTB_familyRoot) != 0) continue;  // not our family
      if(nm == g_FTB_buttonName) continue;                 // our live button
      if(StringFind(nm, "_BTN") < 0) continue;             // buttons only
      ObjectDelete(0, nm);
      purged++;
   }
   if(purged > 0)
      PrintFormat("[FTB v3.0] [CANARY] GHOST_PURGE;FAMILY:%s;COUNT:%d;REASON:dead-era template objects",
                  g_FTB_family, purged);
}

//+------------------------------------------------------------------+
//| FTB_CreateButton — atomic creation, 9999 placement trick         |
//+------------------------------------------------------------------+
bool FTB_CreateButton()
{
   ObjectDelete(0, g_FTB_buttonName);   // idempotent

   ResetLastError();
   if(!ObjectCreate(0, g_FTB_buttonName, OBJ_BUTTON, 0, 0, 0))
   {
      PrintFormat("[FTB v3.0] [ANOMALY] BUTTON_CREATE_FAILED;ERR:%d;NAME:%s",
                  GetLastError(), g_FTB_buttonName);
      return(false);
   }

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XDISTANCE, 9999);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YDISTANCE, 9999);

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_CORNER,     InpButtonCorner);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XSIZE,      InpButtonWidth);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YSIZE,      InpButtonHeight);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_FONTSIZE,   InpButtonFontSize);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_FONT,       InpButtonFont);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_HIDDEN,     true);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_ZORDER,     100);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_STATE,      false);  // R5: never pressed

   FTB_UpdateButtonVisual();

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_XDISTANCE, InpButtonX);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_YDISTANCE, InpButtonY);
   return(true);
}

//+------------------------------------------------------------------+
//| FTB_UpdateButtonVisual — Standard C1 palette (no redraw; caller  |
//| batches).                                                        |
//+------------------------------------------------------------------+
void FTB_UpdateButtonVisual()
{
   if(ObjectFind(0, g_FTB_buttonName) < 0) return;
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BGCOLOR,
                    g_FTB_showData ? InpButtonBgOn : InpButtonBgOff);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_COLOR,
                    g_FTB_showData ? InpButtonTextOn : InpButtonTextOff);
   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_BORDER_COLOR, InpButtonBorder);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TEXT,    InpButtonText);
   ObjectSetString (0, g_FTB_buttonName, OBJPROP_TOOLTIP, FTB_BuildTooltip());
}

//+------------------------------------------------------------------+
//| FTB_Toggle — the atomic transaction.                             |
//| Order: debounce -> flip -> STAMP TIME -> PERSIST (R2, before any |
//| visual work — a crash after this line still remembers) ->        |
//| force state=false (R5) -> repaint -> callback (R7: the handler   |
//| does no engine work; the callback raises flags) -> one redraw.   |
//+------------------------------------------------------------------+
void FTB_Toggle()
{
   uint now = GetTickCount();
   if(now - g_FTB_lastClick < 500)   // wraparound-safe unsigned subtraction
   {
      if(InpButtonDebug) Print("[FTB v3.0] [CANARY] CLICK_DEBOUNCED;REASON:500ms");
      return;
   }
   g_FTB_lastClick = now;
   g_FTB_clickCount++;

   g_FTB_showData   = !g_FTB_showData;
   g_FTB_lastToggle = TimeCurrent();
   FTB_SaveState();                                    // memory first

   ObjectSetInteger(0, g_FTB_buttonName, OBJPROP_STATE, false);
   FTB_UpdateButtonVisual();

   FTB_OnToggle(g_FTB_showData);                       // sovereignty callback
   ChartRedraw();

   if(InpButtonDebug)
      PrintFormat("[FTB v3.0] [TRACE] TOGGLED;FAMILY:%s;COUNT:%d;STATE:%s",
                  g_FTB_family, g_FTB_clickCount, g_FTB_showData ? "ON" : "OFF");
}

//+------------------------------------------------------------------+
//| FTB_OnToggle — CALLBACK: the indicator implements the ink gate.  |
//| SOVEREIGNTY LAW (E1): publisher hulls gate RENDERING ONLY —      |
//| beacons, alerts, ML learning, journal feeds NEVER sleep. Human-  |
//| layer hulls may gate computation and must declare                |
//| "SOVEREIGNTY: COMPUTE-GATED (no wire)" in the header.            |
//| R7: raise a rebuild flag here; do NOT run engine work in the     |
//| click handler.                                                   |
//+------------------------------------------------------------------+
void FTB_OnToggle(bool show);   // forward declaration — implement in indicator

// ==================================================================
// 006 - LIFECYCLE HOOKS
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_OnInit — call from indicator OnInit()                        |
//| Order: keys -> validate -> ghost sweep -> restore -> create.     |
//+------------------------------------------------------------------+
bool FTB_OnInit()
{
   if(!FTB_BuildKeys())      return(false);
   if(!FTB_ValidateInputs()) return(false);
   FTB_SweepGhosts();
   FTB_RestoreState();
   if(!FTB_CreateButton())   return(false);
   ChartRedraw();
   g_FTB_initialized = true;

   PrintFormat("[FTB v3.0] INIT | %s | key:%s | state:%s | seat:%d,%d",
               g_FTB_buttonName, g_FTB_gvState,
               g_FTB_showData ? "ON" : "OFF", InpButtonX, InpButtonY);
   return(true);
}

//+------------------------------------------------------------------+
//| FTB_OnDeinit — call from indicator OnDeinit().                   |
//| Writes NOTHING (R2). Deletes the button unless chart change.     |
//+------------------------------------------------------------------+
void FTB_OnDeinit(const int reason)
{
   if(!g_FTB_initialized) return;
   if(reason != REASON_CHARTCHANGE)
      ObjectDelete(0, g_FTB_buttonName);
   g_FTB_initialized = false;
   if(InpButtonDebug)
      PrintFormat("[FTB v3.0] [TRACE] DEINIT;REASON:%d;WRITES:none", reason);
}

// ==================================================================
// 007 - EVENT HOOK
// ==================================================================

//+------------------------------------------------------------------+
//| FTB_OnChartEvent — call FIRST from indicator OnChartEvent().     |
//| Returns true if the event was ours (consumed). MQL4-safe: click  |
//| events only, no MQL5-only constants.                             |
//+------------------------------------------------------------------+
bool FTB_OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id != CHARTEVENT_OBJECT_CLICK) return(false);
   if(sparam != g_FTB_buttonName)    return(false);
   FTB_Toggle();
   return(true);
}

// ==================================================================
// 008 - SELF-TEST HARNESS (delete when grafting into a fleet hull) |
// ==================================================================
// [L2] SCOPE:Harness;STATE:DEMO;DEPS:001-007;DIRS:#3;ANCHORS:DemoInk=FLEET_DEMO
// Minimal working example of the sovereignty callback and lifecycle
// wiring. The demo ink is a single text label; OFF deletes it, ON
// raises a recalc flag (R7 deferred rebuild).

string g_demoName = "FLEET_DEMO_INK";
bool   g_demoRecalc = false;

void FTB_OnToggle(bool show)   // sovereignty callback — implementation
{
   if(!show)
   {
      ObjectDelete(0, g_demoName);
   }
   else
   {
      g_demoRecalc = true;   // R7: the engine rebuilds on its next pass
   }
}

void Demo_DrawInk()
{
   ObjectDelete(0, g_demoName);
   if(!g_FTB_showData) return;
   if(!ObjectCreate(0, g_demoName, OBJ_LABEL, 0, 0, 0)) return;
   ObjectSetInteger(0, g_demoName, OBJPROP_CORNER,     InpButtonCorner);
   ObjectSetInteger(0, g_demoName, OBJPROP_XDISTANCE,  InpButtonX);
   ObjectSetInteger(0, g_demoName, OBJPROP_YDISTANCE,  InpButtonY + InpButtonHeight + 4);
   ObjectSetInteger(0, g_demoName, OBJPROP_COLOR,      clrDimGray);
   ObjectSetInteger(0, g_demoName, OBJPROP_FONTSIZE,   7);
   ObjectSetString (0, g_demoName, OBJPROP_FONT,       "Arial");
   ObjectSetString (0, g_demoName, OBJPROP_TEXT,
                    StringFormat("FTB v3.0 self-test | %s | clicks:%d",
                                 g_FTB_family, g_FTB_clickCount));
   ObjectSetInteger(0, g_demoName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, g_demoName, OBJPROP_HIDDEN,     true);
}

int OnInit()
{
   if(StringLen(InpFleetFamily) == 0)
   {
      Print("[FTB v3.0] Self-test harness: set InpFleetFamily (e.g. DEMO) to arm the button.");
      return(INIT_PARAMETERS_INCORRECT);
   }
   if(!FTB_OnInit()) return(INIT_PARAMETERS_INCORRECT);
   g_demoRecalc = true;
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   FTB_OnDeinit(reason);
   ObjectDelete(0, g_demoName);
   ChartRedraw();
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   if(rates_total < 1) return(0);
   ArraySetAsSeries(time, true);

   // R3 bar-gated resync — once per new bar, before drawing:
   FTB_ResyncFromMemory(time[0]);

   if(g_demoRecalc)
   {
      g_demoRecalc = false;
      Demo_DrawInk();
      ChartRedraw();
   }
   return(rates_total);
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(FTB_OnChartEvent(id, lparam, dparam, sparam)) return;  // button first
   // family extras (drag handles etc.) would live here
}

// ==================================================================
// 999 - DEPLOYMENT TEMPLATE
// ==================================================================
/*
// ------------------------------------------------------------------
// EXAMPLE INTEGRATION (publisher hull — sovereignty class)
// ------------------------------------------------------------------

input string InpFleetFamily = "DLH";   // registry name, REQUIRED

int OnInit()
{
   // ... engine init ...
   if(!FTB_OnInit()) return(INIT_PARAMETERS_INCORRECT);
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   FTB_OnDeinit(reason);
   // ... prefix sweep ...
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(FTB_OnChartEvent(id, lparam, dparam, sparam)) return;  // button first
   // ... family extras (drag handles etc.) after ...
}

int OnCalculate(const int rates_total, const int prev_calculated, ...)
{
   // ... engine computes ALWAYS ...

   // R3 bar-gated resync — once per new bar, before drawing:
   FTB_ResyncFromMemory(time[0]);

   if(g_FTB_showData) { DrawZones(); UpdateHUD(); }   // ink gate

   EmitBeacons();   // ALWAYS — the fleet never sleeps
   return(rates_total);
}

void FTB_OnToggle(bool show)
{
   if(!show) DeleteAllInk();        // sparing the button
   else      g_forceRecalc = true;  // R7: deferred rebuild
}

// ------------------------------------------------------------------
// CONFORMANCE CHECKLIST (FLEETBTN-STD v1.0)
// [ ]  1. InpFleetFamily set to a registry name
// [ ]  2. Memory key FLEETBTN_{FAMILY}_{SYMBOL} — verbatim, no TF
// [ ]  3. Default ON + first-attach write-back
// [ ]  4. Write at click-time; OnDeinit writes nothing
// [ ]  5. Ghost sweep by family root at init
// [ ]  6. OBJPROP_STATE forced false at create and click
// [ ]  7. Palette bg #373737/#222222, text aqua/red
// [ ]  8. Tooltip fossil record (family | state | last toggle)
// [ ]  9. Bar-gated resync wired in OnCalculate
// [ ] 10. Sovereignty: rendering gated, beacons never sleep
// ------------------------------------------------------------------
*/

//| ### 998 - ROLLING STEP LOG (FIFO, last 3)
// [S1] v2.1: canonical module from Divergence v2.30 lineage.
// [S2] v2.2: forensic pass — 6 fixes (persist scope, redraw order,
//      collision warn, version gate, border color, tooltip).
// [S3] v3.0: FLEET BUTTON STANDARD v1.0 — Captain's rulings R1-R8:
//      family+symbol memory (verbatim symbol, no TF), write-at-click,
//      bar-gated resync, ghost sweep, palette law, fossil tooltip,
//      deferred rebuild, slot escape hatch. "The Sovereign Gate,
//      Remembered." + self-test harness (module 008) — the reference
//      hull compiles and runs standalone.
//+------------------------------------------------------------------+
