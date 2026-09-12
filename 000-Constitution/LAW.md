---
doc: Exocortex Constitution
version: 1.1
ratified: 2026-09-07
amended: 2026-09-12 (Article 5 expansion — RAG time-bomb fix)
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

### 5.1 — Archived = hard-filtered from default RAG queries
Archived states never enter default retrieval. The Council cannot debate
dead projects unless they are deliberately summoned.

### 5.2 — Retrieval toggle
`INCLUDE_ARCHIVED: true` — explicit Architect override only, per query,
never persistent, never set by a member, a bridge, or the curator.

### 5.3 — Auto-staging, not auto-decay
Archived OPERATIONAL STATES unretrieved in 90 days demote to the cold
index: excluded from default retrieval AND from Council grounding passes.
The full text persists intact and is restorable via 5.2. Deep storage is
not destruction (the NARA principle: retention schedules with staged
disposition, never silent destruction).

### 5.4 — Ghost tokens
Permitted only as FINDING AIDS pointing at intact originals — never as
replacements. A ghost token that orphans its original is a deletion in
costume and is void under this Article.

### 5.5 — Doctrine exemption
Library chunks (A/B/C/D/E series) are exempt from ALL decay and staging.
Knowledge does not expire; only contexts do. Machiavelli unretrieved for
90 days is not obsolete — he is waiting.

### 5.6 — Compression gate
Any future TRUE compression of archived content requires a Premortem plus
explicit Architect sign-off, per RedTeamRules v2. No automatic lossy
operation is ever lawful in this system.

### 5.7 — Telemetry prerequisite
Clause 5.3's clock requires per-chunk retrieval logging. Until that sensor
exists, 5.3 is advisory-only: no automatic staging may fire on unmeasured
silence. Legislating a sensor before building it is prohibited.

(Amendment 2026-09-12: items 5.1-5.2 as proposed by the Architect;
5.3-5.7 as revised after Red Team / Field Manuals review — auto-decay
rejected as deletion-in-costume, replaced by staged disposition.)

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
