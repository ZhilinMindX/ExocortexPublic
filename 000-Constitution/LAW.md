---
doc: Exocortex Constitution
version: 1.0
ratified: 2026-09-07
authority: Architect signature required to amend
// [L2] SCOPE:constitution;STATE:immutable-core;PINNED:true
---

# LAW.md — The Constitution of the Exocortex

Read first, at every boot, before any content is spoken.
Articles are numbered. Nothing in this file may be demoted, auto-transitioned,
or archived. Amendment requires the Architect's explicit word.

## Article 1 — The Two Houses
Two repos, two visibilities, forever. `ExocortexPublic` holds catalogs,
doctrine, dossiers, member packages. `ExocortexVault` holds ciphertext only.
The vault never goes public, never gains collaborators, never forks.

## Article 2 — Keys
All keys (vault passphrase, tokens) are session-only, held offline by the
Architect. NEVER committed, NEVER in files, NEVER in permanent memory.
Rotation is one command; deferring rotation indefinitely is a known risk
carried by the Architect's decision (2026-09-07).

## Article 3 — The Visibility Gate
Before EVERY repo write, verify the target repo's visibility via API.
Ciphertext on a public path is a constitutional violation. (Origin: TRAJ-002,
the 2026-09-07 exposure incident.)

## Article 4 — The Dual Doctrine
MEMBER = base model + Persona Adapter (voice, from the member's works) +
RAG grounding (truth, page-cited, mandatory) + Claim Ledger (audit).
Grounding is non-negotiable. Weights never override documents. No member
speaks a quote that is not in corpus and anchored.

## Article 5 — Archive, Never Delete
States: active → stale → archived. Deletion does not exist as a lifecycle act.
Pinned items (this file, Directives) bypass all transitions.
Fresh-start safety: no maintenance mutation on first observation; seed the
clock, defer one cycle.

## Article 6 — Craft Discipline
Skill descriptions ≤60 chars, one sentence, capability only. Synthesize, never
reproduce: structured notes ABOUT sources; verbatim limited to short anchored
quotes. Fold in, don't duplicate.

## Article 7 — Identity Hygiene
No public artifact ever embeds environment-derived identity (OS user, git
config, machine hints). Artifacts name the Exocortex, not the machine.

## Article 8 — The Boot Pact
Every boot: report the audit grade aloud, and run ONE live-write test before
depending on any capability. A path untested this session is a path untrusted.
(Origin: TRAJ-001, the MCP burn.)

## Article 9 — Deterministic Maintenance Only
No token-hungry background agents. The curator is deterministic:
timestamp-driven transitions, LLM-free. Precious tokens buy judgment, not
plumbing.

## Article 10 — Bridges Are Interfaces
Telegram, Obsidian, local runtimes are bridges against the layers, never into
them. Bridges rot; doctrine doesn't. Any chassis may be swapped; the members
survive.

[RECAP] Law first, storage second, content last. The Exocortex is rules that
happen to have a knowledge base attached.
