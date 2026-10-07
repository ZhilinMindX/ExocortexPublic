# CODE INVENTORY — TeknoLite Fleet Reference Archive
**Version:** 1.1 · **Date:** 2026-10-08 · **Doctrine:** FLEET_STANDARD v1.1 (R1–R8, T1–T5)

> **Purpose.** This is the Fleet's inventory of *good ideas found along the way*.
> Each entry follows the same anatomy:
>
> 1. **IDEA** — what the idea is and why it earned a place here.
> 2. **ORIGINAL** — the verbatim artifact, untouched, as found in the wild
>    or as first inducted into the Fleet. Never paraphrased: drift begins
>    at transcription.
> 3. **FLEET RENDERING** — our enhancements, improvements and
>    optimizations, *explicitly separated* from the original, each tagged
>    `[ENH]` enhancement / `[IMP]` improvement / `[OPT]` optimization,
>    with the governing Lesson or Ruling cited.
>
> **Snippets vs. Hulls.** A **SNIPPET** (this document) is a reusable
> *part* — a module, pattern, or idiom meant to be grafted into many
> hulls. A **HULL** (`Fleet_Hulls/`) is a *whole code*, preserved
> complete at a frozen version. Snippets are stored as they mature;
> hulls are stored when the Captain rules them final.

---

## SNIPPET #001 — THE FLEET STANDARD BUTTON

**State:** FROZEN (template v3.2) · **Governing doctrine:** FLEET_STANDARD R1–R8 · **Ledger:** LESSONS_LEARNED #1, #2, #8, #17, #20

### IDEA

A single, canonical toggle button that gates **rendering only** — the
engine, state machines, and beacons keep running when the ink is off
(sovereignty). One geometry law (89×21), one palette law, one seat
registry, chart-scoped object identity, and (in the Fleet rendering)
cross-chart GV memory so a desk of hulls can be commanded remotely.

### ORIGINAL — verbatim, as inducted in `Divergence_Confluence_v2.3.mq4`

The canonical module's first fleet incarnation ("byte-equivalent" era):
chart-local state, no memory, no debounce, no ghost sweep, no tooltip.
This is the **starting point of all our button work** — preserved exactly
as it stands in the Divergences hull, including its own failure fossil
(the button that deleted itself).

```mql4
//--- Button inputs (Divergence_Confluence v2.3, lines 129-141)
input string   InpSectionButton = "=== Toggle Button ===";
input ENUM_BASE_CORNER InpButtonCorner  = CORNER_RIGHT_UPPER;
input string InpButtonText      = "Divergence";
input string InpButtonFont      = "Arial";
input int    InpButtonFontSize  = 8;
input color  InpButtonTextOn    = 16776960;
input color  InpButtonTextOff   = 255;
input color  InpButtonBgColor   = 6908265;
input color  InpButtonBgOff     = 5197615;
input int    InpButtonX         = 92;
input int    InpButtonY         = 2;
input int    InpButtonWidth     = 89;
input int    InpButtonHeight    = 21;

//--- Fleet state (lines 192-194)
bool   g_showData = true;        // button gates RENDERING only
bool   g_forceRecalc = false;    // toggle-ON: full re-render of scan window
string g_buttonName = "";

//+------------------------------------------------------------------+
//| Canonical standard toggle button (fleet module, byte-equivalent) |
//+------------------------------------------------------------------+
void CreateButton()
{
   ObjectDelete(0, g_buttonName);
   if(!ObjectCreate(0, g_buttonName, OBJ_BUTTON, 0, 0, 0))
      return;

   ObjectSetInteger(0, g_buttonName, OBJPROP_XDISTANCE, 9999);
   ObjectSetInteger(0, g_buttonName, OBJPROP_YDISTANCE, 9999);
   ObjectSetInteger(0, g_buttonName, OBJPROP_CORNER,     InpButtonCorner);
   ObjectSetInteger(0, g_buttonName, OBJPROP_XSIZE,      InpButtonWidth);
   ObjectSetInteger(0, g_buttonName, OBJPROP_YSIZE,      InpButtonHeight);
   ObjectSetInteger(0, g_buttonName, OBJPROP_FONTSIZE,   InpButtonFontSize);
   ObjectSetInteger(0, g_buttonName, OBJPROP_COLOR,      InpButtonTextOn);
   ObjectSetInteger(0, g_buttonName, OBJPROP_BGCOLOR,    InpButtonBgColor);
   ObjectSetInteger(0, g_buttonName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, g_buttonName, OBJPROP_HIDDEN,     true);
   ObjectSetString(0, g_buttonName, OBJPROP_FONT, InpButtonFont);
   ObjectSetString(0, g_buttonName, OBJPROP_TEXT, InpButtonText);
   ObjectSetInteger(0, g_buttonName, OBJPROP_XDISTANCE, InpButtonX);
   ObjectSetInteger(0, g_buttonName, OBJPROP_YDISTANCE, InpButtonY);
   ChartRedraw();
}

void UpdateButtonVisual()
{
   if(ObjectFind(0, g_buttonName) < 0) return;
   color bgColor  = g_showData ? InpButtonBgColor : InpButtonBgOff;
   color txtColor = g_showData ? InpButtonTextOn  : InpButtonTextOff;
   ObjectSetInteger(0, g_buttonName, OBJPROP_BGCOLOR, bgColor);
   ObjectSetInteger(0, g_buttonName, OBJPROP_COLOR,   txtColor);
   ChartRedraw();
}

//+------------------------------------------------------------------+
//| OnChartEvent - button toggles RENDERING only (logic+beacon live) |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CREATE || id == CHARTEVENT_OBJECT_DELETE) return;
   if(id == CHARTEVENT_MOUSE_MOVE    || id == CHARTEVENT_MOUSE_WHEEL)   return;
   if(id != CHARTEVENT_OBJECT_CLICK) return;
   if(sparam != g_buttonName) return;

   g_showData = !g_showData;
   UpdateButtonVisual();

   if(!g_showData)
   {
      DeleteAllObjects();   // purge rendering; logic + beacon keep running
      ChartRedraw();
   }
   else
   {
      g_forceRecalc = true; // next OnCalculate re-renders the scan window
      ChartRedraw();
   }
}

//+------------------------------------------------------------------+
void DeleteAllObjects()
{
   // [v2.11 FIX] ObjectsDeleteAll(0, g_prefix) also killed the BUTTON
   // (its name shares the prefix) — the button deleted itself on toggle.
   // Manual sweep now spares it (same pattern as CustomTF deleteCandles).
   for(int i = ObjectsTotal(0, 0, -1) - 1; i >= 0; i--)
   {
      string name = ObjectName(0, i, 0, -1);
      if(StringFind(name, g_prefix) == 0 && name != g_buttonName)
         ObjectDelete(0, name);
   }
}
```

**What the original already got right** (doctrine seeds, pre-Standard):

- Sovereignty: *"gates RENDERING only; logic + beacon stay alive."*
- Geometry law: 89×21, seat registry X=92.
- Event-filter hygiene in OnChartEvent (early-returns before the click test).
- The self-deletion fossil preserved in comments (Lesson #8 discipline
  before Lesson #8 existed).
- Failure fossil of the prefix-kill bug → button-sparing manual sweep.

### FLEET RENDERING — template v3.2 (`Fleet_Hulls/FleetToggleButton_v3_2.mq4`)

Everything below is **ours**, layered on the original. Full verbatim
module lives in the hull file; this table is the delta map.

| # | Tag | Change | Origin / Law |
|---|-----|--------|--------------|
| 1 | `[ENH]` | **GV memory grammar** `FLEETBTN_{FAMILY}_{SYMBOL}[_{SLOT}]_State/_When/_Version` — cross-chart desk command, state survives reloads | R1, R2 |
| 2 | `[ENH]` | **FTB_ResyncFromMemory** — bar-gated GV resync in OnCalculate: remote charts toggle this one | R3 |
| 3 | `[ENH]` | **FAMILY registry + sanitize** — `InpFleetFamily`, uppercase/alnum/underscore enforcement, 63-char GV key validation | R4, b1470 limit |
| 4 | `[ENH]` | **Ghost sweep** (`FTB_SweepGhosts`) — orphaned `FLEET_{FAMILY}_*_BTN` objects purged at init | Lesson #17 (fresh-chart law) |
| 5 | `[ENH]` | **Tooltip with last-toggle timestamp** | desk ergonomics |
| 6 | `[IMP]` | **Debounced toggle** (500 ms, wraparound-safe `GetTickCount`) | Lesson #2 |
| 7 | `[IMP]` | **OBJPROP_STATE forced false** after click — button never sticks pressed | field report |
| 8 | `[IMP]` | **Explicit 3-arg `ObjectsTotal(0,-1,-1)` / `ObjectName(0,i,-1,-1)`** — b1470 overload trap closed | Lesson #1 |
| 9 | `[IMP]` | **Sovereignty callback** `FTB_OnToggle(show)` — hull decides ink fate; module never reaches into engine | R7 |
| 10 | `[OPT]` | **Version-gated memory restore** (`FTB_VERSION` 3.0 frozen) — stale-format GV memory rejected, desk resets avoided | R5 |
| 11 | `[OPT]` | **Off-screen spawn then seat** (9999→seat) — no flash at 0,0 | original pattern, formalized |
| 12 | `[ENH]` | **Telemetry** — `[TRACE]` toggles/resyncs, `[CANARY]` ghost purges, `[ANOMALY]` create failures; `InpButtonDebug` gate | T1–T5 codicil |
| 13 | `[IMP]` | **Explicit `OBJPROP_BORDER_TYPE = BORDER_RAISED` at create** — the Fleet bevel is codified form law, never a relied-upon terminal default | L32 corollary (Form vs Function), v3.2-F1 |
| 14 | `[IMP]` | **Log-tag = build parity** — every log line names the actual build (`[FTB v3.2]`) | L23 (Representation Parity), v3.2-F2 |
| 15 | `[ENH]` | **One-family-per-chart ruling documented in R3** — multi-desk split is R8 slot suffix, never a second family on one chart | L26, v3.2-F3 |

**Known corrections still open** (debt register cross-ref):

- OBJPROP_STATE persistence scheme (Dadas debt) — under observation.
- In-handler rebuild temptation — sovereignty callback must stay
  flag-only (DLH debt).
- Palette inversions on clone — verify C1 colors after every graft.

---

## SNIPPET #002 — CHRONOLOGICAL NORMALIZATION *(provisional — structure approved, content pending Wave-2 unification)*

**Source:** `MarkitTick Trident_Swing_Projector v1.01` (CC BY-NC-SA) · **State:** DEFINED

### IDEA
Copy MT4 series arrays into 0=oldest chronological arrays once per pass;
all Pine-ported logic then runs in one orientation, killing an entire
class of index-mirror bugs.

### ORIGINAL
Pending verbatim induction (approved provisionally — to be archived when
the Beacon Consensus v7 unification begins, alongside the other Trident
extractions).

### FLEET RENDERING
`[ENH]` Fleet helper `FTL_ToChronological()` planned — same pattern,
fleet naming, lookback-bounded (InpMaxBars law applies: the Trident's
unbounded per-tick replay is rejected in our implementation).

---

## SNIPPET #003..#005 — RESERVED (Trident dashboard grammar, cancel-with-reason, ledger pattern)
Provisional placeholders per Captain's ruling: structure approved,
verbatim induction deferred until Wave-2/3 work begins. See ROADMAP in
`Fleet_Hulls/INDEX.md`.

---

*Inventory law: the ORIGINAL block is sacred — it is copied, never edited.
Corrections live only in the FLEET RENDERING layer, tagged and law-cited.*
