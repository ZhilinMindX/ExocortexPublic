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


---

## v1.1 — Voice Health (2026-09-12)

Two new module functions: `voice_health()` and `health_report()`.

- `VOICE_CORPORA` maps every seated voice and callosum cluster to its
  book IDs. New voices are registered here at induction (part of the
  induction checklist).
- `voice_health()` returns per-voice: corpus size, chunks ever retrieved,
  coverage ratio, raw hit count — all derived from the append-only
  hits.jsonl, never from editable state.
- `health_report()` renders worst-coverage-first. A voice running on 20%
  of its grounding is a doppelganger decaying into waxwork; chronic low
  coverage triggers StyleSheet revision (voice-versioning protocol,
  CouncilOfVoices v3.8+).
- Health measures USE, not decay: doctrine chunks appear here even though
  Art. 5.5 exempts them from staging. The two audits answer different
  questions — "is it silent?" (cold_audit) vs "is it grounded?" (health).


## v1.2 (2026-09-12) — Hybrid retrieval

BM25 is now complemented by dense embeddings (all-MiniLM-L6-v2,
bi-encoder, Khoj pattern) fused by reciprocal rank fusion (rrf_k=60) in
`hybrid_retrieve()`. Embeddings cached at `embeddings.npy` alongside
chunks.jsonl (row i = chunks.jsonl line i; rebuild on every corpus
change). Graceful fallback: BM25-only when the cache or model is absent.
Adopted from the second-opinion adjudication (B.5).
