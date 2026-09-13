# FLEET_STANDARD.md — TeknoLite Fleet Button Doctrine

**Version:** 1.0 — Ratified by the Captain, 2026-09-13
**Badge:** `[FLEETBTN-STD v1.0 COMPLIANT]`
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
