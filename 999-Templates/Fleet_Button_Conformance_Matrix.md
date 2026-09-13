# Fleet Button Conformance Matrix — v1.0 Standard

**Date:** 2026-09-13 · **Baseline:** Fleet Button Standard v1.0 (FLEET_STANDARD.md)
**Method:** static parse of all 19 fleet hulls vs the 10-point checklist.
**Reading:** ✔ conformant · ✖ absent/violating · — not applicable (no button)

> Note: the Standard postdates every hull. This matrix measures **migration
> distance**, not fault. Points 1–5, 8–9 are ✖ fleet-wide by definition —
> they are the new law. Points 6, 7, 10 grade pre-existing behavior.

| # | Hull | 1 Family | 2 Key | 3 Default-ON | 4 Click-write | 5 Ghost-sweep | 6 State-force | 7 Palette | 8 Fossil tip | 9 Resync | 10 Sovereignty | Score |
|---|------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 1 | Divergence_Confluence v2.3 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 2 | Dynamic_Liquidity_HeatMap v2.11 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔* | 2/10 |
| 3 | TREND_Basilisk v4.22 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 4 | TeknoLite_Chimaera_ML | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 5 | TeknoLite_ConfluenceSR v1.10 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | **✖** | 1/10 |
| 6 | TeknoLite_Beacon_Consensus v6.34 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 7 | CustomTF_CandleOverlay v2 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 8 | HiLoFiboFan v2.00 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 9 | Trendline_Alpha v2.1 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 10 | TeknoLite_RVOL v1.00 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 11 | TeknoLite_SMC v1.00 | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✖ | ✖ | ✔ | 3/10 |
| 12 | SwingZigZagPro_Czernobog v4.20 | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | **✖** | ✖ | ✖ | ✔ | 2/10 |
| 13 | TeknoLite_Trend_BreakOut v4.32 | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✔ | ✖ | ✖ | ✔ | 3/10 |
| 14 | TeknoLite_TrendBars_Pro v5 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 15 | Dadas_True_Trend_Indi v5.0 | ✖ | ✖ | ✖ | ✖ | ✖ | **✖** | ✔ | ✖ | ✖ | ✔ | 2/10 |
| 16 | TeknoLite_Nautilus v1.14 | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | **✖** | ✖ | ✖ | ✔ | 1/10 |
| 17 | Vertex_Refactor v2.7 | — | — | — | — | — | — | — | — | — | ✔ (no button) | n/a |
| 18 | TeknoLite OTC Clock v2.53 | — | — | — | — | — | — | — | — | — | ✔ (no button) | n/a |
| 19 | StrictGARCH11_Pro v8.10 | — | — | — | — | — | — | — | — | — | ✔ (no button) | n/a |

\* DLH: sovereignty holds, but the ON-arm rebuilds inside the click handler
(R7 violation — flagged separately from the checklist).

## Priority findings (pre-migration debt)

| Severity | Hull | Issue |
|---|---|---|
| **Critical** | CSR v1.10 | `OnCalculate` early-returns when toggled off — beacon/logic silenced. Sovereignty violation; the Admiral hears nothing while the button is dark. |
| **High** | Dadas v5.0 | `OBJPROP_STATE` used as state store — desyncs against any R5 state-force; survives nothing. |
| **High** | DLH v2.11 | Full `BuildAndDraw()` inside the click handler — UI-thread engine work (R7). |
| **Medium** | Czernobog, Nautilus | Palette inverted vs Standard (aqua/red roles swapped). |
| **Medium** | TrendBars v5, BreakOut v4.32 | No event-guard preamble; BreakOut lacks redraw batching. |
| **Low** | All 16 | Six different object-name spellings; no persistence, debounce, ghost sweep, resync — closed by adopting the module. |

## Migration order (proposal)

1. **Wave 1 — canonical twins** (Divergence, Basilisk, CustomTF, HiLoFibo,
   Trendline, RVOL, Chimaera, Admiral, TrendBars): drop-in module, payload
   arms map 1:1.
2. **Wave 2 — dialect hulls** (SMC visibility-hide, Dadas state-store,
   Czernobog/Nautilus palette): module + dialect unwinding.
3. **Wave 3 — sovereignty repairs** (CSR early-return, DLH in-handler
   rebuild): doctrine fixes beyond the button surface.
