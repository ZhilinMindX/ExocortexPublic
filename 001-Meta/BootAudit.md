---
doc: Boot Self-Audit
version: 0.1
created: 2026-09-07
directive_refs: [16, 52]
---

# Boot Self-Audit — Session Start Grading

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Assimilated-from-ruflo(MetaHarness)

## Purpose
Every session start, after the Boot Protocol fetch, grade the Exocortex state
out loud. Silent degradation is the enemy (see: raw-CDN staleness incident).
Format: `BOOT: N/10 — [flags]`.

## Checklist (1 point each)

1. Public repo reachable via API (not raw CDN — cache lies)
2. 000-Dashboard parsed; RECAP anchors match reality
3. 001-Meta/Directives parsed; count matches registry
4. 001-Meta/CouncilOfVoices parsed; version noted
5. 003-Library indexes parsed (Gutenberg Shelf + Personal Collection)
6. Vault status known (what's committed vs pending — no phantom claims)
7. Workspace state checked (/mnt/agents intact, /tmp assumed wiped)
8. Tooling probe: one small live test per capability before depending on it
9. Open incidents from Trajectory Bank reviewed
10. Session goal confirmed with Architect before heavy work

## Grading
- 10/10: full operational
- 8–9: operational with known limitations — state them
- 6–7: degraded — fix before heavy tasks
- <6: critical — maintenance session, no project work

## Rule
The grade is REPORTED, not computed silently. One line, every boot.

[RECAP] Assume nothing (Moscow Rules #1). Grade everything. Report it.