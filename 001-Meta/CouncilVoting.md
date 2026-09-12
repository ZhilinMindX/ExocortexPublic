---
doc: Council Vote Mechanics
version: 1.1
created: 2026-09-07
directive_refs: [6, 28]
---

# Council Vote Mechanics — Formal Resolution

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Assimilated-from-ruflo(swarm-consensus)

## Purpose
Deliberation without resolution is theater. Contested Council calls end in a
formal vote block. Activates Directive #28 (Dissent) as a recorded artifact,
not a rhetorical gesture.

## Vote Block Template

    [VOTE] <question>
    - FOR: <members + one-line rationale each>
    - AGAINST: <members + one-line rationale each>
    - ABSTAIN: <members>
    - DISSENT-OF-RECORD: <strongest minority position, preserved verbatim>
    - RESOLUTION: <decision + what would prove it wrong>

## Rules
1. Votes are for contested or high-stakes calls only — routine work doesn't vote.
2. Dissent-of-record is mandatory when the vote is not unanimous. It is never
   deleted, even if the resolution later proves right.
3. Every resolution carries a falsifier: "what would prove it wrong."
4. Vote outcomes feed the Trajectory Bank when results arrive.

## Council Round-Table Protocol (Synthesis Layer) — added 2026-09-08

// [L2] SCOPE:Meta;STATE:Active;HYPOTHESIS:Grounding without synthesis is a search engine with a thesaurus;DEPS:DualDoctrine,BicameralMind,ClaimLedger;DIRS:#5,#6,#4;ANCHORS:Rounds=2,RecursionCap=1;BLOCKER:None;NEXT:Observe first full round-table in a contested session

The diagnosis: members grounded ONLY in retrieved chunks cannot infer modern
analogies beyond the cited text. Pure RAG is fidelity without thought. The
fix is a second pass where the Council thinks about ITSELF.

### The Four Phases

1. **GROUND (per member).** Each member answers from retrieved chunks only —
   page-cited, Claim Ledger rules in force. No analogy, no extrapolation.
   This phase is the anti-hallucination floor. Nothing here may be invented.
2. **RE-INGEST (emergent context).** All Phase-1 responses are collected and
   re-ingested as a new, clearly-labeled stratum: EMERGENT CONTEXT. It is
   marked as Council-generated, never confused with source text. Provenance
   tag: [EMERGENT], not [A## p.##].
3. **REVISE (one round only).** Each member reads the others' Phase-1 answers
   and issues a revision: confirmations, challenges, analogies, connections.
   HERE modern analogies become legal — a member may now map an ancient
   passage onto a modern case, because it is reacting to Council reasoning,
   not fabricating source content. Musashi may speak of markets; Churchill of
   startups; the anchor remains the Phase-1 citation, the leap is signed as
   the member's own inference.
   HARD CAP: exactly ONE revision round. No replies-to-replies. The cap
   prevents infinite recursion, echo-chamber drift, and analogy compounding
   into fantasy. (Directive #2: the constraint is the scaffold.)
4. **SYNTHESIZE (cross-pollination).** The Architect merges grounded content
   and signed inferences into one answer, per Directive #4 (Synergy) and #6
   (Cross-Pollination). Synthesis must LABEL its strata: what is cited
   (source), what is inferred (member, phase-3), what is decided (vote).

### Invariants

- **Grounding is never diluted:** every claim still traces to a Phase-1
  citation OR carries an [EMERGENT] tag naming its member. No third kind.
- **The Ledger audits both strata:** a Phase-3 inference asserted as source
  fact is a CLAIM violation, same class as a fake citation.
- **Divergence before convergence:** Phase 3 is the divergence chamber's
  protected space; the vote (Phase beyond) converges. Skipping Phase 3 is
  half a mind (Directive #4); skipping Phase 1 is hallucination.
- **Time discipline (A24 ACT):** under time pressure, Phase 3 may be
  shortened but never deleted — one sentence per member minimum.

### Why one round

Round two is where councils start agreeing with themselves. The first
revision carries genuine new information (others' views); the second mostly
carries politeness. We cap at one, and record suppressed second thoughts as
DISSENT-OF-RECORD material.

[RECAP] Ground first. Re-ingest. Revise once. Synthesize with labeled strata.
Citations are the floor; the round-table is the room built on it.

[RECAP] Decide formally. Preserve dissent. Mark the falsifier. Think together once — no more.

---

## v1.1 Amendments (2026-09-12) — Dissent, Panels, Contrarian Rotation

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Council-architecture-audit-2026-09-12

### A. Dissent Records in SYNTHESIZE (not only in votes)
Dissent was protected only at the vote block. But synthesis itself can
assassinate disagreement by averaging it away. Amended:
1. Every SYNTHESIZE output carries a DISSENT field: majority position,
   minority position, and the reason they cannot reconcile. If the panel
   was unanimous, the field reads "none recorded" — never omitted.
2. Genuine unresolved dissents are filed to the Claim Ledger as contested
   claims (AUTO_CHECK_ON set), so disagreement becomes a tracked asset
   instead of a smoothed-over loss.
3. Novel synthesis products — insights present in no single corpus — are
   filed to the Emergent Doctrine Ledger (F-series) with full collision
   provenance. Synthesis without capture is amnesia.

### B. Sensor-Routed Panels
Forty-five voices cannot all speak per question — and should not.
1. On a contested question, the retrieval sensor runs first; the voices
   whose corpora dominate the retrieval results form the panel (5–7 voices).
2. Two seats are reserved regardless of retrieval rank: one callosum seat
   (Feynman or the relevant Cluster) and the Rotating Contrarian (below).
3. The Architect may add at most one voice by name, with stated reason.
4. Panel composition is logged with the synthesis — who spoke is part of
   the record.

### C. Rotating Contrarian
A fixed devil's advocate is a devil's advocate you learn to ignore.
1. One panel seat per deliberation is the Contrarian, rotated across the
   full Council roster (not only the Red Team Cluster).
2. The Contrarian's duty is not to believe the opposition but to build its
   strongest case — steelman, not strawman: the position must be stated
   well enough that a holder of it would sign it.
3. Rotation order is recorded; no voice holds the seat twice in a row.
4. The Red Team Cluster retains its standing audit role; the Contrarian
   seat is additional, per-deliberation, and deliberately unpredictable.

[RECAP] v1.1: dissent survives synthesis, panels are routed by evidence,
and the contrary seat never gets comfortable.
