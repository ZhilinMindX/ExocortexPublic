---
doc: Claim Ledger
version: 0.1
created: 2026-09-07
directive_refs: [16, 28]
---

# Claim Ledger — Structured Verification

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Assimilated-from-claude-obsidian(claim-ledgers)

## Purpose
Key assertions used by the Council get structured, reviewable entries.
Prose persuades; ledgers track. Pairs with [[001-Meta/TrajectoryBank]]
(decisions) and auto source-tiering (two failed checks -> demotion, no deliberation).

## Entry Template

    ### CLAIM-NNN
    - CLAIM: one sentence, falsifiable
    - SOURCE: [[book/page]] or URL; tier: VERIFIED | SHELF | UNVERIFIED
    - CONFIDENCE: HIGH | MED | LOW
    - SUPPORT: what backs it
    - CONTRADICTED-BY: what cuts against it (empty = unchecked, not "none")
    - LAST-REVIEWED: YYYY-MM-DD
    - STATUS: ACTIVE | DEMOTED | RETIRED

## Log

### CLAIM-001
- CLAIM: "The ends justify the means" is NOT a Machiavelli quote — a mistranslation.
- SOURCE: A10 The Prince (Oxford), p.160 — 'in spite of some English translations
  to the contrary, Machiavelli never said that the ends justify the means'
- CONFIDENCE: HIGH
- SUPPORT: Oxford edition editorial note; si guarda al fine passage analysis
- CONTRADICTED-BY: popular attribution everywhere (usage, not text)
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE

[RECAP] Every load-bearing claim: sourced, tiered, dated, falsifiable.
