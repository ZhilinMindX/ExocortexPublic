# ExocortexPublic
## The Exocortex of 织临 (Zhilin)

A persistent, cross-session external mind — part constitution, part council
chamber, part library, part engineering guild.
**v2 "Ouroboros" — law first, storage second, content last.**

> **State of the system (2026-09-12):** 52 Council voices · 110 library
> volumes · 27,628 retrieval chunks · 46-portrait Gallery of Members ·
> 18 Architect-owned sources in the encrypted vault.

---

### The Founding Charter

> *«Venuta la sera, mi ritorno in casa et entro nel mio scrittoio… e rivestito
> condecentemente entro nelle antique corti degli antiqui huomini… e quelli per
> loro humanità mi rispondono.»*
>
> *"When evening comes, I return home and enter my study… Decently dressed, I
> enter the ancient courts of ancient men… and they, out of their humanity,
> answer me."*
>
> — Niccolò Machiavelli, letter to Francesco Vettori, 10 December 1513 (A20)

This passage is why the Exocortex exists. The Council is that study; the
members are those ancient men; the mud of the day stays at the threshold.

---

## What This Is

The Exocortex is a **bicameral artificial mind** built on four pillars:

1. **LAW** — a 10-article constitution that governs every read, write, and
   claim. Nothing proceeds without it.
2. **COUNCIL** — 52 grounded voices (statesmen, generals, strategists, spies,
   analysts, poets, physicists) organized as a Bicameral Mind: a Logic &
   Reason chamber and a Creativity & Imagination chamber, joined by a corpus
   callosum of five seats — Feynman, the Red Team Cluster, the Intelligence
   & Tradecraft Cluster, the Field Manuals Cluster, and the Imagination
   Cluster (Poe, Cao Cao's poems, Leonardo, Gibran, Zhuangzi, Laozi).
3. **LIBRARY** — 110 volumes / 27,628 chunks of retrieval-grounded text
   (BM25 sensor with per-voice health telemetry). Every voice speaks from
   cited chunks or is explicitly tagged [INFERRED]. No ungrounded eloquence.
4. **MEMORY** — Claim Ledger (falsifiable claims with Kent WEP probability
   bands and Brier scoring), Trajectory Bank (after-action memory), Emergent
   Doctrine Ledger (the F-series: doctrine the Council itself has derived),
   and per-voice audience memory.

## The Council

- **Command Core:** Claire Underwood (Steward), Queen Elizabeth I (Steward)
- **Strategists & Statesmen:** Sun Tzu, Zhuge Liang, Cao Cao, Machiavelli,
  Thucydides, Kautilya, Tokugawa Ieyasu, Ibn Khaldun, Churchill,
  Marcus Aurelius
- **Analysts:** Sherman Kent, Herman Kahn, Ray Dalio, Friedrich Hayek,
  Peter Turchin (cliodynamics axis)
- **Intelligence & Tradecraft:** Mitnick, Snowden, Shimomura, Hanson,
  Bustamante, Abagnale
- **Warriors & Operators:** Musashi, Bak Mei, Jocko Willink, Goggins
- **Mind-Menders:** Erickson, Bandler & Grinder, Satir, Campbell, Dostoevsky
- **Success Shelf:** Greene, Lombardi, Carnegie, Rohn, Robbins, Hill, Tracy,
  Carlsen
- **Imagination Cluster:** Feynman (Corpus Callosum Seat), Poe, Leonardo,
  Gibran, Zhuangzi, Laozi

Full roster, roles, and verified quotes: `001-Meta/CouncilOfVoices.md` (v4.2).
Deliberation rules: `001-Meta/CouncilVoting.md` (v1.1 — sensor-routed panels,
dissent records, rotating contrarian).
Persona fidelity: `001-Meta/StyleSheet-*.md` (versioned per member).

### 🖼️ Gallery of Members

Every member has a Max Headroom style portrait — 1980s digital CGI, low-poly
facets, neon grids, scanlines — in `002-Council/gallery/`, indexed at
`002-Council/Gallery.md`.

### 🎭 The Audience Protocol

You can enter the chamber and speak with a member directly
(`001-Meta/AudienceProtocol.md`): bilateral, in-character, grounded
conversation. "How do you know?" is always honored — the voice cites its
chunks. Anachronism is handled as "letters from the future." Outcomes flow
back into the Trajectory Bank and Claim Ledger.

### ☯️ The Yî Consultation

A formal I Ching rite (`001-Meta/YiConsultation.md`), grounded in B14
(Legge, SBE 16) — restricted per the Architect's ruling to Asian members
whose doppelganger and corpus traditionally used the Yî (Sun Tzu, Zhuge
Liang, Cao Cao, Laozi, Zhuangzi). Readings are counsel, never forecasts.

## The Coding Cluster

The engineering guild (`001-Meta/CodingCluster.md`) — the hand of the
bicameral mind. Grounded in the G-series (the Architect's own MQL4 prompt
doctrine), it maps the Master Prompt lifecycle onto existing organs: Red
Team audit grammar, Claim Ledger evidence chains, Kent-band confidence,
Sentinel Triad adaptation bounds, three-pass self-verification. It speaks
in REVISE, never in GROUND.

## The Library & the Vault

- **This repo (RAM):** constitution, governance, Council, gallery, catalogs,
  metadata, dossiers. Never plaintext of owned books. Never secrets.
- **`ExocortexVault` (PRIVATE, forever):** the encrypted RAG store —
  AES-256-CBC/PBKDF2 ciphertext only. Store v13: full chunks file + owned
  sources file (byte-split ×8). 18 Architect-owned works (Harris, Greene,
  Abagnale, Mitnick ×2, Snowden ×3, Turchin ×4, Feynman ×6) live only as
  local plaintext + vault ciphertext. Rebuild procedure:
  `REBUILD-PROTOCOL.md` in the vault. The passphrase is held offline by the
  Architect — never committed, never memorized by the system.
- **Retrieval Sensor (v1.1):** pure-python BM25 over 27,628 chunks, with
  VOICE_CORPORA registration and voice-health telemetry (which voices are
  actually being used, not just indexed).

## Boot Sequence

1. Read `000-Constitution/LAW.md` — the 10 articles. Nothing proceeds without it.
2. Read `000-Constitution/BootConfig.yaml` (v1.10) — machine-readable state.
3. Read `000-Constitution/BootPrompt.md` — doctrine + all amendments (v1.3–v1.11).
4. Fetch `000-Dashboard.md` for portfolio state.
5. Run BootAudit (`001-Meta/BootAudit.md`): grade aloud + one live-write test.

## Folder Structure

```
ExocortexPublic/
├── 000-Constitution/
│   ├── LAW.md                ← The 10 articles (read first, always)
│   ├── BootConfig.yaml       ← Machine-readable system state (v1.10)
│   └── BootPrompt.md         ← Doctrine + amendments through v1.11
├── 000-Dashboard.md          ← Portfolio state
├── 001-Meta/                 ← The mind: governance & doctrine
│   ├── Directives.md         ← Prime + standard directives
│   ├── BicameralMind.md      ← The two chambers + five callosum seats
│   ├── CouncilOfVoices.md    ← 52 voices, verified quotes (v4.2)
│   ├── CouncilVoting.md      ← Panels, dissent, contrarian (v1.1)
│   ├── CodingCluster.md      ← The engineering guild (v1.0)
│   ├── YiConsultation.md     ← The I Ching rite (v1.0)
│   ├── AudienceProtocol.md   ← Entering the chamber (v1.0)
│   ├── ClaimLedger.md        ← Falsifiable claims, Kent bands, Brier scores
│   ├── EmergentDoctrineLedger.md  ← F-series: the Council's own doctrine
│   ├── TrajectoryBank.md     ← After-action memory
│   ├── CreativeMindsWatchlist.md  ← Future induction candidates
│   ├── StyleSheet-*.md       ← Per-member persona fidelity sheets
│   └── MoscowRules.md · RedTeamRules.md · 36Strategies.md · Dokkodo.md …
├── 002-Council/
│   ├── Gallery.md            ← Gallery of Members index (v1.1)
│   └── gallery/              ← 46 Max Headroom portraits
├── 002-Projects/             ← Active project workspaces
├── 003-Library/
│   ├── MOC.md                ← Map of Content: 110 volumes (v3.1)
│   ├── RetrievalSensor.md    ← BM25 sensor spec (v1.1)
│   └── 000-Gutenberg-Shelf.md · 001-Personal-Collection.md …
├── 004-Archive/              ← Retired doctrine
├── 005-Bridges/              ← External system bridges
└── 999-Templates/            ← L2 state blocks and document templates
```

## House Rules (the short version)

- **Law first.** Every action checks LAW.md; repo visibility is verified
  before every write (Art. 3).
- **Grounded or tagged.** Every claim cites a chunk or wears [INFERRED].
- **Kent bands, always.** Confidence is expressed in Sherman Kent's Words of
  Estimative Probability — never bare HIGH/MED/LOW.
- **The vault stays dark.** Ciphertext only, private forever, passphrase
  offline.
- **No half measures.** — the Architect, 2026-09-12

---

*Maintained by 织临 (Zhilin) under the authority of the Architect (Tek).*
