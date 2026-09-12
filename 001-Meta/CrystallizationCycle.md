---
doc: CrystallizationCycle
version: 1.0
status: active
created: 2026-09-12
origin: SecondOpinionReview-2026-09-12 adoption B.1 (Architect order: "absorbed, adopted and assimilated, at once")
---

# The Knowledge Crystallization Cycle — From Deliberation to Doctrine

## Purpose

Deliberation produces heat; crystallization produces structure. This rite
makes the passage from *experience* (Trajectory Bank, Claim Ledger) to
*doctrine* (F-series) a **scheduled, formal process** instead of a happy
accident. The Exocortex already had the substrate; this is the machine
that runs on it.

## The Two Workspaces (made explicit)

- **The Chamber** — live deliberation. Messy, fast, adversarial. Writes
  trajectories and claims.
- **The Still** — the crystallization workspace. Cold, slow, reflective.
  Reads the ledgers. Proposes doctrine. (Named for distillation: what
  survives the still is spirit, not mash.)

## The Rite (periodic + triggerable)

**Cadence:** every 20 trajectories, or on the Architect's order, or when
voice_health() telemetry shows an anomaly pattern.

**Procedure:**
1. **SWEEP** — read all new trajectories and resolved/open claims since
   the last run. List recurring claims, validated predictions, falsified
   predictions, and decision patterns with observed outcomes.
2. **DISTILL** — apply the four formal operations:
   - `GENERALIZE(claims...) -> doctrine-candidate` — specific repeated
     claims become a general principle.
   - `CONTRADICT(candidate, ledger) -> conflict-report` — check the
     candidate against existing F-entries and standing doctrine;
     contradictions force explicit resolution, never silent coexistence.
   - `REFINE(F-###, evidence) -> revised band` — adjust confidence bands
     on existing doctrine per new evidence (Brier scores from resolved
     claims feed here).
   - `RETIRE(F-###, reason)` — doctrines that consistently fail are
     retired, archived, never deleted (Art. 5).
3. **COUNCIL TEST** — each doctrine-candidate faces a sensor-routed panel
   (CouncilVoting v1.1): generation → adversarial verification →
   integration. Dissent is recorded.
4. **RATIFICATION GATE** — the Architect reviews the still's output.
   Nothing enters the Emergent Doctrine Ledger without the Architect's
   word. This gate is constitutional, not advisory.
5. **RECORD** — ratified entries get F-numbers with full provenance
   (parent trajectories and claims named — see EmergentDoctrineLedger
   v1.1 schema). Rejected candidates are logged with reasons.

## Decay Clause

An F-entry not re-validated by any trajectory within 10 crystallization
runs has its Kent band decayed one step at the next run, with a
re-examination note. Doctrine, like memory, proves itself by use —
telemetry before decay (F-002) applies to doctrine itself.

### Changelog
- v1.0 (2026-09-12): initial rite, adopted from the second-opinion
  review's Knowledge Crystallization Cycle (NFD pattern), hardened with
  CONTRADICT and the constitutional ratification gate.
