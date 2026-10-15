# Chimaera ML — Extraction Dossier (Module 006G)

**Source:** TeknoLite Chimaera ML v0.6-PATCHED (v0.8 ancestry graft), 2,194 lines
**Target:** TeknoLite_Beacon_Consensus v6.46 — "The War Room"
**Ratified:** Captain's directive, 2026-10-16 — extract, file, patch as the MACHINE LEARNING Module, learning from Trident Ledger results AND Consensus readings, in LAYERED learning
**Status:** Filed; patch v6.46 cut per this dossier

---

## 1. Executive Brief

Chimaera carries a genuine **reinforcement core** beneath its projection art: five Fibonacci DMI experts (5/8/13/21/34) run shadow trades; every phase termination is scored by a **reward function** (return + MFE bonus − MAE penalty, duration-normalized, whipsaw-punished); scores live in a **circular memory** with **recency decay 0.985**; a **softmax** over the decayed scores picks the adaptive parameter. This is a complete perception→action→reward→memory→selection loop — the fleet's first true RL grammar.

The decisive fact for assimilation: **PhaseReward's input signature `(finalMove, maxFavorable, maxAdverse, atrAtEntry, heldBars)` is exactly the Trident Ledger's output row** (Module 006F, v6.45). The seam is not approximate — it is identical. Chimaera's reward grammar plugs into the Trident resolutions with zero translation, and the "Consensus readings" (mask, posterior, context, horizon) provide the state keys. The Captain's "layered learning" is therefore: **L1 source calibration + L2 apprentice (existing) + L3 frame-reward memory (new, this extraction).**

Forensic grades for the donor hull: **Hygiene B−** (session-amnesiac memory, O(n·m) scoring in the bar loop), **Viability B+** (reward grammar sound; projection layer field-rejected by its own author).

---

## 2. Full Extraction

### 2.1 The Reward Grammar — `PhaseReward(metric, finalMove, maxFavorable, maxAdverse, atrAtEntry, heldBars)`

```
normReturn = finalMove / atrAtEntry
normMfe    = maxFavorable / atrAtEntry
normMae    = maxAdverse / atrAtEntry
duration   = sqrt(max(1, heldBars))
REWARD_BALANCED: raw = normReturn + 0.25·normMfe − 0.50·normMae
adjusted = raw / duration
if heldBars < MinBars(3): adjusted −= WhipsawPenalty(0.25)
```

- **ATR-normalized everything** — rewards are comparable across regimes, pairs, and frames. Identical normalization philosophy to 006F's MFE/MAE-in-ATR.
- **Asymmetric excursion weighting** (MFE +0.25, MAE −0.50): pain counts double pleasure — a risk-off prior, rare and correct in retail ML.
- **Duration normalization by √bars**: a slow win is worth less than a fast one; aligns with BO time-decay reality.
- **Whipsaw penalty**: sub-3-bar phases are noise trades, punished regardless of P/L.
- Variants on the dropdown (PCT_RETURN / CLEAN_MOVE / WIN_RATE) are candidate reward doctrines — BALANCED is the proven default.

### 2.2 The Memory — circular buffer + recency decay

```
StoreReward(length, reward, bars): head--, wrap; count++ to capacity
ScoreForLength(L): Σ reward·0.985^age / Σ 0.985^age   over matching entries
```

- Capacity: input 500, clamped 20..3000 (global default 3000).
- Decay 0.985 ⇒ half-life ≈ 45 entries — old evidence fades exponentially, never hard-forgotten.
- **Same algebra as the War Room's EWMA calibrators** — the fleet already speaks this dialect (InpCalibAlpha).

### 2.3 The Selector — softmax over decayed scores

```
rawWeight_e = exp(clamp(±50, score_e · Sharpness(1.5)))
adaptiveLength = Σ length_e·rawWeight_e / Σ rawWeight_e   → clamp [5,34]
```

- Continuous blend, not winner-take-all: the runner-up experts still shape the parameter. Robust to single-cell noise.
- Sharpness 1.5: enough discrimination to matter, soft enough to avoid regime whiplash.

### 2.4 Ancillary reward instruments (extracted for the record)

- **PredictionAccuracyReward**: direction ±2 (dominant), body-magnitude accuracy ×0.8, unbounded miss-penalty, least-wrong caution bonus ×0.3. Notable doctrine: *caution when wrong is rewarded* — transferable to a future abstention layer.
- **ConsensusReward**: direction ±2 − 0.5·closeError/ATR + containment bonus. Chimaera's own "did the projection bracket reality" score.
- **TrendEfficiency** = (ADX/100) / max(0.1, GARCH VolRatio) — trend-to-vol ratio used to modulate thresholds (War Room analog: GARCH storm veto + context bins; NOT extracted — jurisdiction overlap).

### 2.5 What the War Room already owns (no transfer)

DMI/ADX computation (War Room evidence comes from beacons, not recomputed indicators), the 5-line projection fan, GARCH(1,1) (Marshal already seated via beacon), consensus-candle rendering, vol-band cone, button/beacon plumbing (fleet standard, already superior in the hulls).

---

## 3. Forensic Findings on the Donor (why extraction, not adoption)

| # | Finding | Severity | Disposition |
|---|---------|----------|-------------|
| F1 | **Memory is session-amnesiac** — reward memory never persisted to GV/file; every restart re-learns from zero | Critical for a learner | **Fixed in 006G**: aggregate scores persist in `BC_CML_*` GVs; journal `[chimaera_ml]` export |
| F2 | **O(bars × experts × memory) scoring** — `ScoreForLength` scans the full memory per expert per bar inside the history loop (up to 5×3000 per bar) | High (performance) | **Fixed in 006G**: scoring happens only at resolve/deduction time (per signal, not per bar) |
| F3 | Rewards only on **flips** — a still-open phase at session end is never scored; right-censored evidence lost | Medium | **Inherited design note**: 006F frames always resolve (stop/TP3/time-stop) — no censorship by construction |
| F4 | Expert entry at **close of signal bar**, intrabar MFE/MAE — not fill-honest by War Room doctrine | Medium (doctrine) | Moot: 006G drinks from 006F, which is fill-honest (open of next bar) |
| F5 | Fibonacci Neighborhood **field-rejected by its own author** ("adaptive periods destroyed body precision") | — | Heeded: 006G deductions are WATCH-silent; nothing adapts live until the journal proves it |
| F6 | `ProcessLine`×5 + `SetIndexShift` per-bar waste (author's FIX B/C) | Low | Rendering not transferred |

**Verdict:** the reward/memory/selector core is extraction-grade; the hull around it is not. This mirrors the Trident ruling exactly: *transfer the grammar, reject the plumbing.*

---

## 4. Assimilation Map — Module 006G "Chimaera Layered Learner"

### TRANSFER (verbatim grammar)
- **PhaseReward (REWARD_BALANCED)** — the reward equation, ATR-normalized, √duration, whipsaw penalty.
- **Circular reward memory** — capacity input (default 500, clamp 20..3000), recency decay 0.985.
- **Decayed scoring** — `Σ r·d^age / Σ d^age` per key.
- **Softmax selection** — used for the silent horizon deduction counsel.

### REFRAME (same math, new jurisdiction)
- **"Experts" → layered keys.** Chimaera's experts were DMI periods; 006G's keys are *consensus readings*:
  - **Horizon layer** (4 keys): the expiry rung of record at fire time — learns *which expiry actually pays*, with MFE/MAE-rich evidence (vs L1/L2's binary hit/no-hit).
  - **Context layer** (4 keys): MarketContext weather at fire — learns which weather pays.
  - **Ensemble layer** (mask keys): `g_lastMask` at fire — learns which ensembles produce quality frames, complementing combo hit-rate with excursion information. Session-scoped + journal (unbounded key space; documented).
- **Reward source → Trident Ledger resolutions.** At 006F resolve: finalMove = signed exit−entry in frame direction (stop → stop price, TP3 → TP3 price, time-stop → close; fill-honest levels), MFE/MAE/ATR/bars direct from the frame. SCRATCH resolves with finalMove≈0 — honest near-zero reward, BE quality becomes measurable.
- **Persistence → aggregate priors.** Horizon/context layers persist as (weightedScore, totalWeight) pairs in `BC_CML_{nmid}_*` GVs (16 values); the ensemble layer exports via journal. F1 fixed without 1,500 GVs.

### REJECT
- Per-bar/per-tick scoring (F2), DMI recomputation, projection rendering, prediction-candle rewards (no projection in the War Room), session amnesia (F1).

---

## 5. Layered Learning Architecture (as built, v6.46)

```
L1  Source calibration (existing, v3.20): per-source EWMA hit-rates     — binary outcomes, per voice
L2  Apprentice logistic stacking (existing, v3.21): feature vector SGD  — binary outcomes, per candidate
L3  Chimaera frame-reward memory (NEW, 006G): keyed PhaseReward memory  — CONTINUOUS outcomes, per frame
```

L3 is strictly richer in outcome information: where L1/L2 learn "win/loss at expiry", L3 learns *how much, how fast, with what pain* — the difference between a coin flip and a trade journal.

**Doctrine constraints (self-imposed, ratified by F5):**
- **WATCH-silent**: L3 gates nothing, adapts nothing, votes nothing. It records, scores, and publishes deductions to the journal + GVs. Live adaptation (dynamic expiry, dynamic frame multiples — the Captain's earlier open question) requires a future ruling with the `[chimaera_ml]` journal as evidence.
- **Zero new per-tick cost**: storage at fire, scoring at resolve. Both are per-signal events.
- **Inputs appended at END**; all seniors byte-identical.
- Capacity 500 is NOT a Fibonacci number — capacities are not market-acted (v6.42 doctrine), Chimaera's own default stands.

---

## 6. Module 006G Build Specification (implemented in v6.46)

1. **006F frame extension**: three key fields (horizon rung, context, mask) recorded at arm; exit price recorded at resolve.
2. **CML engine**: `CMLStore(keys, reward, bars)` at every 006F resolution; `CMLScore(keyClass, key)` decayed scoring on demand.
3. **Reward**: PhaseReward BALANCED verbatim (weights as inputs), duration √bars, whipsaw <3 bars.
4. **Deductions (silent)**: best-horizon counsel = argmax over 4 rung scores (softmax margins logged); context scores; published in journal + boot print.
5. **Persistence**: `BC_CML_{nmid}_H{0..3}_{S,W}`, `BC_CML_{nmid}_C{0..3}_{S,W}`, `_N` observation count; loaded in OnInit as priors.
6. **Journal**: `[chimaera_ml]` block — per-rung score/n, per-context score/n, best_h counsel, memory occupancy.
7. **Inputs (END)**: InpUseChimLearner(true), InpChimMemorySize(500), InpChimRecencyDecay(0.985), InpChimMfeWeight(0.25), InpChimMaeWeight(0.50), InpChimMinBars(3), InpChimWhipsawPenalty(0.25).

---

## 7. Open Questions (future rulings — NOT built)

1. **Live adaptation ratification**: when does best-horizon counsel earn the right to override `g_evalHorizon`? (Suggested gate: n ≥ 100 frames AND margin ≥ 1 SE, same sovereign test as combos.)
2. **Dynamic frame multiples**: softmax over candidate frame shapes — the Chimaera selector applied to 006F's stop/TP multiples. The machinery is now in-house; the evidence must accumulate first.
3. **Ensemble-layer persistence**: if the journal proves the mask layer predictive, promote it to GV persistence (bounded top-K table).
4. **Abstention layer**: PredictionAccuracyReward's least-wrong/caution grammar as a future "don't fire" counsel — needs its own dossier round.
5. **Reward doctrine variants**: CLEAN_MOVE / WIN_RATE / PCT_RETURN as alternates — field comparison via parallel shadow scoring (cheap: same frames, three reward columns).
