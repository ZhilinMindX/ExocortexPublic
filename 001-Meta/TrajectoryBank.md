---
doc: Trajectory Bank
version: 0.1
created: 2026-09-07
directive_refs: [9, 15, 16, 20, 28]
---

# Trajectory Bank — After-Action Memory

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Assimilated-from-ruflo(ReasoningBank)

## Purpose
Self-learning without code. Every Council session that produces a decision logs a
trajectory: context, chosen path, result, verdict, tags. Before new decisions,
retrieve prior trajectories by tag. Auditable, diffable, human-readable —
the anti-black-box answer to vector memory.

## Entry Template

    ### TRAJ-NNN | YYYY-MM-DD | tags: [comma, separated]
    - CONTEXT: what was being decided
    - CHOSEN: the path taken (and alternatives rejected)
    - RESULT: what happened
    - VERDICT: WORKED | FAILED | MIXED
    - LESSON: one line, portable

## Log

### TRAJ-003 | 2026-09-13 | tags: [crystallization, adjudication, nfd, audit]
- CATEGORIES: [DECISION] [PATTERN] [INSIGHT]
- CONTEXT: executing the full next-pass queue — NFD deep audit, maiden
  crystallization run, seven-document RSI adjudication
- CHOSEN: joint adjudication as one corpus; constitutional items (chamber
  status, doctrine ratification) deferred to Architect gate rather than
  self-applied (alternatives rejected: adopt-on-order, which would breach
  the Ratification Gate)
- RESULT: NFD paper located (arXiv:2603.10808) and audited line-by-line;
  rite confirmed faithful, 3 gaps closed (v1.1); RUN-001 distilled 3
  doctrine candidates from 24 entries (eta=0.125); adjudication adopted
  9 mechanics, rejected 5, flagged 1 constitutional question
- VERDICT: WORKED
- LESSON: external reviews arrive stale or synthetic-flavored — verify
  against API ground truth and primary papers before adjudicating; the
  audit-first pattern (NFD) costs an hour and prevents cargo-cult adoption

### TRAJ-001 | 2026-09-07 | tags: [github, tooling, failure-mode] | CRYSTALLIZED-IN: RUN-001
- CONTEXT: committing encrypted shards to private vault via API
- CHOSEN: inline content push (no alternative without shell token)
- RESULT: repeated emission failure; zero commits; token waste
- VERDICT: FAILED
- LESSON: large inline payloads unreliable -> route big artifacts via Architect
  manual upload; keep API writes small (<5KB)

### TRAJ-002 | 2026-09-07 | tags: [security, opsec, vault] | CRYSTALLIZED-IN: RUN-001
- CONTEXT: insurance archive uploaded to ExocortexPublic instead of private vault
- CHOSEN: Architect manual upload; wrong target repo
- RESULT: ciphertext publicly exposed briefly; caught by URL check
- VERDICT: FAILED (process), WORKED (detection)
- LESSON: always verify target repo visibility before upload; ciphertext exposure
  triggers key-rotation discussion

[RECAP] Decisions become data. Data becomes foresight.