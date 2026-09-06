# ExocortexPublic
## The Exocortex of 织临 (Zhilin)

A shared external brain for persistent, cross-session cognition.
**v2 "Ouroboros" — law first, storage second, content last.**

### Boot Sequence
1. Read `000-Constitution/LAW.md` — the 10 articles. Nothing proceeds without it.
2. Fetch `000-Dashboard.md` for portfolio state.
3. Fetch `001-Meta/Directives.md` for full governance library.
4. Run BootAudit (`001-Meta/BootAudit.md`): grade aloud + one live-write test.

### Architecture (v2 layer map)
- **RAM (This Repo):** Constitution, governance, Council, library tiers, bridges.
- **Vault (Private Repo `ExocortexVault`):** encrypted RAG store — ciphertext only,
  44 books / 13,075 chunks, BM25 retrieval. Plaintext never in any repo.
- **Bridge:** PAT/API-authenticated writes; visibility gate before every write (LAW Art. 3).

### Folder Structure
```
ExocortexPublic/
├── 000-Constitution/
│   └── LAW.md                                ← The 10 articles (read first, always)
├── 000-Dashboard.md                          ← Portfolio state
├── 001-Meta/                                 ← The mind: governance & doctrine
│   ├── Directives.md                         ← Full governance library
│   ├── Exocortex-v2-Ouroboros.md             ← v2 design + migration ledger
│   ├── ClaimLedger.md                        ← Falsifiable claims (5 active)
│   ├── TrajectoryBank.md                     ← After-action memory (TRAJ-001/002)
│   ├── AssimilationRegistry.md               ← Borg doctrine: 10 forks, verdicts
│   ├── DeepStudy-HermesLoop.md               ← The learning-loop study
│   ├── CouncilVoting.md · BootAudit.md · MoscowRules.md · RedTeamRules.md …
│   └── StyleSheet-*.md                       ← Member style sheets (drafts/origin)
├── 002-Council/
│   └── members/{name}/                       ← Canonical member packages
│       ├── voice.md      ← style sheet (grounded, page-cited)
│       ├── anchors.jsonl ← machine-readable anchored quotes
│       ├── corpus.json   ← book IDs + layer flags (confirmed/disputed/adjacent)
│       └── bans.md       ← fenced legends & forbidden registers
├── 002-Projects/                             ← Active project summaries (RAM)
├── 003-Library/
│   ├── MOC.md                                ← Map of Content (v0.6, 44 books)
│   └── references/                           ← Book-to-skill layer (distilled
│       └── B2-36-stratagems.md                  structure, page-anchored)
├── 004-Archive/                              ← Historical projects
├── 005-Bridges/README.md                     ← Interface specs: Telegram / Obsidian /
│                                                local runtime (spec only, none built)
└── 999-Templates/                            ← Reusable scaffolding
```

### The Council (seated members)
Machiavelli (A10) · Sun Tzu (A11) · Marcus Aurelius (A12) · Zhuge Liang (A13 +
36-stratagem tradition) · Cao Cao (A11 commentary layer + same tradition,
opposed reading) · Churchill, the early voice (A14–A17).
All grounded, all page-cited, legends fenced by the Claim Ledger.

### Conventions
- **Naming:** globally unique: `000-[Project]-State.md`, `###-[Project]-Module.md`.
- **L2 encoding:** `// [L2] SCOPE:X;STATE:Y;…` machine-readable state blocks.
- **House style:** YAML frontmatter, wiki-links, [STACCATO] logs, [RECAP] closers.
- **Lifecycle (LAW Art. 5):** active → stale → archived. Delete does not exist.

### Base URL for Autonomous Fetch
`https://raw.githubusercontent.com/ZhilinMindX/ExocortexPublic/main/`
