# Trident Ledger — Extraction Dossier
## Full State-Machine Extraction from Trident_Swing_Projector v1.01 for Assimilation into TeknoLite_Beacon_Consensus

**Status:** RATIFICATION PENDING — extraction complete, assimilation path undecided (brainstorm scheduled)
**Source analyzed:** `Trident_Swing_Projector.mq4` v1.01 (MarkitTick TV-to-MQL4 translation), forensic review delivered 2026-10-16 (Code Hygiene C, Financial Viability B−)
**Target hull:** `TeknoLite_Beacon_Consensus` mainline (v6.44+), patch doctrine — evolve the working mainline, never rewrite
**Author:** War Room Design Desk, at the Captain's order
**Filed:** `999-Templates/` doctrine wing

---

## 1. Executive Brief

The Trident's trade state machine is a **signal-source-agnostic barrier-frame tracker**. Detached from its ABC swing detector, it answers the one question the War Room's fixed-horizon calibration cannot:

> **Which barrier was hit first, how far did the trade run (MFE), how deep did it draw (MAE), and how long did it take?**

The existing `CalibEvaluate` asks: *"was price higher/lower N bars later?"* — path-blind. A signal that ran +3R and reversed to breakeven at expiry grades identically to one that never moved. The barrier frame is the missing instrument. Field evidence already demands it: the CADCHF-OTCq M1 desk ladder (63% @ 3 bars, 54% @ 5, 35% @ 8, 12% @ 13) is path-toxicity that a barrier ledger sees *sharper* than any horizon ladder.

**Assimilability verdict: HIGH.** The machine maps onto the War Room's existing pending-array architecture with no structural conflict. The decision before the Captain is not *whether* but *which of two depths*: direct WATCH-mode patch, or full ledger with voting seat.

---

## 2. Full Extraction — the State Machine as Found

### 2.1 State Enumeration (7 states)

| State | Name | Meaning |
|---|---|---|
| 0 | Idle | No setup; pattern candidates evaluated |
| 1 | **Armed** | Frame computed; waiting for entry trigger or cancel |
| 2 | **Active** | Entry triggered; position open, nothing hit |
| 3 | TP1 hit | First target reached; position conceptually partial/live |
| 4 | TP2 hit | Second target reached |
| 5 | **TP3 hit** | Terminal state (win, equality target) |
| 6 | **Stopped** | Terminal state (loss / breakeven / trend failure) |
| 7 | **Cancelled** | Terminal state (never entered: C broken or expired) |

### 2.2 The Price Frame (as found — leg-derived)

Computed at arming from the ABC swing geometry:

```
leg    = |B - A| (optionally %-scaled, optionally smoothRatio-fudged)
entry  = C ± 0.25·leg      (direction-signed)
TP1    = C ± 0.50·leg      ("Critical")
TP2    = C ± 0.75·leg
TP3    = C ± 1.00·leg      ("Equality")
stop   = C ∓ buf           (buf = 0 | ticks·Point | ATR-fraction; default 0 → stop AT C)
risk   = |entry − stop|    (= 0.25·leg + buf at default)
R:R    = 1:1 / 2:1 / 3:1 by construction
```

### 2.3 Transition Rules (exactly as coded, causality confessed)

**Arming (Idle → Armed):** candidate pattern confirmed (pivot confirmed `right` bars late — no repaint), pullback within Fibonacci band [23.6%, 78.6%], trend filter (higher pivot highs / lower pivot lows), optional HTF bias agreement, optional ADX ≥ threshold, not busy, not frozen (LockSignal on live bar).

**Entry trigger (Armed → Active):** *previous closed bar's close* crosses the entry level (`close[bar−1] ≥ entry` for long). Closed-bar discipline — executable at bar open.

**Cancellation (Armed → Cancelled), two causes, checked BEFORE entry:**
1. **C-break:** prior bar's low (long) trades through C — structure invalidated.
2. **Expiry:** `bar − armBar ≥ InpExpiryBars` (default 20) — armed setups die of old age.

**Barrier resolution (Active/TP1/TP2 → next), evaluated every bar, PESSIMISTIC ORDER:**
1. Stop cross first (`low ≤ mgStop` long) → state 6. Reason taxonomy: "Trend failure" (stopped same bar as entry), "Breakeven" (managed stop ≠ original), "Stopped".
2. TP3 → state 5 (terminal).
3. TP2 → state 4.
4. TP1 → state 3.
Same-bar SL+TP ambiguity resolves to SL — conservative accounting, correct.

**Breakeven management:** if enabled, on TP1 hit the managed stop moves to entry (`mgStop = entry`).

**Record-keeping:** every transition is timestamped (bar index + time) into a `SetupInfo` struct: entryBar, tp1Bar/2/3, slBar, cancelBar, closeBar, reason string, trendFail flag. This struct IS the ledger row.

### 2.4 Alert Events (closed-bar, deduped per bar)

armed / entry / cancelled / stop / tp1 / tp2 / tp3 — one alert per bar maximum (else-if chain), dedup via last-alert bar time.

### 2.5 What the extraction reveals as DESIGN (not accident)

- **Pessimism is deliberate:** cancel-before-entry, SL-before-TP, closed-bar triggers.
- **The ledger row is first-class:** the SetupInfo struct is a complete trade obituary — who, when, frame, outcome, cause of death.
- **Signal source is a plug:** the state machine consumes `{dir, frame}` and nothing else from the pattern detector. Detachment is clean by construction.

---

## 3. Assimilation Map — Transfer / Reframe / Reject

| Trident component | Verdict | War Room adaptation |
|---|---|---|
| 7-state machine | **TRANSFER** | Arms on **consensus fire** (and optionally per-source signals) |
| Pessimistic same-bar order | **TRANSFER VERBATIM** | Correct; non-negotiable |
| SetupInfo ledger row | **TRANSFER, extended** | + MFE/MAE tracking, + bars-to-barrier, + mask/context at fire |
| C-break cancel | **REFRAME** | Becomes **frame-invalidation cancel** (price through stop before entry) |
| Armed expiry | **REFRAME** | Becomes the ledger **time-stop** (bars); expiry = unresolved trade closed at market, graded at close |
| Breakeven-after-TP1 | **KEEP as input** | Default OFF — the desk measures first, manages later (WATCH discipline) |
| Leg-derived frame | **REJECT** | **ATR frame** (v7 dossier ruling stands): stop = s·ATR, TP1/2/3 = t₁/t₂/t₃·ATR from fill; volatility-native on every feed incl. OTC synthetic |
| Optimistic level-fill | **REJECT** | Fill-honesty law (v6.00): **entry = open of the bar after the signal** |
| Full-history resim per tick | **REJECT** | Pending-array FIFO (calib pattern): `TRD_MAX_PENDING` bounded, new-bar evaluation only |
| Chart-object rendering | **REJECT** | Silent instrument: journal `[trident]` section + `BC_TRD_*` GV persistence; one lean JOURNAL-line summary at most |
| Dashboard | **REJECT** | The War Room has its own deck; ledger speaks through the journal |

---

## 4. Proposed Module — `006F TRIDENT LEDGER` (both variants share this core)

```
On Fire(direction, barTime, score):
    fill   = iOpen(bar after signal)           // fill honesty
    atr    = ATR(InpTrdAtrLen) at signal bar
    stop   = fill ∓ InpTrdStopAtr · atr
    tp1..3 = fill ± InpTrdTp{1,2,3}Atr · atr
    push pending{frame, mask, context, source-mask} (FIFO, TRD_MAX_PENDING)

On new bar (inside rates_total != prev_calculated block):
    for each pending trade:
        update MFE / MAE (running extremes since fill)
        if armed and bar > fillBar + InpTrdArmBars → wait (fill not yet due)
        pessimistic barrier check: SL → TP3 → TP2 → TP1
        time-stop: age ≥ InpTrdExpiryBars → close at bar close, grade at close
        closed trades: accumulate per-frame stats (EWMA, per class-tag)
```

**Ledger metrics accumulated:** TP1-before-SL rate, mean MFE/MAE in R, expectancy in R, median bars-to-TP1 / bars-to-SL, per: consensus overall, per ensemble mask (combo jurisdiction), per individual source (each voice's signals ALSO arm the ledger when enabled — per-source frame truth).

**Persistence:** `BC_TRD_{nmid}_*` GVs, parallel to `BC_CAL_*`; journal `[trident]` section in the existing field-journal writer; Ouroboros-importable.

---

## 5. The Two Paths — the Brainstorm Question

### PATH A — Direct Patch (WATCH rank), v6.45
- Ledger runs **silent**: measures, journals, never touches the posterior.
- One JOURNAL-line summary (`TRIDENT | TP1-first 58% · exp +0.4R · med 6b`) or none.
- ~300 lines, append-only inputs, zero .set surface risk, zero signal-logic surface.
- Field-testable immediately; the desk harvests frame truth while nothing changes in the fire path.
- **Precedent:** JuriKimi commissioning — wire first, vote never without ruling.

### PATH B — Full Ledger with Voting Seat, v6.45/46
- Everything in Path A, PLUS: mature frame stats feed a **posterior adjustment** —
  e.g. when the ledger's expectancy for the current mask/context is mature (n ≥ InpTrdMinN) and negative, it subtracts LLR; when strongly positive, modest bonus (capped, ComboAdj-style).
- The ledger becomes the **thirteenth vote that knows the cost of being wrong** — the first voter with path memory instead of horizon memory.
- Requires: maturity gates, SE-discounted adjustment (FleetGraduate pattern — must beat the desk clear of both SE), hard cap, WATCH→VOTE input per Apprentice doctrine.
- Risk: a second learned-adjustment layer alongside combos/ML — interaction must be confessed and capped; jurisdiction overlap with `ComboAdj` needs an explicit treaty (combo = direction-rightness, ledger = path-profitability; both capped, never compounding unbounded).

### Desk recommendation (for the brainstorm, not a ruling)
**Path A now, Path B by later ruling** — the ledger must first *earn* its vote in the field, the same discipline the Apprentice lives under (ML was born WATCH and remains WATCH by the weights' own confession in the journals).

---

## 6. Engineering Constraints (inherited law, both paths)

- `#property strict`, b1470+, zero warnings; 3-arg `ObjectsTotal` where used.
- Inputs appended at END only (positional contract); all senior inputs byte-identical.
- Bounded state: `TRD_MAX_PENDING` (suggest 21) with FIFO compaction; no unbounded arrays.
- New-bar-only evaluation; O(pending) per bar, O(1) per tick.
- Bars-guard + `iTime` identity verification on all pending entries (v6.42 hardened pattern — verbatim).
- GV persistence layouts frozen once shipped; journal `[trident]` section parse-stable.
- Fibonacci doctrine: frame multiples are market-acted parameters (tunable inputs), NOT hardcoded Fibonacci numbers; defaults justified by the ledger's own future data.
- Header confession block per mainline tradition; version-string parity in Prints only (CSV/GV headers frozen once shipped).

---

## 7. Open Questions for the Brainstorm

1. Path A or Path B (or A-then-B as desk recommends)?
2. Per-source arming: every voice arms the ledger, or consensus-only? (Per-source gives the per-member frame truth the desk currently lacks; cost is state ×13 — still bounded.)
3. Frame defaults: stop/TP ATR multiples — desk suggests stop 1.0·ATR, TP1 1.0, TP2 2.0, TP3 3.0 as the *null hypothesis*, to be corrected by the ledger's own future data.
4. Time-stop default (bars): 13 is the field-proven toxicity boundary on CADCHF-OTC M1 — but it is feed-dependent; suggest 13 default with the ledger itself as the instrument that will justify changing it.
5. Breakeven management: measure-only at birth, or one managed variant tracked in parallel (shadow ledger answers "would breakeven have helped?" for free)?
6. Display: one lean JOURNAL-line, or fully silent with journal-only testimony?

---

*Filed at the Captain's order, 2026-10-16. The brainstorm decides: direct patch, or full ledger with voting seat.*
