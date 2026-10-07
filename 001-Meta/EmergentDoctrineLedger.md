---
doc: Emergent Doctrine Ledger
version: 1.1
created: 2026-09-12
directive_refs: [4, 5, 6, 7]
---

# Emergent Doctrine Ledger — F-Series

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Council-architecture-audit-2026-09-12

## Purpose
The Round-Table produces syntheses; syntheses used to evaporate. When a
synthesis produces something that exists in NO single corpus — born only
from the collision of voices — it is captured here as a derived doctrine
entry. This is the Council's own work product: the second-generation corpus.
The Exocortex stops being only a curator of dead masters and starts
producing original doctrine.

## Entry Format

    F-### | <doctrine name>
    QUESTION: <the contested question that produced it>
    COLLISION: <voices + chunk anchors that collided>
    DOCTRINE: <the emergent principle, one paragraph max>
    CONFIDENCE: <Kent WEP band>
    FALSIFIER: <what would prove it wrong>
    STATUS: ACTIVE | REVISED | RETIRED
    CREATED / LAST_REVIEWED: dates
    DERIVED_FROM: <TRAJ-### and CLAIM-### parents>   # v1.1 — mandatory
    CONFLICT_CHECK: <F-entries compared against; result>  # v1.1 — mandatory
    CRYSTALLIZED: <run id of the Still that produced/revised it>  # v1.1

## Rules
1. An F-entry must trace to a real Round-Table collision — voices and chunk
   anchors named. No orphan insights.
2. F-entries are NOT source grounding for members. They are Exocortex
   doctrine: members may be briefed on them, but may never cite them as if
   they were corpus text. Provenance tag: [F-DOCTRINE], never [A## p.##].
3. F-entries are falsifiable and carry Kent bands like claims. A retired
   F-entry is archived, never deleted (Art. 5).
4. The Claim Ledger audits F-entries: an F-entry asserted as source fact is
   a CLAIM violation, same class as a fake citation.
5. Series F lives in the library catalog as doctrine, exempt from decay
   (Art. 5.5, doctrine exemption).

---

## F-001 | The Sentinel Triad (2026-09-12)
QUESTION: How does the Exocortex audit deception across all media?
COLLISION: Abagnale (A50, paper fraud) × Mitnick (A51/A52/A55, wire
intrusion) × Snowden (A53/A54, surveillance). Three corpora, three
centuries of technique, one recurring skeleton.
DOCTRINE: Every deception — paper, wire, or watcher — runs the same
four-beat loop: (1) the mark trusts a credential, (2) the credential is
never verified against an independent channel, (3) the deceiver controls
the verification channel the mark would have used, (4) exposure comes only
from outside the loop. Defense is therefore not better credentials but a
verification channel the adversary does not control. Paper, wire, watchers:
the medium changes, the loop does not.
CONFIDENCE: Probable (75% ± 12%)
FALSIFIER: A documented deception that succeeded while the mark used an
independent, adversary-free verification channel.
STATUS: ACTIVE

## F-002 | Telemetry Before Decay (2026-09-12)
QUESTION: Can an archive decay safely without deleting anything?
COLLISION: Red Team Cluster (A24 premortem discipline) × Field Manuals
Cluster (A30–A47: armies already solved "archive, never delete" with
records schedules) × the RAG time-bomb diagnosis.
DOCTRINE: No information system may decay what it has not measured.
Silence is data only if a sensor was listening; unmeasured silence is
nothing. Therefore: retrieval telemetry precedes staging, staging precedes
compression, compression requires a premortem and a human signature. Any
system that compresses on unmeasured silence is destroying evidence to
save storage — the one trade the Exocortex never makes.
CONFIDENCE: Almost certain (93% ± 6%) — as design principle, not empirical law
FALSIFIER: A demonstrated case where unmeasured auto-decay preserved more
long-run retrieval value than telemetry-gated decay.
STATUS: ACTIVE

[RECAP] Grounding without synthesis is a search engine; synthesis without
capture is amnesia. The F-series is where the Council's collisions fossilize
into doctrine.


## v1.1 (2026-09-12) — Provenance & Conflict schema

Adopted from the second-opinion adjudication (B.3): every F-entry now
carries DERIVED_FROM (named parent trajectories/claims — doctrine must be
auditable and reversible), CONFLICT_CHECK (compared against all ACTIVE
F-entries before ratification; contradictions force explicit resolution),
and CRYSTALLIZED (the Still run that produced it — see
CrystallizationCycle v1.0). F-001 and F-002 are grandfathered; their
provenance is the 2026-09-12 Council-architecture-audit session.

## F-003 | Pre-Flight Verification (2026-09-13)
QUESTION: Why do the expensive failures cluster before execution, not during?
COLLISION: TRAJ-001 (inline-payload write failure) × TRAJ-002 (wrong-repo
ciphertext exposure) × every session fix since (API >1MB cap, HF-offline
hangs, sandbox freezes).
DOCTRINE: Before any operation that writes, transmits, or transforms,
verify the path's constraints — size, destination, visibility, permissions.
The expensive failures are pre-flight failures. Verification is cheaper
than recovery; recovery is cheaper than exposure.
DERIVED_FROM: TRAJ-001, TRAJ-002 | CRYSTALLIZED: RUN-001
CONFLICT_CHECK: clean (extends LAW Art. 3 beyond visibility to all path
constraints — complement, not conflict)
CONFIDENCE: Probable (75% ± 12%) — thin-evidence flag (n=2 at
distillation, pattern re-validated repeatedly since)
FALSIFIER: A costly Exocortex failure whose root cause survived correct
pre-flight verification.
STATUS: ACTIVE — RATIFIED by the Architect, 2026-09-13

## F-004 | Primary-Source Primacy (2026-09-13)
QUESTION: What closes provisional claims?
COLLISION: CLAIM-008 (A24 partial intake -> full PDF supplied) × CLAIM-009
(Kent secondary quotation -> 1964 original verified verbatim) × CLAIM-012/013
(vault provenance confirmed by Architect declaration).
DOCTRINE: Prefer primary sources. Hold secondary-derived claims as
provisional and pursue primary confirmation. The Architect's document
supply is the ledger's resolution engine — four independent claims were
closed this way, none closed any other way.
DERIVED_FROM: CLAIM-008, CLAIM-009, CLAIM-012, CLAIM-013 | CRYSTALLIZED: RUN-001
CONFLICT_CHECK: clean
CONFIDENCE: Probable (75% ± 12%)
FALSIFIER: A claim that reached CLOSED status on secondary evidence alone
and held.
STATUS: ACTIVE — RATIFIED by the Architect, 2026-09-13

## F-005 | Attribution Skepticism (2026-09-13)
QUESTION: When is a famous quote safe to speak?
COLLISION: CLAIM-001 ("ends justify the means") × CLAIM-002 ("chaos /
opportunity") × CLAIM-003 (36 Stratagems authorship) × CLAIM-004 (Later
Chu Shi Biao) × CLAIM-006 (Harris-translation Musashi quotes) — five
celebrated attributions, five failures against primary text, zero
counter-examples.
DOCTRINE: Celebrated attributions are presumed unverified until checked
against primary text. Persona voices never speak quotes their source did
not write. Quoted is not authored; translation phrasing belongs to the
translator.
DERIVED_FROM: CLAIM-001 through CLAIM-006 | CRYSTALLIZED: RUN-001
CONFLICT_CHECK: clean (already enforced per-member in StyleSheet bans;
this elevates the pattern to doctrine)
CONFIDENCE: Probable (75% ± 12%)
FALSIFIER: A celebrated attribution that survives primary-text verification
at a rate comparable to failures.
STATUS: ACTIVE — RATIFIED by the Architect, 2026-09-13
