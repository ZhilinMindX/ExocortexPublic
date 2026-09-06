---
doc: Bridges — interface layer specification
version: 1.0
created: 2026-09-07
// [L2] SCOPE:bridges;STATE:spec;LAW:Article-10
---

# 005-Bridges — Interface Specs

Article 10: bridges are interfaces against the layers, never into them.
Each bridge lists: purpose, contract, chassis candidates (forked arsenals),
state. No bridge is built until the Architect greenlights.

## Bridge T — Telegram

- Purpose: pull the book channel (source ingestion); later, Council on mobile.
- Contract: BotFather bot -> channel admin -> Bot API getFile pulls (20MB/file)
  -> ingestion pipeline -> CJK/word chunker -> encrypted shards -> vault.
  Session-only bot token; nothing posted back to the channel.
- Chassis: WeClone (fork), hermes-agent gateway (fork), LangBot (watch).
- State: SPEC. Awaiting green light.

## Bridge O — Obsidian

- Purpose: the Exocortex as a human-navigable graph.
- Contract: plain Markdown forever; wiki-links already house style; MOC.md is
  the root node; graceful degradation (no plugin dependency for core reading).
- Chassis: claude-obsidian (fork), obsidian-smart-connections (fork).
- State: PRINCIPLES LOCKED (AssimilationRegistry §IV). Migration future.

## Bridge R — Local Runtime (Council serving)

- Purpose: run grounded members locally — llama.cpp GGUF + future LoRA adapters
  (voice) + BM25 vault retrieval (truth) + claim ledger (audit).
- Contract: one engine hot at a time (workspace swapping); sidecar metadata
  JSON per artifact (provenance); member package = voice.md + anchors.jsonl +
  corpus.json + bans.md, machine-loadable.
- Chassis: Uncensored-Local-Studio (fork #10), ruflo (fork), mlx-twin (fork).
- State: SPEC. Activates when the first adapter exists.

[RECAP] Three bridges specified, none built. Interfaces obey the layers;
the layers never obey the interfaces.
