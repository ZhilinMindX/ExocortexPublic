# WAR ROOM v7 — MODULE DESIGN DOSSIER
**Phase A (Design Cards) + Phase B (Integration Map)** · **Date:** 2026-10-08
**Status:** RATIFIED — Phase C rulings issued by the Captain 2026-10-08. NO CODE written or committed yet.
**Doctrine:** FLEET_STANDARD v1.1 (R1–R8, T1–T5) · LESSONS_LEARNED (34 laws) · FL-1..18 · v7 Refactor Blueprint v1.4

> **Mission (Captain's ruling, seated):** detect who is absent, who is present, and when one or more
> agree, inform — **Layer 1 only: Buy / Sell / Wait.** The War Room does not infer the Admiral's
> 7-level scale. It does not divert from the Mission.

---

## 0. GLOBAL CONTRACTS

### 0.1 Input budget — hard ceiling 55 (Captain's ruling)

| Module | Organ | Inputs | Notes |
|--------|-------|--------|-------|
| 001 | Skeleton + Presence Registry + Gauge | **23** | incl. Button v3.2 block (16) grafted verbatim |
| 002 | Signal Normalizer | **6** | |
| 003 | Council | **9** | incl. Loop-Safety levers |
| 004 | Fleet Ledger | **8** | |
| 005 | Apprentice ML | **4** | |
| — | Section header separators (5 modules + button) | **5** | `input string InpSection…` |
| **TOTAL** | | **55** | ceiling reached with zero slack — see §0.2 |

v6.39 carried **145 inputs**. The 90-input reduction is achieved by: auto-discovery instead of
per-member enable strings (002), fixed Fibonacci horizons {3,5,8,13} as constants (not inputs),
Gauge colors/geometry frozen to the working v6.39 values (mechanics UNCHANGED — Captain's ruling:
"don't change HOW it works regarding the colors"), and deletion of Orchestra-era dead levers.

### 0.2 Slack policy

The budget sits exactly at 55 with **zero slack by design**: any future input must be traded for
a retired one and re-ruled. Section headers count as inputs (they occupy .set seats). If the
Captain prefers breathing room, the recommended cut is `InpGaugeCols` and `InpGaugeRowH`
(2 seats, frozen geometry instead) → 53.

### 0.3 Naming & memory

- Object prefix: `WR7_` (every chart object; prefix sweep on deinit per fresh-chart law).
- GV families owned: `WR7_PRES_` (presence heartbeat mirror), `WR7_COUNC_` (weights),
  `WR7_LEDG_` (ledger state), `WR7_ML_` (apprentice). **Beacon families of members are READ, never written.**
- Module numbering inside the file follows the Fleet standard: 001 inputs/globals … 998 rolling
  step log (FIFO 3) … 999 blueprint footer. The five organs occupy modules 010–050.

### 0.4 File skeleton order (the "stack")

```
000  header + SESSION CONTEXT
001  inputs (append-only contract)
002  globals & enums
010  MODULE 001 — Skeleton glue, Presence Registry, Gauge
020  MODULE 002 — Signal Normalizer
030  MODULE 003 — Council
040  MODULE 004 — Fleet Ledger
050  MODULE 005 — Apprentice
060  lifecycle: OnInit / OnCalculate / OnChartEvent / OnTimer / OnDeinit
998  rolling step log (FIFO, last 3)
999  blueprint footer
```

Lifecycle is a **thin conductor**: each event handler calls organ entry points in dependency
order (010→050). No organ calls an organ above it. DEPS enforced by review, not by hope (FL-6).

---

## 1. MODULE 001 — SKELETON + PRESENCE REGISTRY + ROLL-CALL GAUGE
**[L2] SCOPE:Presence;STATE:PROPOSED;HYPOTHESIS:GV heartbeat scan + roster is sufficient to answer "who is on deck" with zero member recompiles;DEPS:000,001,002(inputs/globals),FleetToggleButton_v3_2;DIRS:#2,#4;ANCHORS:Prefix=WR7;Seats=16**

### 1.1 Purpose
The War Room's body and its prime mission: **who is present, who is absent.** Owns the chart
lifecycle, the Fleet Button v3.2 (grafted verbatim — sovereign gate, rendering-only), the
presence scan, and the Gauge VU-meter.

### 1.2 Presence Registry
- **Roster capacity:** 16 fixed seats (`g_seat[16]`), struct:
  `family, displayName, lastSeen(datetime), ttlState(FRESH/STALE/DEAD), beaconKey`.
- **Discovery (auto, no roster inputs):** scan terminal Global Variables once per **new bar**
  for `BEACON_*` heartbeat keys on this symbol; a member whose heartbeat is live is **present**.
  Mirrors v6.39's FLEET family scan, hardened: TTL doctrine (SPHINX) — a beacon older than
  `InpPresenceTTL_Bars × Period()` is STALE; older than 2× is DEAD and the seat is freed.
- **Absent members do not appear on the Gauge** (Captain's ruling — the OHLCV ghost fossil is
  removed by design). Absence is reported in the Experts log CANARY line, not in ink.
- **Heartbeat bridge (speech = proof of life):** presence is established purely by beacon
  emission — members need **no recompile**; v6.x-era beacons count.

### 1.3 Gauge (VU-meter) — mechanics FROZEN
- Role-deck rows, one per **present** member; lamp color driven by the v6.39 decay mechanics
  exactly as-is (bright = decay ≥ 0.50, dim, gray), Layer-2 information received from members'
  beacons. No re-engineering of color logic.
- Objects: `WR7_GAUGE_{seat}_NAME/_LAMP/_VAL`, created lazily, destroyed when seat frees.
- Absent-seat removal is immediate (object delete) — no gray "ghost row".

### 1.4 Inputs (23)
| # | Input | Default | Note |
|---|-------|---------|------|
| 1 | `InpSectionButton` + **Button v3.2 block (16 inputs, verbatim graft)** | — | `InpFleetFamily="WARROOM"` default here |
| 18 | `InpPresenceTTL_Bars` | 3 | Fibonacci heartbeat TTL |
| 19 | `InpGaugeCorner` | CORNER_LEFT_UPPER | |
| 20 | `InpGaugeX` | 4 | |
| 21 | `InpGaugeY` | 20 | |
| 22 | `InpGaugeCols` | 1 | candidate cut, §0.2 |
| 23 | `InpGaugeRowH` | 14 | candidate cut, §0.2 |

### 1.5 Failure modes & laws
- b1470 overload trap: all object scans use 3-arg `ObjectsTotal(0,-1,-1)` (L1).
- Ghost sweep: button module sweeps its family root; Gauge sweeps `WR7_GAUGE_` at init.
- Halt-at-attach fossil (v6.x "dead chart" class): every seat-array access bounds-checked;
  presence scan wrapped so a malformed GV name can never throw (L-lesson: fix the halt, not the button).

### 1.6 Conformance checklist
- [ ] Compiles standalone with organs 020–050 stubbed (each stub is one no-op function)
- [ ] Attach to fresh chart: button seats, Gauge draws, zero debris after remove
- [ ] Button OFF: Gauge ink hidden, presence scan keeps running (sovereignty)
- [ ] Kill a member's beacon: row vanishes within TTL bars; CANARY logged

---

## 2. MODULE 002 — SIGNAL NORMALIZER
**[L2] SCOPE:Normalize;STATE:PROPOSED;HYPOTHESIS:One translation table absorbs every live member dialect incl. v6.x beacons;DEPS:010;DIRS:#2;ANCHORS:Lang=BUY/SELL/WAIT**

### 2.1 Purpose
Convert every present member's raw beacon dialect into the one Fleet language —
**BUY / SELL / WAIT** (Layer 1, Level-1 wording) — with a timestamp and a freshness grade.
Nothing else. No levels, no geometry, no 7-level inference.

### 2.2 Mechanism
- **Translation table (compile-time constant):** per known family, the GV key pattern and the
  mapping → {BUY, SELL, WAIT}. Covers the current fleet dialects found in the field
  (e.g. BOB v4.32's `BEACON_BOB_{cid}_{SBU|BU|TU|TD|BD|SBD}`: strong/plain bull → BUY,
  strong/plain bear → SELL, TRADE/WAIT gate → WAIT when WAIT; TLA, Vertex, Divergence,
  TrendBars, Nautilus, SMC, Dadas, Basilisk, StrictGARCH11, RVOL, Chimaera, …).
- **Unknown family → WAIT** with a CANARY (`UNKNOWN_DIALECT`) — semantic honesty law:
  the Normalizer never invents agreement.
- Output per seat: `signal(BUY/SELL/WAIT), fireTime(closed-bar time), fresh(bool)`.
  Signals older than TTL are forced to WAIT (staleness is not neutrality by silence — it is
  declared WAIT, observable).
- Standard ATR frame is **not** the Normalizer's business (that is consequence, Module 004's
  ledger geometry at fire time: entry = close at fire; stop/targets = ATR multiples).

### 2.3 Inputs (6)
| # | Input | Default | Note |
|---|-------|---------|------|
| 1 | `InpSignalTTL_Bars` | 3 | Fibonacci; stale → WAIT |
| 2 | `InpClosedBarOnly` | true | Layer-1 signals on closed bars only (repaint law) |
| 3 | `InpWaitOnUnknown` | true | semantic honesty gate |
| 4 | `InpNormDebugEcho` | false | per-seat TRACE of translations |
| 5 | `InpRequireHeartbeat` | true | no heartbeat → seat invisible to Council |
| 6 | `InpScanSubwindow` | 0 | reserved future multi-pane; parked at 0 |

### 2.4 Conformance checklist
- [ ] Every fleet dialect in the field maps to exactly one of BUY/SELL/WAIT
- [ ] Unknown/garbage → WAIT + CANARY, never a fabricated vote
- [ ] No write to any member GV family — read-only wire

---

## 3. MODULE 003 — COUNCIL
**[L2] SCOPE:Council;STATE:PROPOSED;HYPOTHESIS:Softmax-weighted raw-agreement quorum with damped, walled, gated weights breaks the feedback loop by construction;DEPS:010,020,040(ledger reads back);DIRS:#3,#5;ANCHORS:Quorum=2**

### 3.1 Purpose
When one or more present members agree, **inform**: Buy / Sell / Wait. This is the voice of
the War Room — alerts, panel verdict line, and the beacon the Admiral reads.

### 3.2 The Loop-Safety Doctrine (as ruled — two cuts)
1. **Cut 1 — generation is weight-free:** the candidate verdict is computed from **unweighted
   raw agreement** of fresh seats (count BUY vs SELL; WAIT abstains). Weights can never
   manufacture a candidate.
2. **Cut 2 — weights gate firing only:** the candidate fires only if its **weighted support**
   clears `InpApproachFloor` (scenario floors 0.62/0.68/0.72 carried from v6.39, selected by
   `InpApproach`). Otherwise the verdict is WAIT.
3. **The Ledger grades all** firings (Module 004); weight updates come only from ledger truth.
4. **Damped:** EWMA toward ledger-measured accuracy with prior `InpSeedHumility = 0.3` (seed
   weights are priors, not facts); **max daily delta** bounds any single day's move.
5. **Walled:** weights clamped to trust bounds [0.05, 3.0] — no member goes silent, none becomes a tyrant.
6. **Gated:** a weight only moves after `InpMinGradedSamples = 21` graded outcomes (Fibonacci),
   with 1-SE significance — noise cannot steer the ship.
7. **Observable:** weight trajectory journaled (`WR7_COUNC_` GV + CSV); Captain's manual
   override inputs remain senior (the .set is senior — R7 doctrine).

### 3.3 Softmax core
`w_i = exp(s_i·T⁻¹) / Σexp(s·T⁻¹)` over fresh seats; temperature fixed 1.0 (not an input —
empirical precision value, not Fibonacci domain). Quorum: at least `InpQuorum = 2` fresh agreeing
seats to FIRE. Quorum-1 (a single fresh member agreeing) publishes a clearly-labeled
**WATCH-grade advisory** — informed, never silenced, never ledgered as a fire (Captain's
ruling, Phase C #2).

### 3.4 Inputs (9)
| # | Input | Default |
|---|-------|---------|
| 1 | `InpApproach` (enum: BINOPT / SCALP_BO / FOREX / CRYPTO) | FOREX |
| 2 | `InpQuorum` | 2 |
| 3 | `InpSeedHumility` | 0.3 |
| 4 | `InpDampAlpha` | 0.15 |
| 5 | `InpMaxDailyDelta` | 0.20 |
| 6 | `InpTrustBoundLo` | 0.05 |
| 7 | `InpTrustBoundHi` | 3.0 |
| 8 | `InpMinGradedSamples` | 21 |
| 9 | `InpAlertCooldownSec` | 60 |

### 3.5 Conformance checklist
- [ ] With all weights forced equal, verdict = raw majority (Cut 1 provable)
- [ ] Weight updates impossible before 21 graded samples
- [ ] Weights can never leave trust bounds (adversarial ledger feed test)
- [ ] Every fire and every suppressed fire logged with reason (cancel-with-reason, Trident)

---

## 4. MODULE 004 — FLEET LEDGER
**[L2] SCOPE:Ledger;STATE:PROPOSED;HYPOTHESIS:Incremental spine + ring buffer grades every firing without per-tick replay;DEPS:010,030;DIRS:#3,#5;ANCHORS:Cap=233**

### 4.1 Purpose
Detection says "consensus fired"; the Ledger remembers **whether it was right.** The
Trident-inspired simulated-trade spine, our way: **incremental, replay never** (L27 — per-tick
full replay expressly rejected).

### 4.2 Mechanism
- On every Council **fire**, open a paper record: `fireTime, direction, entry = Close at fire
  bar, stop = entry ∓ ATR(InpATR_Period)×InpStopMult, targets = entry ± ATR×{InpT1Mult, InpT2Mult}`
  (standard ATR frame, Captain's unified ruling).
- Each new closed bar advances open records one step (hit TP1/TP2/stop/timeout at
  `InpOutcomeHorizon = 13` bars, Fibonacci) → outcome, R achieved, bars-to-outcome.
- **Cancel-with-reason** (Trident): opposite fire before outcome closes the record with
  `REASON:OPPOSED`.
- Storage: ring buffer `g_ledger[233]` (Fibonacci capacity), GV-persisted head/tail
  (`WR7_LEDG_`), optional CSV journal `WR7_ledger.csv` (append).
- Publishes per-member accuracy to the Council's update path — **only** when the fire's
  outcome closes (no intrabar grading, no look-forward — Chimaera's flip-time fossil).

### 4.3 Inputs (8)
| # | Input | Default |
|---|-------|---------|
| 1 | `InpATR_Period` | 13 |
| 2 | `InpStopMult` | 1.0 |
| 3 | `InpT1Mult` | 1.0 |
| 4 | `InpT2Mult` | 2.0 |
| 5 | `InpOutcomeHorizon` | 13 |
| 6 | `InpLedgerCapacity` | 233 |
| 7 | `InpLedgerCSV` | true |
| 8 | `InpLedgerGV_Persist` | true |

### 4.4 Conformance checklist
- [ ] Grading happens only on closed outcomes — provable no-look-forward
- [ ] Ring wraps cleanly at 233; GV restore reconstructs the spine after terminal restart
- [ ] Cancel-with-reason written for every premature close

---

## 5. MODULE 005 — APPRENTICE (ML)
**[L2] SCOPE:Apprentice;STATE:PROPOSED;HYPOTHESIS:Chimaera-style reward memory + logistic voter, confined to WATCH before VOTE, adds value without sovereignty risk;DEPS:010,020,040;DIRS:#5;ANCHORS:Ranks=OFF/WATCH/VOTE**

### 5.1 Purpose
The learner. Assimilates Chimaera's best: circular reward memory, recency decay 0.985,
least-wrong caution. Confined by rank — it **never** fires the Council.

### 5.2 Mechanism
- **Features (17, from v6.39):** normalized consensus geometry — seat counts, weighted margin,
  decay profile, ATR regime, hour-of-day bucket, etc. (frozen list in code, not inputs).
- **Model:** logistic scorer (v6.39 apprentice grammar), trained online **only** from
  ledger-closed outcomes.
- **Ranks:** `OFF` (inert) → `WATCH` (predicts + journals, its predictions graded by the
  Ledger alongside members) → `VOTE` (enters the Council as one weighted seat, seed-humble).
  Promotion is manual or rule-gated after `InpML_MinSamples`.
- **Chimaera grafts:** 987-entry circular reward memory (Fibonacci), decay 0.985, caution
  bonus for least-wrong abstention. **Rejected grafts:** RAM amnesia (we persist via
  `WR7_ML_` GV), flip-time look-forward (features frozen at fire bar close).

### 5.3 Inputs (4)
| # | Input | Default |
|---|-------|---------|
| 1 | `InpML_Rank` (enum OFF/WATCH/VOTE) | WATCH |
| 2 | `InpML_MinSamples` | 89 |
| 3 | `InpML_LearnRate` | 0.05 |
| 4 | `InpML_Decay` | 0.985 |

### 5.4 Conformance checklist
- [ ] In WATCH, zero influence on verdicts (diff test: verdict stream identical with ML OFF vs WATCH)
- [ ] Features snapshot at fire-bar close only
- [ ] GV persistence survives terminal restart

---

## 6. PHASE B — INTEGRATION MAP

### 6.1 Data flow (one direction, never a cycle)

```
MEMBERS (beacon GVs, unchanged, no recompile)
   │  read-only
   ▼
010 PRESENCE REGISTRY ── seats[] (family, fresh/stale/dead)
   │
   ▼
020 NORMALIZER ── seat.signal ∈ {BUY, SELL, WAIT} + fireTime
   │
   ▼
030 COUNCIL ── candidate (weight-free) → floor gate (weights) → VERDICT
   │                                    ▲
   │ fire / suppress-with-reason        │ weight update (damped/walled/gated)
   ▼                                    │
040 LEDGER ── open record → grade on closed outcome ──────────┘
   │                                    │
   └──────────► 050 APPRENTICE ◄────────┘  (WATCH: observe+graded; VOTE: one seat into 030)
```

### 6.2 Rendering & sovereignty
- Gauge (010) renders presence + Layer-2 decay lamps — unchanged mechanics.
- Verdict line + alerts (030): Buy / Sell / Wait, anti-spam cooldown, heartbeat of the War
  Room itself emitted as `BEACON_WARROOM_{cid}_…` so the Admiral sees it like any member.
- Button OFF hides **all** ink; every organ keeps computing (E1 sovereignty: publisher class).

### 6.3 Event-path contract (OnCalculate, per tick / per new bar)
1. Button resync (bar-gated, R3) → 2. Presence scan (bar-gated) → 3. Normalize fresh seats →
4. Council candidate + gate (fires at most once per closed bar) → 5. Ledger advance/open →
6. Apprentice predict/learn → 7. Render if ink on → 8. `ChartRedraw()` once.

### 6.4 .set compatibility appendix (ruled COMPATIBLE)
- v7 ships an **old→new input-layout appendix** in the file header: v6.39's 145 keys mapped
  to the 55 (or marked RETIRED with the reason). Members need no recompile; the operator's
  current `current(20).set` values are translated by the appendix table, not by memory.
- Append-only contract: post-v7 inputs append at END only.

---

## 7. RISK REGISTER (design-stage)
| Risk | Module | Mitigation |
|------|--------|-----------|
| Unknown member dialect floods CANARY | 002 | WAIT-default + debug echo; translation table versioned |
| Weight loop self-conviction | 003/004 | two-cut doctrine + all five guardrails (§3.2) |
| GV key >63 chars on long symbols | 001/010 | fail-loud validation, slot suffix (button law, inherited) |
| Halt at attach from malformed GV | 010 | wrapped scan, bounds-checked seats |
| Input creep past 55 | all | zero-slack budget + trade-in policy (§0.2) |

---

## 8. PHASE C — THE CAPTAIN'S RULINGS (issued 2026-10-08, SEATED)
1. **Budget:** HOLD exactly 55. Zero-slack trade-in policy stands (§0.2). `InpGaugeCols` and
   `InpGaugeRowH` REMAIN as inputs — no cut.
2. **Quorum-1 case:** WATCH-GRADE NOTE. A single present member agreeing is INFORMED as a
   watch-grade advisory — never silence. "We are not in the silence business." (§3.3 amended:
   quorum 2 required to FIRE; quorum 1 publishes an advisory note, clearly labeled, never
   enters the Ledger as a fire.)
3. **Apprentice default rank:** WATCH. "The apprentice is here to learn — watch and learn."
   OFF exists only as an explicit operator choice, never the default.
4. **Ledger defaults CONFIRMED:** stop 1.0×ATR(13), targets 1.0/2.0×ATR, horizon 13 bars.
   Reassessment protocol: change only on observed field need, by Captain's ruling.
5. **All remaining cards APPROVED as written.**

*Phase C closed. Phase D authorized in principle: code module by module (010→050), each
compilable alone, each commit only with the Captain's explicit approval.*
