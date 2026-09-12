---
doc: Retrieval Sensor — LAW Art. 5 Telemetry
version: 1.0
created: 2026-09-12
implements: LAW Art. 5.1, 5.2, 5.3, 5.5, 5.7
---

# Retrieval Sensor — Spec (deployed 2026-09-12)

// [L2] SCOPE:Library;STATE:Living;ORIGIN:Architect-directive(2026-09-12)

## Purpose
LAW Art. 5.7 forbids cold-staging on unmeasured silence. This sensor is the
measurement layer that transitions Art. 5.3 from advisory to active.

## Components (library-rag/, persistent mount)
- `sensor.py` — BM25 index over chunks.jsonl + telemetry + audit API.
- `hits.jsonl` — APPEND-ONLY hit log. One line per retrieval event:
  {ts, q, ids, src}. Never rotated, never edited, never deleted (Art. 5).
- `cold_index.json` — staged operational states (full text untouched,
  restorable via INCLUDE_ARCHIVED per Art. 5.2).

## Retrieval contract
All Council grounding passes route through `sensor.retrieve(query, k)`:
- BM25 (k1=1.5, b=0.75) over the full 16,900-chunk index.
- Archived states hard-filtered unless `include_archived=True` (Art. 5.1/5.2);
  the flag is an explicit per-query Architect override, never persisted.
- Every call logs its returned chunk ids BEFORE the caller sees them —
  telemetry cannot be bypassed by the consumer.

## Cold-index contract (Art. 5.3 + 5.5)
- `cold_audit(days=90)` returns only chunks that are (a) state=archived,
  (b) NOT doctrine (id series A-E exempt per Art. 5.5), (c) silent > days.
- `stage_cold(ids)` records staging; never mutates chunk text (Art. 5.3:
  deep storage is not destruction).
- Ghost tokens, if ever created, are finding aids pointing at intact
  originals (Art. 5.4) — never replacements.

## Activation schedule (Art. 5.7)
- Sensor deployed 2026-09-12; clock seeded this date.
- Art. 5.3 remains ADVISORY until 2026-12-11 (first full 90-day cycle of
  honest telemetry). No staging may fire before that date.
- Fresh-start safety inherited from Art. 5: first observation seeds the
  clock, defers one cycle.

## Live-fire test (Boot Pact, Art. 8) — passed 2026-09-12
- "key assumptions check" -> A28/A23 (correct doctrinal seat)
- "words of estimative probability" -> A26/A29 line
- "survival evasion recovery" -> A39/A38
- "guerrilla counterinsurgency" -> A43/A46
- 13,517 legacy chunks normalized to stable ids (book-NNN) in the master
  index; source per-book JSONs untouched.

[RECAP] Measure first, stage later, destroy never. The sensor is the
Archive's memory of being consulted — an archive that cannot remember
being read cannot prove it is still alive.
