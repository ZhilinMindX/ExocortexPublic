---
doc: ProjectChamber
version: 1.0
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

## Status

VISION CHARTER. No schedule. When the Architect says "build the Chamber,"
the Coding Cluster opens Phase 0 — hypothesis generation, as its doctrine
demands.
