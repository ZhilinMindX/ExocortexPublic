# FLEET_STANDARD.md — TeknoLite Fleet Doctrine

**Version:** 1.1 — v1.0 ratified by the Captain, 2026-09-13; v1.1 Telemetry Codicil ratified same day ("All the Lessons, must be Learned")
**Badge:** `[FLEETBTN-STD v1.0 COMPLIANT]` / `[FLEET-TELEMETRY v1.1 COMPLIANT]`
**Reference hull:** `999-Templates/FleetToggleButton_v3_0.mq4` (ExocortexPublic)
**Evidence base:** Fleet Button Autopsy (16 button-bearing hulls, Appendix A)

---

## 0. Prime Doctrine

> **The button gates RENDERING only.** Logic, beacons, alerts, ML learning,
> journal feeds, and all computational state ALWAYS run. The fleet never sleeps.
> The button modulates the `.set`; it never overrides it.

A button that silences a beacon is not a button — it is a mutiny.

---

## 1. The Eight Rulings (R1–R8)

### R1 — Memory Grammar
- Key: `FLEETBTN_{FAMILY}_{SYMBOL}[_{SLOT}]_State` (+ `_When`, `_Version`)
- **Symbol VERBATIM.** The Standard never parses a symbol. BTC, Forex, OTC,
  any broker suffix — works unparsed, future-proof by ignorance.
- **No timeframe segment.** If the Captain turns a hull off and changes
  timeframes, it remembers it is off. Keep It Simple.

### R2 — Persistence by Law
- Default state: **ON** (eyes-open doctrine).
- First attach writes the state back immediately, so the key exists from
  the first breath.
- State is written **at click-time, never in OnDeinit.** A terminal crash,
  chart kill, or power cut must not cost a toggle.

### R3 — No-Collision by Design
- **Object identity is per-instance:** `FLEET_{FAMILY}_{ChartID}_BTN`.
- **Memory is per desk:** family + symbol. Two or two hundred instances
  mirror one GV.
- **Bar-gated resync** (`FTB_ResyncFromMemory`) heals divergence within one
  bar and makes every hull remotely controllable — any script, EA, or sister
  chart can flip the desk by writing the GV.

### R4 — Ghost Sweep
At init, delete family-root button objects from dead ChartID eras
(template-archaeology class). A ship sweeps **only its own family root** —
sweeping another family's objects is a mutiny.

### R5 — Visual Grammar
- Background `#373737` (3618615) ON / `#222222` (2236962) OFF.
- Text aqua (16776960) ON / red (255) OFF.
- `OBJPROP_STATE` forced **false** at create AND at every click —
  MT4's sticky-press bevel is a rendering lie.

### R6 — Fossil Record
Tooltip carries `FAMILY | state | last toggle time`; the last-toggle time
is persisted in its own GV (`_When`). Template exports retain operator
intent for the Coding Cluster's Lessons Learned.

### R7 — Deferred Rebuild
The click handler never does engine work. It persists, repaints, raises the
callback, and returns. The engine rebuilds on its next pass.
**The `.set` is senior** — if the configuration silences something, the
button abides. Simply.

### R8 — Escape Hatch
`InpSlotSuffix` provides deliberate per-desk memory independence when the
operator *wants* two desks of the same family on one symbol to disagree.
Rare by design.

---

## 2. The Sovereignty Classes

| Class | Button gates | Declaration required |
|---|---|---|
| **Publisher** (beacon-emitting) | Rendering only | Standard header note |
| **Human-layer** (no wire) | May gate computation | `SOVEREIGNTY: COMPUTE-GATED (no wire)` in header |

---

## 3. Conformance Checklist (10 points)

1. `InpFleetFamily` set to a registry name
2. Memory key `FLEETBTN_{FAMILY}_{SYMBOL}` — verbatim symbol, no TF
3. Default ON + first-attach write-back
4. Write at click-time; OnDeinit writes nothing
5. Ghost sweep by family root at init
6. `OBJPROP_STATE` forced false at create and click
7. Palette bg #373737/#222222, text aqua/red
8. Tooltip fossil record (family | state | last toggle)
9. Bar-gated resync wired in OnCalculate
10. Sovereignty: rendering gated, beacons never sleep

---

## 4. Beyond the Button — Universal Fleet Functions (proposed)

The autopsy showed the fleet re-implements the same machinery in every hull.
Extraction candidates for a shared `TeknoLite_Standard.mqh`:

1. **`FLT_NewBar()`** — one new-bar detector (six idioms exist today).
2. **`FLT_BeaconEmit/Read/Sweep()`** — the GV protocol as code: key grammar,
   TTL semantics, deinit sweep. The three historical generations become
   declared modes of one protocol.
3. **`FLT_Alert()`** — unified cooldown + per-bar dedup + message formatter
   (13 hulls hand-roll this).
4. **`FLT_PrefixSweep(prefix)`** — one audited backwards object loop
   (14 copies exist).
5. **`FLT_ATRScale()`** — one volatility normalization (11 inline `iATR`
   sites, each with its own period/floor folklore).
6. **`FLT_CalcWindow()`** — incremental `prev_calculated` window math
   (18 hand-rolled).
7. **Telemetry macros** — `[TRACE]/[CANARY]/[ANOMALY]` wrappers keyed to a
   fleet-standard debug tier.

*Status: proposed — subject to the same Gold Standard deliberation before
any line is written.*

---

## Appendix A — Evidence: The Fleet Button Autopsy

### A.1 The Convergent Core
Sixteen hulls carry a button. Every toggle handler is the same six-step
organism — convergent evolution from the Divergence lineage:

```
1. GUARD    — reject CREATE/DELETE/MOUSE noise; require OBJECT_CLICK + name
2. FLIP     — g_showX = !g_showX
3. REPAINT  — UpdateButtonVisual()
4. OFF-ARM  — delete/hide ink, Comment("")
5. ON-ARM   — raise recalc flag
6. REDRAW   — ChartRedraw()
```

The Standard is an **extraction**, not an imposition. Each hull's unique
part reduces to its `FTB_OnToggle` payload.

### A.2 Deviation Catalog
| Hull | Dialect | Deviation |
|---|---|---|
| Divergence v2.3 | canonical | The donor. No persistence, no debounce. |
| DLH v2.11 | canonical | Immediate rebuild **inside** click handler (R7 violation). |
| Czernobog v4.20 | canonical + state-force | Fixed sticky-press bevel — adopted into R5. |
| Basilisk v4.22 | canonical | Clean twin of Divergence. |
| Chimaera ML | canonical | `ResetHistory()`+`ClearAllBuffers()` in both branches, in-handler. |
| CSR v1.10 | canonical | ⚠ `OnCalculate` early-returns when disabled — sovereignty violation in the engine. |
| CustomTF / HiLoFibo / Trendline / RVOL | canonical | Clones; RVOL adds buffer re-sync. |
| SMC v1.00 | C — TIMEFRAMES-hide | Hides ink via `OBJPROP_TIMEFRAMES`; gates buffer styles. Sanctioned as alternative OFF-arm for heavy ink. |
| Dadas v5.0 | D — STATE-as-store | Reads `OBJPROP_STATE` as the toggle variable — fragile; conflicts with R5 state-force. |
| Trend_BreakOut v4.32 | canonical + state-force | No guard preamble; no redraw batching. |
| TrendBars v5 | minimal | No guard preamble; no OFF-payload (ink lingers a bar). |
| Nautilus v1.14 | minimal + drag | Multi-object dispatch (button + drag handle). Palette inverted vs Standard. |
| Admiral v6.34 | canonical | Gates only the info line. Model citizen. |

### A.3 Universal Gaps (what NO hull did, pre-Standard)
1. Click-time persistence (zero hulls) — every restart was amnesia.
2. Click debounce (zero hulls).
3. Ghost sweep (zero hulls) — template dead-era buttons survived all.
4. Remote resync (zero hulls).
5. One naming grammar — six spellings: `g_buttonName`, `gButtonName`,
   `g_btnName`, `g_btnId`, `buttonId`, `gBtnName`.

### A.4 Lessons Learned (Coding Cluster)
1. **Duplication is the real enemy.** Six new-bar detectors = six chances to
   be wrong; every fix applied six times.
2. **Sovereignty violations hide in the engine, not the button.** Trace the
   flag, not the click (CSR).
3. **Never use `OBJPROP_STATE` as storage** (Dadas) — it is a rendering hint
   other code may force. State lives in a variable; the button displays it.
4. **Event handlers are not engines** (DLH, Chimaera). Flags up, work later.
5. **One name, one grammar.** Cross-hull tooling dies at six spellings.
6. **House style adoption 2/3, enforcement 0** — L2 blocks in 12 hulls,
   SESSION CONTEXT in none, step-logs in 10. Style unchecked drifts.

---

## Appendix B — v1.1 Telemetry Codicil (ratified 2026-09-13)

*Evidence: fleet-wide parse of all [L2] / [TRACE] / [CANARY] / [ANOMALY] /
[STEP] markers — 19 hulls, ~115k lines. Full ledger: LESSONS_LEARNED.md.*

### B.1 The Codicil (T1–T5)

- **T1 — Mandatory headers.** Every module carries a single-line `[L2]`
  header. `SCOPE`, `STATE`, `HYPOTHESIS` are mandatory fields.
- **T2 — Controlled STATE vocabulary.** One enum, no free text:
  `DEFINED → WIRED → FIELD-TESTED → HARDENED → FROZEN` (+ `DEPRECATED`).
  Version stamps live in the step log, not in STATE.
- **T3 — Fossil floor.** Every hull keeps a `### 998` FIFO step log, last 3
  entries minimum. Epoch names encouraged: a version number tells you *when*,
  a name tells you *why*.
- **T4 — Doctrine by template.** SESSION CONTEXT blocks ship inside the
  module skeletons themselves. Doctrine that lives only in a memo does not
  propagate — the fleet proved it (zero occurrences in 19 hulls).
- **T5 — ANOMALY trigger discipline.** ANOMALY fires only on a defined,
  measured deviation (buffer-write count vs expected, object-count drift,
  suppression-ratio outliers). A tier without triggers is decoration.

### B.2 Telemetry Census (evidence)

| Adoption | Hulls |
|---|---|
| Deep (L2+STEP, 15+) | Vertex (L2:18/STEP:33), Czernobog (11/15, TRACE:36, CANARY:8), Chimaera (15/24), Admiral (STEP:32), CSR (13/15) |
| Partial | BreakOut (L2:18), SMC (7 + CANARY), TrendBars, DLH, Basilisk, RVOL, Trendline |
| Blind (zero telemetry) | CustomTF, Dadas, Divergence, HiLoFibo, GARCH, OTC Clock, Nautilus |

Field usage: NEXT 167 · DIRS 82 · STATE 78 · DEPS 74 · ANCHORS 70 ·
HYPOTHESIS 64 · LAST 8 · BLOCKER 7 (all `None`). Forward-looking fields
thrive; memory fields are vestigial.

### B.3 Telemetry Lessons (folded into LESSONS_LEARNED.md)

1. **The STEP log is the fleet's most valuable fossil bed** — the Admiral's
   named epochs ("The Orchestra", "The Council", "The Blackboard")
   reconstruct fleet history without git.
2. **Log the failure, not just the fix** — Vertex STEP 030→031 preserved a
   real field bug (subwindow-only arrows), its diagnosis, and its cure.
3. **STATE free-text is anarchy** — four semantic families in one field;
   controlled vocabulary enforced by T2.
4. **HYPOTHESIS is the hidden gem** — design rationale embedded at the
   module level ("Fail-fast prevents runtime errors") is the cheapest
   insurance against refactor amputation. Mandatory by T1.
5. **SESSION CONTEXT: zero occurrences fleet-wide** — doctrine untemplated
   is doctrine unpropagated. Fixed by T4.
6. **ANOMALY nearly stillborn** — 2 occurrences in ~115k lines, both static.
   Trigger discipline or retirement; T5 chooses triggers.
7. **One L2, one line** — wrapped blocks break greppability; continuation
   belongs to the prose layer. That is what the dual-layer split is for.
8. **Telemetry adoption correlates with auditability** — the seven blind
   hulls are exactly where audits required pure code reading with no
   self-report. T1/T3 set the floor.
