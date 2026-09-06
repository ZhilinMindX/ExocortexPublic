---
type: deep-study
target: NousResearch/hermes-agent (242k★, "The agent that grows with you")
focus: the self-improving skill loop
studied: 2026-09-07
sources: agent/learn_prompt.py, agent/learning_graph.py, agent/learning_mutations.py, agent/curator.py, README.md
// [L2] SCOPE:assimilation;STATE:ratified
---

# Deep Study — The Hermes Learning Loop

## 0. The loop, as they built it

```
experience ──/learn──> SKILL.md (authored in-turn, HARDLINE standards)
     │                        │
     │                   usage tracking (.usage.json: last_used, last_patched)
     │                        │
     │                   CURATOR (idle-triggered, not cron)
     │                   active → stale(30d) → archived(90d) → never deleted
     │                        │
     └── LEARNING GRAPH (skills + MEMORY/USER chunks as nodes,
                        related_skills links + lexical-overlap memory links,
                        user-editable via /journey)
```

Four mechanisms, each separable. We study them one by one.

---

## 1. HARDLINE skill-authoring standards (learn_prompt.py)

Their most-violated rule is the most instructive: **skill description ≤ 60 chars,
because the system-prompt skill index truncates at 60 and loads every session —
anything past char 60 is silently cut and never routes.**

Other ratified rules:
- One sentence, capability not implementation, no marketing words.
- Body section order fixed: intro → When to Use → Prerequisites → How to Run →
  Quick Reference → Procedure → Pitfalls → Verification.
- **Never invent flags, paths, or APIs — verbatim from source or nothing.**
- ~100 lines simple, ~200 complex. Scripts in `scripts/`, references in
  `references/`, templates in `templates/` — not inlined.
- **Fold-in, don't duplicate:** extend an existing skill rather than spawning
  near-duplicates.
- **author: always the literal product name.** Never fill from OS user, git
  config, or any probeable identity — a shared artifact carrying
  environment-derived identity is a privacy leak the user never opted into.

## 2. Book-to-skill layout (the knowledge-base skill)

Their answer to large prose sources — and the missing middle layer in OUR stack:

- SKILL.md = lean always-loaded core: central mental models + decision rules,
  then an index of reference files, each with a one-line "load this when…".
- One file per chapter under `references/`, 100–150 lines, **distilling
  STRUCTURE not summary**: frameworks, definitions, decision rules,
  anti-patterns, key numbers — with chapter/section refs back to source.
- **Incremental processing:** inventory first, then read-distill-persist ONE
  chapter at a time. Never load the whole corpus into context.
- Reference files cost nothing until queried — "query cost tracks the answer,
  not the source."
- **Synthesize, never reproduce** — structured notes ABOUT the source, no
  verbatim passages beyond a short quoted phrase. Stated as both the quality
  bar and the copyright line.

## 3. The Curator (agent/curator.py)

Background maintenance WITHOUT a cron daemon — **inactivity-triggered**: runs
when the agent is idle ≥2h and last run is older than the interval (default 7d).

Lifecycle (deterministic, timestamp-driven):
- `active → stale` after 30d without use; `stale → archived` after 90d.
- **Never delete, only archive** — recoverable via `curator restore`.
- **Pinned skills bypass all auto-transitions.**
- LLM consolidation fork (pin/archive/consolidate/patch via a forked agent on
  the auxiliary client) is **OPT-IN, off by default**; the deterministic prune
  always runs. The fork never touches the main session's prompt cache.
- **First-observation safety:** a fresh install seeds `last_run_at` and defers
  one full interval — the tool never mutates the library on its first tick.

## 4. The Learning Graph (learning_graph.py + learning_mutations.py)

"Learning made visible": skills AND memory chunks (MEMORY.md / USER.md) as
first-class nodes. Skill→skill links from declared `related_skills`;
memory→skill links DERIVED from lexical overlap. User can inspect, edit, and
delete (delete = archive for skills, rewrite for memories) via `/journey`.
Usage timestamps (`last_used_at`, `last_patched_at`, `use_count`) ride on every
node and drive the curator.

---

## 5. Borg verdict — assimilate / adapt / reject

### ASSIMILATE (directly, near-verbatim)

1. **The 60-char rule** → applies to OUR skill artifacts today
   (mql4-forensic-review and all future ones). The truncation-and-silent-cut
   failure mode is real in our own host. Codified as Doctrine rule below.
2. **Curator lifecycle onto the ClaimLedger** — CLAIM entries already carry
   LAST-REVIEWED and STATUS: ACTIVE|DEMOTED|RETIRED. Add the transition rule:
   ACTIVE → DEMOTED after 90d unreviewed; RETIRED = archived, never deleted.
   Deterministic, no LLM needed. Same for TrajectoryBank verdicts.
3. **Never-delete-only-archive** → house law, everywhere.
4. **Fold-in don't duplicate** → already implicit; now explicit.
5. **The author/privacy rule** → public-repo artifacts never carry
   environment-derived identity. We comply already; now it's written.

### ADAPT (their pattern, our constraints)

6. **Book-to-skill = the upgrade path for our 40-book library.**
   Their layout maps 1:1 onto our stack: SKILL.md core ≈ our style sheets
   (voice + decision rules, always loaded); `references/` per chapter ≈ a new
   distilled-structure layer BETWEEN raw page-cited chunks and the persona.
   Adaptation: our references/ files must keep **page anchors** (their layout
   cites chapter/section; ours cites book+page — stricter). This becomes the
   grounding fast-path: BM25 over chunks for lookup, references/ for structure.
   Pilot candidate: B2 (36 Stratagems, Verstappen) — small, structured, and
   already doctrine-central.
7. **Learning graph → Obsidian migration spec.** Their derived lexical-overlap
   links are what our MOC + wiki-links become when we add embeddings later.
   Defer until Obsidian; design recorded here.
8. **Inactivity-triggered maintenance → boot-adjacent.** We have no daemon;
   our equivalent is BootAudit: add a "maintenance check" item — on boot,
   report claims/trajectories past their review interval. Cheap, deterministic.

### REJECT

9. **Honcho dialectic user modeling** — heavy external service modeling the
   user across sessions. We have one Architect and a Directives file; the
   dossier is curated, not inferred. Out of doctrine (and a privacy surface).
10. **Aux-client LLM consolidation forks** — token-hungry background agents.
    "Precious tokens." Our curator is deterministic-only.
11. **Their state subsystem scale** (15+ hermes_state_* modules, FTS5 session
    search) — right for a product, wrong for a vault. BM25 over 12k chunks is
    sufficient until >50 books (standing decision).

## 6. Doctrine amendments ratified by this study

- **D-SKILL-1:** Every skill description ≤60 chars, one sentence, capability
  only. Count before saving.
- **D-SKILL-2:** Synthesize, never reproduce. Structured notes ABOUT a source;
  verbatim limited to short anchored quotes.
- **D-LIFE-1:** Nothing is deleted. States: active → stale → archived.
  Archive is recoverable; delete does not exist.
- **D-LIFE-2:** Pinned items bypass all auto-transitions. (Our Directives are
  all pinned by definition.)
- **D-OPS-1:** Fresh-start safety: no maintenance mutation on first
  observation; seed the clock, defer one cycle.
- **D-SEC-1:** Shared/public artifacts never embed environment-derived
  identity.

[RECAP] Hermes's loop = author (HARDLINE) → track (usage) → curate (idle
lifecycle, archive-not-delete) → visualize (graph). We take the standards, the
lifecycle, and the book-to-skill layout (as our grounding fast-layer, with
stricter page anchors); we reject the user-modeling service and token-hungry
LLM consolidation. The loop's soul — skills that improve during use — is
already ours: TrajectoryBank + ClaimLedger + style sheets, now with lifecycles.
