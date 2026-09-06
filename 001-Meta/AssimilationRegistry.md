---
doc: Assimilation Registry
version: 1.0
created: 2026-09-07
directive_refs: [9, 15, 16, 28, 46, 52]
---

# Assimilation Registry — Borg Doctrine

// [L2] SCOPE:Meta;STATE:Living;ORIGIN:Architect-mandate-2026-09-07

> Mandate: everything the competition (Claude ecosystem, Hermes, OpenAI,
> agent harnesses, doppelganger projects) does is to be analyzed, and what
> benefits us is to be assimilated, copied, or improved upon. Both grounding
> AND member-model philosophies are pursued, adapted to our constraints.
> Resistance is futile. Mediocrity is not assimilated.

## I. Forked Arsenals (reference copies under ZhilinMindX)

| Fork | Why we keep it |
|---|---|
| ruvnet/ruflo | Swarm harness: trajectory learning, GOAP planning, readiness grading |
| NousResearch/hermes-agent | Closed learning loop: skills-from-experience, self-improving skills, session search, user modeling (Honcho), Telegram/Discord/Slack gateway |
| xming521/WeClone | Chat-history -> model pipeline: export, PII filtering, dataset build, local fine-tune, Telegram bot serving |
| AgriciDaniel/claude-obsidian | Compounding vault loop: capture -> ground -> connect -> reuse; claim ledgers; MOCs; Obsidian-native |
| khoj-ai/khoj | Second-brain RAG reference: custom agents over personal docs |
| brianpetro/obsidian-smart-connections | Semantic linking inside Obsidian; embedding-based note relations |
| jnMetaCode/agency-agents-zh | 267 ready expert-role definitions — persona-pack design patterns |
| screenpipe/screenpipe | Local continuous context capture (24/7 memory substrate) |
| ChainedTears/mlx-twin | Privacy-first local clone pipeline (Apple Silicon) — minimal reference |

## II. Assimilated (already committed)

From ruflo: TrajectoryBank, BootAudit, Project-Schema (GOAP), CouncilVoting.
From doppelganger field: this registry; claim-ledger + MOC + compounding-loop
doctrine (Section IV pending implementation).

## III. THE DUAL DOCTRINE — Grounding x Persona Models

The doppelganger field splits into fine-tune-to-BE vs ground-in-material.
The Council adopts BOTH, reframed: the target is not a clone of the Architect —
it is the CONSTRUCTION OF COUNCIL MEMBERS, each grounded in our Library.

    MEMBER = base LLM
           + Persona Adapter (style/stance trained from member's works)
           + RAG grounding (our chunks, page-cited, mandatory)
           + Dossier + Claim Ledger (audit layer, human-readable)

Rules:
1. Grounding is non-negotiable. A member that cannot cite its shelf is a
   hallucination machine. Adapters shape VOICE; RAG supplies TRUTH.
2. Adapters are unauditable weights -> the Claim Ledger and dossier remain
   the authority of record. Weights never override documents.
3. Training corpus order: public-domain works first (Gutenberg shelf: Machiavelli,
   Sun Tzu, Marcus Aurelius, Musashi, Kybalion, Clason...) -> zero rights friction.
   Purchased-corpus training stays inside the same discipline as the vault:
   local only, artifacts private.
4. Staged plan: (a) style sheets distilled from works via RAG [document-level,
   zero cost, do first]; (b) small local LoRA per priority member when hardware
   budget exists (WeClone/mlx-twin pipelines as reference); (c) evaluate each
   adapter against the grounded baseline — adopt only if it wins blind.

## IV. Obsidian Migration (target habitat)

Exocortex already speaks Obsidian (wiki-links, MOC-able structure).
Watchlist for the migration: claude-obsidian (vault loops, claim ledgers,
canvas maps), obsidian-smart-connections (semantic linking).
Principles locked: plain Markdown forever; no plugin-lock data; every AI
feature must degrade gracefully to plain text.

## V. Telegram Bridge (roadmap)

Reference implementations: WeClone (bot serving), hermes-agent (multi-IM
gateway), LangBot (production IM bot platform).
Requirements gathered: channel ingestion (Bot API, 20MB/file limit, bot sees
only post-join messages unless re-forwarded), token discipline = session-only.
Plan: BotFather bot -> channel admin -> pull files -> ingestion pipeline ->
vault. Build when the Architect greenlights.

## VI. Standing Watchlist (recon continues)

- hermes-agent: skill self-improvement loop — deepest convergence with our
  Directive system; study their skill-creation-from-experience mechanic next.
- agency-agents-zh: role-pack patterns for future Council expansion.
- screenpipe: only if continuous-capture ever becomes in-scope.
- agentskills.io ecosystem: our host environment itself uses skills; watch
  the format standard for portability of our own skill artifacts.

[RECAP] Forks secured. Dual doctrine ratified: grounding = truth layer,
adapters = voice layer, documents = law. Obsidian is the target habitat,
Telegram is the next bridge. The Council assimilates; it does not imitate.
