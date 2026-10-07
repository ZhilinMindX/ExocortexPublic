# WAR ROOM v7 — REFACTOR BLUEPRINT
**TeknoLite_Beacon_Consensus v7.00 — "The Ouroboros Build"**
**Version:** 1.4 · **Issued:** 2026-10-08 · **Authority:** Captain's directive ("Run the Ouroboros")
**Supersedes:** nothing — v6.39 remains the field flagship until v7 is field-proven
**Sources digested:** 27 iteration archaeology (v0.2β→v6.39) · 18 fossil laws (FL-1..18) · 34 ledger laws + 38 codex practices · 11 field journals + FleetWisdom · Chimaera ML survey · Trident ledger assimilation + Second Opinion · BOB v4.32 output-contract audit · live-desk .set review · all seated Captain's rulings

---

## §0 — THE MISSION, AS RULED

> **"Detect who is absent, who is present, and when one or more agree, inform."**

Layer 1 is the whole public face: **Buy / Sell / Wait**. Everything else — ledger,
ML, context, combos — is *internal organs* that make the face honest. The War
Room must never again grow a feature that doesn't serve the sentence above.
(FL-8 taught what uncontrolled growth looks like: 145 inputs. v7 treats inputs
as debt.)

**Design axiom:** *Simple face, smart gut.* The trader sees a word; the machine
earns the right to say it.

---

## §1 — ARCHITECTURE (the five organs)

```
        ┌─────────────────── WAR ROOM v7 ───────────────────┐
        │                                                    │
 fleet  │  1. PRESENCE REGISTRY ──► 2. SIGNAL NORMALIZER     │  Layer 1
 beacons│     (roll call, hearts)     (Buy/Sell/Wait only)   │  output
        │            │                     │                 │
        │            ▼                     ▼                 │
        │  3. COUNCIL (weighted vote, softmax weights ◄──┐   │
        │            │                                  │   │
        │            ▼                                  │   │
        │  4. FLEET LEDGER (every candidate, fired or   │   │
        │     not, ATR frame, resolved honestly) ───────┘   │
        │            │            feeds weights             │
        │            ▼                                      │
        │  5. APPRENTICE (learns from ledger rows; WATCH    │
        │     rank at birth; advises, never rules)          │
        │                                                    │
        └─────────── ink: arrows + InfoLine + dispatch ─────┘
                     (button gates ink only — sovereignty)
```

Five organs, five modules, one machine each (L1). Nothing else. Every v6.39
subsystem not in this list is either folded into an organ or honorably retired
to the Museum.

---

## §2 — ORGAN 1: PRESENCE REGISTRY *(the Captain's self-adjusting consensus)*

**Mission:** know the fleet's true muster at every bar. Absent = removed seat,
never zero vote. (Ruling, 2026-10-07; fossil FL-6: v6.34.1's [11]-vs-Veles kill.)

- **Roster as data, never constant.** One table `g_roster[]` — name, beacon
  grammar, heartbeat GV, role. Every array in the engine is sized from
  `ArraySize(g_roster)` at init. There is no `12` anywhere. (FL-6 structurally
  impossible.)
- **Heartbeat contract.** Each member publishes `_Alive` = last-calc bar time.
  Presence = heartbeat fresh within TTL (SPHINX doctrine). A member that
  speaks no signal but beats its heart is **present and silent** (a Wait);
  a member without heartbeat is **absent** — its seat is removed from the
  denominator. (Fixes the class of "inferred absence" bugs; FL-3 family.)
- **Adoption hop preserved.** Namespace `g_nmid = Class_Symbol_TF` unchanged;
  GVAdopt() grafts ancestor memory forward. (FL-7: no lobotomies.)
- **Cold start.** Registry musters in OnInit from heartbeat GVs alone — works
  even if a member attaches after the Admiral.

## §3 — ORGAN 2: SIGNAL NORMALIZER *(the return to first principles)*

**Mission:** every hull's dialect becomes one word: **Buy / Sell / Wait**.
(Ruling, 2026-10-08. v0.2β's 7-level scale was the first try; BOB's 6-grade
beacons were the dialect that made it necessary. v7 makes Layer 1 the *only*
cross-fleet language.)

- **One function:** `Normalize(member) → {+1, 0, −1}`. Per-member translation
  table, small and explicit: BOB's SBU/BU/TU → +1; TLA events → direction;
  Hydra beacons → direction; pure triggers pass through unchanged. Members'
  own description texts ride alongside as display annotation for the Gauge
  (as today), never entering the vote — weights come from ledger evidence.
- **Semantic honesty law (codified):** *the War Room never infers what a
  member could say, and never asks a member to say what it cannot know.*
  Vertex never claims "strong"; BOB never pretends to be a trigger. Strength
  is **not inferred** — see §5: strength lives in the ledger's evidence.
- **Wait is a first-class word.** A member may honestly say Wait (BOB's RANGE,
  Hydra grounded). Wait votes count as *present, backing no side* — the
  grounded-seat mechanics of v6.35–6.39 survive, generalized to every member.
  (FL-15.)

## §4 — ORGAN 3: THE COUNCIL *(voting, self-weighted)*

**Mission:** when one or more agree — inform. Nothing more. (§0.)

- **Generation vs. decision:** candidates form by unweighted raw agreement
  of present members (loop-safety §5); the weighted posterior only gates
  firing. Each present member casts +1/0/−1. Consensus fires when the
  weighted posterior crosses the scenario floor (Aggressive 0.62 / Moderate
  0.68 / Conservative 0.72 — scenario machinery survives, it is proven field
  gear).
- **Weights are learned, not set.** Each member's vote weight = softmax over
  its **ledger record**, recency-decayed (Chimaera physics), seeded from the
  live-desk weights as priors with SeedHumility governing the ramp (§12.3).
  The desk stops diluting specialists because the specialist's 55% and the
  laggard's 42% *weigh differently by evidence*. (Journal finding: desk 44%
  vs specialists 55% — the core v7 requirement.)
- **Museum:** Strict and Free Vote modes retained behind an input — they cost
  60 lines and carry the fleet's history. (Museum doctrine, v5.00.)
- **No hand on the scale.** GARCH/tide/context never gate directly; they
  teach through the ledger. (FL-9: teachers teach, they don't throttle.)

## §5 — ORGAN 4: THE FLEET LEDGER *(Trident's spine, Chimaera's grading, Admiral's honesty)*

**Mission:** every consensus candidate — **fired or not** — becomes a tracked
simulated trade with a consequence. This is the organ that makes the War Room
smart without making it complicated. (Rulings: own CSV journal + ring buffer
of last N entries; unified ATR frame; Trident replay REJECTED — incremental
spine only.)

- **Row anatomy** (one row per candidate):
  `time, dir, roster mask, present count, entry (= open of next bar — real
  fill honesty, v6.00), stop, target (= ATR multiples — unified frame,
  ruling 2026-10-08), context bin, resolved (win/loss/timeout), MFE, MAE,
  bars held, hold/fire reason`.
- **Grading:** Chimaera reward physics on Trident rows — ATR-normalized
  return + MFE bonus − MAE penalty, √duration discount. Doctrine selectable
  (BALANCED default; CLEAN_MOVE / WIN_RATE / PCT_RETURN as input enum).
- **Honesty law enforced:** resolved only when the path plays out; entry at
  next bar's open; no look-forward anywhere (L24; Chimaera's flip-time
  scoring explicitly refused).
- **Memory:** ring buffer of last N (responsiveness — Captain's ruling) +
  CSV append journal (permanence) + GV digest for cross-session weight state
  (Admiral persistence; Chimaera's amnesia refused).
- **Wait is graded too.** Held candidates resolve against the same ATR frame:
  avoided loss = earned caution. The fleet learns what its silence is worth,
  and the Gauge's JOURNAL line shows it (§12.7).
- **LOOP-SAFETY DOCTRINE (Captain's ruling, 2026-10-08):** the
  self-referential loop (weights → fires → ledger → weights) is severed at
  both joints by design:
  1. **Generation is weight-free** — candidates are generated by unweighted
     raw agreement of present members; weights never decide what is
     considered.
  2. **Weights gate firing only** — never data collection.
  3. **The ledger grades everything generated** (fired and held) — the
     measurement never depends on the decision.
  4. **Damped** — EWMA + SeedHumility prior + max weight delta per day:
     weights are a glacier, not a weathervane.
  5. **Walled** — weights clamp to trust bounds around priors: no member
     voted off the island by a spiral; none becomes tyrant.
  6. **Gated** — a weight moves only on mature evidence (n ≥ 21, beat the
     incumbent by one SE — one law, three hats).
  7. **Observable** — weight trajectories journaled per member; the Captain
     holds manual override (pardon/demote by hand).
  Residual risk is epistemic only (the market itself changing) — solved by
  watchfulness, not architecture.
- **Replay:** on demand, lookback-capped (InpMaxBars law, L27; Trident's
  per-tick full replay stays rejected inside the graft).

## §6 — ORGAN 5: THE APPRENTICE *(ranked, honest, small)*

**Mission:** learn which voices matter, in which weather — and prove it
before touching the vote.

- **Model:** one logistic layer over the feature vector (Admiral's proven
  17-feature anatomy, roster-driven so features survive roster changes).
  Small on purpose: it must run per-bar in MQL4 forever.
- **Diet fixed at the root:** training rows come from the **Fleet Ledger** —
  fired *and* held candidates — ending the censored-sample starvation of
  v6.39's apprentice. (The ledger IS the ML upgrade.)
- **Ranks:** OFF / WATCH / VOTE, blend-ramped by sample count
  (`blend = min(1, n/Nmin)`). Ships in WATCH. The apprentice earns the podium;
  it is never seated on it. (v4.00 doctrine, kept.)
- **Persistence:** weights in GV, namespaced per market class; adoption hop
  on rename. (FL-7.)

## §7 — THE INK *(output contract, simplified)*

- **Alert payload = Fleet Dispatch, one line:** herald `[ -= TF : Symbol :
  Hr:Mn =- ]` stamped with the **signal candle's own time**, then the word:
  BUY / SELL. Once per signal candle, consensus-only. (FL-18, forensics-first.)
- **Layer 2 lives in the journal, not the alert.** Roster mask, weights,
  ledger id, context — all journaled for those who read fine print; the alert
  stays Layer 1 pure. (Mission discipline, §0.)
- **Arrows:** one code, two colors, expiry-gated (InpArrowExpiryBars — "war
  room, not attic", FL-13). Monochrome-desk question referred to Palette
  standard (§12.5).
- **InfoLine = The Gauge (PRESERVED, Captain's ruling 2026-10-08 — "a VERY
  NEAT and USEFUL feature… when it started to display as a VU meter, it was
  like magic").** The Gauge carries forward with its proven mechanics
  **unchanged**, plus one smart upgrade:
  - **MECHANICS FROZEN AS FIELD-PROVEN:** the role-deck rows (RED TEAM
    crowning the column, TRIGGER beside the needle), the lamp physics
    (`LampColor`: bull/bear base, bright = within the first half-life
    [decay ≥ 0.50, v5.22], dim = aging, gray = silent), the per-member
    declared text (word + description + age + calibrated p%). The coloring
    already runs on what members declare — it stays exactly as it works
    today. (Captain's ruling: "don't change HOW it works regarding the
    colors.")
  - **ROLL CALL IS THE TRUTH (the smart upgrade):** the Gauge shows ONLY
    present members. Absent members are REMOVED from the stack entirely —
    no "name: off" rows, no gray ghosts, no shaded tombstones. (Fossil:
    OHLCV, retired at sea in v6.35, kept haunting the Gauge versions later.)
    The stack IS the muster: if you see a name, it's on duty. Rows re-seat
    dynamically as the Presence Registry muster changes.
  - **Weight marker (additive only):** each lamp may append the member's
    current ledger-fed vote weight — the learning made visible. Display
    annotation only; does not alter lamp physics.
  The word (BUY/SELL/WAIT), ledger tally, and apprentice rank ride the same
  stack as today.
  Doctrine: **Layer-1 purity applies to alerts, never to the Gauge** —
  the dispatch says the word; the Gauge shows the whole war.
- **Button:** Fleet Standard module, gates ink only — engine, beacons,
  ledger, apprentice never sleep. (Sovereignty, L2/R7; grafts the v3.2
  patched module — explicit bevel BORDER_RAISED, log-tag=build parity,
  one-family-per-chart documented; patch authorized 2026-10-08.)

## §8 — CROSS-CUTTING LAWS (every organ, no exceptions)

1. **Unified Starting Defaults** — one bars-history standard, one ATR length,
   one anchor policy; deviations justified in header HYPOTHESIS. (Codex #11.)
2. **Temporal Honesty** — every read time-indexed; entry at next bar's open;
   evaluation after window close. (L24, FL-3.)
3. **Bounded everything** — every loop capped; no per-tick history replay.
   (L27, Codex #5.)
4. **Two-plane audit at delivery** — Mechanism AND Contract pass, plus a
   Second Opinion + Differential analysis. (L22, L28, standing order.)
5. **Representation Parity** — banner = build, log tags = build, InkVersion
   = truth. (L23; FL-8's seven lying banners are the fossil.)
6. **Roster arithmetic has no literals** — array sizes derive from the
   registry. (FL-6.)
7. **Namespace continuity on any rename** — memory adoption hop. (FL-7.)
8. **b1470 hygiene** — explicit 3-arg object calls; fail-loud validation;
   inputs append at END only. (Codex #6, #9, #10.)
9. **Versioning discipline** — `#property version` = banner = filename =
   changelog head; archive induction verifies all four. (FL-17.)
10. **Telemetry** — L2 one-liner per module (SCOPE/STATE/HYPOTHESIS),
    ### step log FIFO-last-3, failures first. (Codex #19, #20.)

## §9 — WHAT IS RETIRED (the Ouroboros eats)

| From v6.39 | Fate | Why |
|---|---|---|
| Combo fingerprint machinery (BC_CMB/CMBX) | **Folded** into Ledger roster-mask column | the ledger row IS the combo record; two systems grading ensembles = L1 violation |
| Context combo weather records | **Folded** — context bin rides the ledger row | same |
| TBSH Scout | **Dissolved** — every pair now shadow-graded by the ledger | the Scout was the ledger's prototype; the prototype's job is done |
| Session/spread dial machinery | Retired (OTC desk, v5.00 decision) | field-proven dead weight |
| 7-level cross-fleet state scale | Retired from voting; members' native declarations survive as Gauge display annotation (as today) | mission simplicity (§0); the War Room renders member declarations, never infers them |
| 145-input surface | **Contract target: ≤ 55 inputs** (Captain's ruling, 2026-10-08) | inputs are debt; scenario presets absorb the rest (v3.29 machinery kept) |

## §10 — BUILD ORDER (module by module, each compile-clean)

1. **Skeleton + Presence Registry** (heartbeat read, roster table, roll-call
   Gauge display) — field-test: attach with partial fleet, verify seats adjust.
2. **Signal Normalizer + Council** with *static* weights — parity test:
   v7-with-static-weights must reproduce v6.39's decisions on replay.
3. **Fleet Ledger** (ring buffer + CSV + ATR frame + honest resolution) —
   WATCH only, zero effect on votes. Collect rows.
4. **Softmax weights fed by ledger** (Organ 3 activates, seeded from live-desk
   priors per §12.3) — A/B against step-2 decisions; journal the deltas.
5. **Apprentice on ledger diet** — WATCH rank; promotion only by sovereign
   test (mature + beat desk by 1 SE — one law, three hats, v6.20).
6. **Ink finalization** — dispatch, arrows, Gauge roll-call seating, button
   module graft (v3.2 patched form, authorized).

Each step ships behind the scenario input; each step is revertible
(window=0 doctrine, FL-5: the new protocol carries the old as a degenerate
case).

## §11 — CONFORMANCE GATES (before v7.00 is called done)

- [ ] Two-plane audit + independent Second Opinion + Differential log
- [ ] Parity: replay window reproduces v6.39 decisions (static-weight mode)
- [ ] Presence test: fleet at 12, 7, 3, 1 members — seats adjust, no array
      fault, no division by absent zero; absent members absent from the Gauge
- [ ] Fresh-chart test (ghost sweep), reload test (memory continuity)
- [ ] Ledger CSV verified against hand-graded sample of 50 rows
- [ ] Alert forensics: candle-time stamp, once-per-candle, silence=silence
- [ ] Input count ≤ 55 (Captain's ruling); every input documented one line
- [ ] Header banner = version = filename = changelog (FL-8/FL-17 gate)

---

## §12 — AMENDMENTS FROM THE LIVE-DESK REVIEW (2026-10-08)

Basis: the desk's live `.set` (SCENARIO_BINOPT, Approach Aggressive, floor 0.65,
eval horizon 8, ML WATCH; weights Hydra 2.1 / Vertex 2.1 / TLA 1.5 / Location
trio 1.3 / Chimaera+TrendBars 0.8 / Basilisk+Divergence+Volume 0.3; OHLCV off;
button at X=277; arrows monochrome 9221330) plus the 21-file live `.set`
survey of the full fleet desk.

1. **The `.set` migration contract — RULED (Captain, 2026-10-08): COMPATIBLE.**
   v7 ships with an old→new input-layout appendix; the desk's live `.set`
   migrates by mapping, values never silently mis-seat. The `.set` is senior
   (L16) — v7 honors the desk's file.
2. **Heartbeat bridge.** No member emits `_Alive` today. v7 Presence Registry
   must accept *speech as proof of life* (any fresh beacon = heartbeat) until
   members are recompiled with explicit heartbeats. No flag day (FL-5).
3. **Seed-weights-as-priors.** The live weights are months of distilled field
   wisdom. v7's ledger-softmax blends over these priors, with the existing
   SeedHumility (0.3) governing the ramp: constitution first, evidence amends.
   Nothing learned is thrown away.
4. **Unified Starting Defaults — survey-first.** The 21 live `.set` files are
   the real defaults survey (bars history, ATR lengths, anchors across every
   desk member). The standard is extracted from convergent behavior (L6),
   then legislated — survey precedes the number.
5. **Monochrome arrows flagged.** Bull/bear arrows share gray 9221330 —
   direction carried by glyph (71/72) alone. Deliberate or drift? Referred to
   the Palette & Branding standard for ruling.
6. **Vol-clock broker-time caveat.** The 24h clock keys on server time; OTC
   and FX calendars differ, DST shifts FX servers. Journal records the
   broker offset at learning time so a winter clock isn't applied in summer.
7. **Wait telemetry.** The ledger grades held candidates; the Gauge's JOURNAL
   line gains one counter — earned caution made visible ("silence: 8 of 11
   saved"). If Wait is first-class, its record is displayed.
8. **Dispatch ergonomics (proposal).** Multi-desk notification storms (same
   symbol, M1+M5) — optional quiet/dedup for Notify only; alerts stay
   forensically complete. Awaits Captain's ruling; sovereignty says the wire
   never sleeps.

---

*The Ouroboros has eaten: 26 iterations, 18 fossils, three schools of
learning, one ledger spine. What remains is the mission, made smart where
the trader cannot see, and simple where the trader must act.*
