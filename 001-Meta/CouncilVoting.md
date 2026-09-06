---
doc: Council Vote Mechanics
version: 0.1
created: 2026-09-07
directive_refs: [20, 28]
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

[RECAP] Decide formally. Preserve dissent. Mark the falsifier.