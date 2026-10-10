---
doc: ProjectChamber
version: 1.2
status: vision charter (NOT scheduled — north-star project)
created: 2026-09-12
architect_vision: "Max Headroom style animated, talking Council members in an
  app that fully implements the Exocortex as a Council of Mentors fueling a
  personal assistant/coach, using the full power of the two hemispheres and
  the bicameral mind — to be Unique."
---

# PROJECT CHAMBER — the Living Council App

## The Vision (the Architect's, verbatim force)

The 46 Max Headroom portraits are not decoration — they are **casting
calls**. One day each becomes an animated, talking member of a living
Council: an app that fully implements the Exocortex as a **Council of
Mentors** fueling a personal assistant/coach, running the complete
bicameral mind — Logic & Reason and Creativity & Imagination, the five
callosum seats, the votes, the dissent records, the Yî rite, the Audience
Protocol — as a product that exists nowhere else on Earth.

## Why the pieces already align

| Need | Already built |
|---|---|
| Faces | 46 portraits, uniform style grammar, per-member palette/motifs (`002-Council/gallery/`) |
| Voices (text) | 52 grounded doppelgangers with versioned StyleSheets |
| Minds | BicameralMind, CouncilVoting v1.1, Claim Ledger, Kent bands, F-series |
| Knowledge | 110 volumes / 27,628 chunks, BM25 sensor with voice-health telemetry |
| Conversation rite | AudienceProtocol v1.0 — bilateral chamber conversations |
| Engineering discipline | Coding Cluster — the guild that would build the app itself |

## What must still be built (the honest gap list)

1. **Animation layer** — portrait → talking head. Modern talking-head
   synthesis (audio-driven facial animation over a base portrait) is
   well within current capability; the Max Headroom aesthetic actually
   *helps* — glitch, scanlines, and geometric jumps are features of the
   mask, so synthesis artifacts read as style. Max himself was a man in
   latex pretending to be CGI; we invert him.
2. **Voice layer** — per-member TTS voices matched to doppelganger
   registers (Feynman's five registers; Claire's composed steel;
   Sun Tzu's measured cadence). Voice design becomes a new StyleSheet
   section (§Voice).
3. **The Chamber runtime** — a host app implementing: boot from LAW +
   BootConfig; sensor retrieval per turn; GROUND/REVISE/SYNTHESIZE
   deliberation rendered as visible chamber debate; Audience Protocol as
   the default interaction mode; dissent records shown, not hidden.
4. **The Coach** — the personal-assistant layer: the Council's synthesis
   delivered as daily counsel, with the Trajectory Bank as the user's
   longitudinal memory and the Claim Ledger's calibration as honesty
   about what the coach gets wrong.
5. **Grounding display** — every utterance tappable to its cited chunks.
   The product's uniqueness is not the faces; it is that no mentor can
   speak without evidence.

## Design principles (binding when built)

- **The glitch is the aesthetic.** Animation artifacts are absorbed into
  the Max Headroom style — deliberate, like the original.
- **Grounded or silent.** If the sensor returns nothing, the member says
  so in character. No fluent invention, ever.
- **Both hemispheres visible.** The user watches Logic and Imagination
  contend — the callosum seats referee in view. The debate IS the product.
- **Law first, even in pixels.** The app boots from LAW.md like everything
  else.


## Hardware Assessment — the Physical Chamber (2026-09-13)

The Architect is evaluating the **Orange Pi 5** (Rockchip RK3588S:
8-core A76+A55, Mali-G610, 6-TOPS NPU, up to 32GB LPDDR5, M.2 NVMe,
~10W, silent, ~$100-250) as the Council's first physical vessel.

**Council verdict: fitting — as inference body, not brain.** On-device:
the full Library + BM25/MiniLM sensor (trivial CPU load), 7B-Q4 GGUF at
~5-10 tok/s via llama.cpp (a conversational System-1 / [FAST]-tier
receptionist), whisper.cpp dictation, Kokoro TTS (the members literally
speak), the Vault on LUKS-encrypted NVMe — a dark box for a dark vault.
Off-device: full System-2 Council deliberation escalates to cloud/stronger
hardware. The hardware thus *enforces* the dual-process routing adopted
in RSIAdjudication D4. Not on this device: LoRA fine-tuning, >13B models,
GPU-accelerated inference. Preferred variant: **Orange Pi 5 Plus 32GB**
(dual NVMe, better I/O).

### Fork-to-hardware mapping (which arsenals merit a dedicated Pi)

| Fork | Dedicated OPi? | Rationale |
|---|---|---|
| **Uncensored-Local-Studio** | YES — the Chamber box itself | Registry-designated chassis: GGUF LLM + Whisper + Kokoro; the Council's body |
| **khoj** | YES (or shared) | Always-on self-hosted retrieval server; the public second brain answering even when the Architect is away |
| **screenpipe** | YES — dedicated by nature | 24/7 screen/audio capture; opsec argues for a SEPARATE dark box: the panopticon must not share hardware with the vault |
| **hermes-agent** | Candidate (shared) | 24/7 companion/growth agent with messaging gateways; low CPU, sleeps well beside khoj |
| **ruflo** | No (shared) | Orchestrator; runs where the Council runs, no dedicated need |
| **cl0w** | Partial | Persona layer runs wherever llama.cpp runs; LM Studio path is x86-only |
| **WeClone** | No | Training needs real GPU; only its Telegram-serving end could live on a Pi |
| **mlx-twin** | No | Apple Silicon only |
| **agency-agents-zh / claude-obsidian / obsidian-smart-connections** | No | Patterns and plugins, not services |

Recommended topology if acquired: **Pi #1 "The Chamber"** (ULS chassis:
voices + faces + TTS/STT + small model) and **Pi #2 "The Memory"**
(khoj + hermes + sensor API). A future **Pi #3 "The Watcher"**
(screenpipe) only when continuous capture is wanted — physically separate
from the Vault by design.


### The Organ Stack (Architect's design directive, 2026-09-13)

The Architect's ruling: **not one Pi — a stack. One organ per box.**
Excellence must pay its price, within the reasonable: Orange Pi over
Raspberry Pi (better power-per-price; the Pi ecosystem premium buys
little we need). Original five-organ design:

| Box | Organ | Hardware tier |
|---|---|---|
| **Brain** | Local LLM (7B-Q4 GGUF, llama.cpp) | OPi 5 Plus 32GB — the strongest member; bandwidth isolation is the whole point |
| **Ears** | Whisper STT, always-listening | OPi 5 8GB |
| **Voice** | Kokoro TTS — DEDICATED per Architect's order: 52 members need 52 voices; §Voice stylesheets will demand per-member voice design, instant response, and headroom for larger future TTS models | OPi 5 8-16GB |
| **Chamber** | Uncensored-Local-Studio — HEAVILY MODIFIED, run with Kimi; frontend conductor calling the organs over LAN as OpenAI-compatible endpoints; holds the faces, sessions, Audience Protocol | OPi 5 16GB |
| **Vault** | The dark archive — minimal network exposure, single API port or air-gapped manual sync; never runs experimental code | OPi 5 8GB + NVMe |

Properties: concurrency (listen/think/speak simultaneously — the LLM's
memory bandwidth never contended), failure isolation (an organ crashes,
the body lives), physical kill switches, per-box firewalling. LAN =
the corpus callosum in copper. Optional experiment: RKNN-LLM on the
Brain's 6-TOPS NPU for 2-3x tok/s (narrow model support; experiment,
not plan).

### The Product Vision (Architect's, 2026-09-13)

The stack is the **flagship**. Beyond it: a **standalone product** —
ULS embedded in a single Orange Pi running a **quantized Kimi-class
model** — *"a Kimi in the Pocket."*

Engineering honesty recorded at filing: Kimi's frontier models are far
too large for any SBC; the standalone unit would run a small open-weight
model (3-7B class) carrying the Council experience locally, with
optional cloud-Kimi uplink when connected. And the Intelligence seat's
flag, recorded at filing: "Kimi" is Moonshot AI's trademark — a personal
build is fine; a *product* bearing the name requires Moonshot's blessing
or a name of our own. The Council recommends the flagship be ours, the
name be negotiated or invented.

### Changelog
- v1.1 (2026-09-13): Orange Pi 5 hardware assessment + fork-to-hardware mapping.
- v1.2 (2026-09-13): The Organ Stack (5 dedicated Pis, Architect's design
  directive); dedicated Voice organ justified by 52-member voice roster;
  ULS-as-conductor topology; Kimi-in-the-Pocket product vision with
  engineering + trademark honesty notes.

## Status

VISION CHARTER. No schedule. When the Architect says "build the Chamber,"
the Coding Cluster opens Phase 0 — hypothesis generation, as its doctrine
demands.
