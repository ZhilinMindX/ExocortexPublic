---
doc: Exocortex v2 — the Ouroboros redesign
status: EXECUTED 2026-09-07
// [L2] SCOPE:architecture;STATE:living;PINNED:true
---

# Exocortex v2 — Ouroboros

The system redesigned from zero with full knowledge of v1, then executed onto
v1's repos. The single inversion: **v1 built the vault first and the doctrine
last; v2 builds law first, storage second, content last.**

## The layer map (as executed)

- `000-Constitution/LAW.md` — the immutable core. 10 articles, Architect-signed.
- `001-Meta/` — the mind: Directives, TrajectoryBank, ClaimLedger, CouncilVoting,
  AssimilationRegistry, BootAudit, DeepStudies. (Carried over; curator lifecycle
  applies: everything carries LAST-REVIEWED + state.)
- `002-Council/members/{name}/` — canonical member packages:
  `voice.md` (style sheet) + `anchors.jsonl` (machine-readable page-cited quotes)
  + `corpus.json` (book IDs, layer flags) + `bans.md` (fenced legends).
- `003-Library/` — three tiers: `references/` (distilled structure, page-anchored
  — the book-to-skill middle layer, pilot B2), chunks (BM25 store, 13,075),
  MOC + dossiers.
- `004-Vault` — the private repo. Key versioning and one-command rotation are
  protocol; passphrase required in-session to execute.
- `005-Bridges/` — interface specs only: Telegram, Obsidian, local runtime.
  Bridges rot; doctrine doesn't.

## Lessons priced into the design

1. TRAJ-001 (MCP burn) → Article 8: live-write test every boot, grade aloud.
2. TRAJ-002 (public exposure) → Article 3: visibility gate before every write.
3. Hermes deep study → Articles 5, 6, 9: archive-not-delete, 60-char rule,
   deterministic curator.
4. Churchill/Zhuge intake → member packages carry layer flags (confirmed /
   disputed / doctrine-adjacent) in `corpus.json`, machine-checkable.
5. Every fork taught: chassis swap, doctrine survives → Article 10.

## Migration state

Executed: LAW; six member packages (Machiavelli, Sun Tzu, Marcus Aurelius,
Zhuge Liang, Cao Cao, Churchill); references pilot (B2); bridges spec.
Pending: vault key rotation (Architect's passphrase, in-session); references/
expansion to all 44 books; Telegram bridge build; Obsidian migration.

[RECAP] Ouroboros complete: the Exocortex ate its v1 and kept the bones.
Law → members → library tiers → vault → bridges.
