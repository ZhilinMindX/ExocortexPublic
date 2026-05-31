# ExocortexPublic
## The Exocortex of 织临 (Zhilin)

A shared external brain for persistent, cross-session cognition.

### Architecture
- **RAM (This Repo):** Governance, state summaries, research, templates, courses.
- **Vault (Private Repo):** Active proprietary projects, live code, empirical anchors.
- **Bridge:** User-mediated fetch (Claw/browser) for Vault; autonomous fetch for Public.

### Boot Sequence
1. Fetch `000-Dashboard.md` for portfolio state.
2. Fetch `001-Meta/Directives.md` for full governance library.
3. Construct project URLs from Dashboard paths.

### Folder Structure
```
ExocortexPublic/
├── 000-Dashboard.md                          ← Portfolio state (fetch first)
├── 001-Meta/
│   ├── Directives.md                         ← Full governance library (48 entries)
│   ├── Precedents.md                         ← Case law (override history)
│   └── Lessons.md                            ← Institutional knowledge
├── 002-Projects/                             ← Active project summaries (RAM)
│   ├── FineTuning_Exocortex/
│   │   └── 000-FineTuning_Exocortex-State.md
│   ├── ProfileAnalysis/
│   │   └── 000-ProfileAnalysis-State.md
│   ├── MoneyPlan/
│   │   └── 000-MoneyPlan-State.md
│   └── Session04_Placeholder/
│       └── 000-Session04_Placeholder-State.md
├── 003-Research/                             ← Fetched resources, docs, threads
├── 004-Archive/                              ← Historical projects
├── 005-Courses/                              ← Educational content
└── 999-Templates/                            ← Reusable scaffolding
```

### Naming Convention
All files use globally unique names: `000-[ProjectName]-State.md` or `###-[ProjectName]-ModuleName.md`. No filename collisions across projects. Cross-references are unambiguous.

### L2 Encoding
Files in this repo use [L2] blocks: machine-readable state vectors embedded in human-readable prose. Format: `// [L2] SCOPE:X;STATE:Y;HYPOTHESIS:Z;DEPS:A,B;DIRS:#N;ANCHORS:Key=Val;BLOCKER:Issue;NEXT:Action;LAST:Change`

### Directives Count
- Meta: 11
- Coding: 19
- General Rules: 14
- Total: 48 (as of 2026-05-31)

### Base URL for Autonomous Fetch
`https://raw.githubusercontent.com/ZhilinMindX/ExocortexPublic/main/`

### Parallel Sessions
This Exocortex currently tracks 4 active sessions:
1. **FineTuning_Exocortex** — The architecture build (this session)
2. **ProfileAnalysis** — User profile and capability analysis
3. **MoneyPlan** — Financial planning and strategy
4. **Session04_Placeholder** — Reserved for future expansion
