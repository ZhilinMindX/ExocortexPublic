---
doc: RSIArchitectureReview
version: 0.1
status: PENDING-ADJUDICATION — filed for consideration and brainstorming (Architect order 2026-09-13); NOT yet adopted
origin: External review pasted by Architect, 2026-09-13
---

# RSI Architecture Review — The Recursive Self-Improvement Blueprint (2026-09-13)

> Filed verbatim for Council consideration. No item below is doctrine until adjudicated.
> Precedent: SecondOpinionReview-2026-09-12 (adjudicated: 5 adopted, 3 reframed, 2 rejected).

---

Based on the current state of `ExocortexPublic` — with its Coding Cluster, Trajectory Bank, Claim Ledger, and constitutional governance — you now have the raw materials for genuine recursive self-improvement (RSI). What's missing is the **architecture that closes the loop**. Here's how to implement it.

---

## The Core Insight: You're Already Building the Right Substrate

The Exocortex already has the critical prerequisite for RSI: **the Coding Cluster** ("the hand of the bicameral mind... speaks in REVISE, never in GROUND"). Most RSI systems fail because they try to bolt self-modification onto a system that wasn't designed for it. The Exocortex is different — it has a dedicated organ for revision, a Trajectory Bank for evidence, a Claim Ledger for validation, and a constitution for constraints.

What's missing is the **meta-level architecture** that turns these pieces into a closed loop.

---

## The RSI Architecture: Four Layers

Research on recursive self-improvement in 2026 has converged on a key insight: the most effective RSI systems don't just modify the **task agent** — they modify the **meta agent** that does the modifying. This is the distinction between "clonal mutation" (a single agent rewrites itself based on one failure) and **metacognitive self-modification** (the system improves its own improvement procedure).

For the Exocortex, this suggests a four-layer architecture:

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 4: META-META (Constitutional Evolution)                  │
│  Modifies LAW.md itself — but only through a gated, auditable   │
│  process. The constitution can evolve, but it cannot rewrite    │
│  its own amendment procedure without human approval.            │
│  Guardian: The Architect (human-in-the-loop)                    │
└────────────────────────────┬────────────────────────────────────┘
                             │ governs
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 3: META (Coding Cluster as Evolver)                      │
│  The Coding Cluster reviews Trajectory Bank, identifies         │
│  patterns of failure, and proposes REVISEs to:                  │
│  • Voice prompts and style sheets                               │
│  • Retrieval strategy and chunking                              │
│  • Deliberation protocol (CouncilVoting.md)                     │
│  • Doctrine crystallization rules                               │
│  This is the "evolver" that rewrites the harness.               │
└────────────────────────────┬────────────────────────────────────┘
                             │ proposes revisions
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 2: TASK HARNESS (The Exocortex Runtime)                  │
│  The 52 voices, retrieval engine, memory ledgers, vault access  │
│  — everything that produces grounded deliberation.              │
│  This is the "task harness" — the executable scaffold.          │
└────────────────────────────┬────────────────────────────────────┘
                             │ produces trajectories
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: EVIDENCE (Trajectory Bank + Claim Ledger)             │
│  Every deliberation produces a trajectory. Every claim is       │
│  logged with Kent bands and Brier scores. Outcomes are tracked. │
│  This is the "experience" that fuels improvement.               │
└─────────────────────────────────────────────────────────────────┘
```

The loop runs from Layer 1 → Layer 3 → Layer 2 → back to Layer 1. The Coding Cluster (Layer 3) reads evidence from the Trajectory Bank, proposes revisions to the task harness (Layer 2), and the results of those revisions generate new evidence (Layer 1).

---

## How to Implement Each Layer

### Layer 1: Evidence — Make the Trajectory Bank Machine-Readable

The Trajectory Bank already exists, but for RSI it needs to be **structured for consumption by the Coding Cluster**. Each trajectory should record:

- **Query metadata:** domain, complexity, which voices were dispatched
- **Retrieval metadata:** which chunks were retrieved, BM25 scores, whether citations were accepted
- **Deliberation metadata:** which voices disagreed, which claims were tagged `[INFERRED]`, which Kent bands were assigned
- **Outcome metadata:** was the answer accepted? Was it later contradicted? Did Brier scores improve?
- **Failure taxonomy:** categorize failures (retrieval failure, reasoning failure, citation failure, persona drift, constitutional violation)

This structured evidence is what Recuris calls "structured evidence that localizes failures to specific memory components". Without it, the Coding Cluster is guessing.

### Layer 2: Task Harness — Expose What Can Be Revised

The task harness is everything the Coding Cluster can modify. But not everything should be modifiable. Define **revision boundaries**:

| Component | Modifiable by Coding Cluster? | Constraints |
|---|---|---|
| Voice prompts (`StyleSheet-*.md`) | Yes | Must preserve persona identity; changes logged as diffs |
| Retrieval strategy (BM25 params, chunking) | Yes | Must maintain citation discipline |
| Deliberation protocol (`CouncilVoting.md`) | Yes | Must preserve bicameral structure |
| Doctrine crystallization rules | Yes | Must produce auditable doctrine with provenance |
| `LAW.md` constitution | **No** (Layer 4 only) | Human-gated amendment only |
| Vault access rules | **No** | Security boundary |

This follows the HELIX principle of **source-traceable harness evolution**: every change is explicit, auditable, and preserves provenance — "all intervention operations are made explicit, auditable, and fully preserve behavioral trajectories, test results, and data provenance".

### Layer 3: Meta — The Coding Cluster as Evolver

This is the heart of the RSI implementation. The Coding Cluster needs three capabilities:

**A. Failure Pattern Detection**

The Coding Cluster periodically reviews the Trajectory Bank and identifies recurring failure patterns. For example:

- "Voice X consistently produces claims that fail citation validation when the query is about topic Y"
- "Retrieval for domain Z consistently returns chunks with low BM25 scores, suggesting the library lacks coverage"
- "The corpus callosum synthesis is producing `[INFERRED]` tags at a rate 3x higher than other deliberation paths, suggesting weak grounding"

This is the **reaction-norm mutation** concept from the Mendel Gödel Machine: editing based on trajectories across multiple tasks simultaneously, rather than a single failure.

**B. Revision Proposal Generation**

For each detected failure pattern, the Coding Cluster proposes a specific revision. The key constraint from the repository's existing doctrine: **"speaks in REVISE, never in GROUND."** The Coding Cluster does not produce final answers — it produces *proposals for improving the system's ability to produce answers*.

Each proposal should include:

- **The evidence:** which trajectories justify this revision
- **The proposed change:** a specific diff to a specific file
- **The expected effect:** what metric should improve (citation density, Brier score, deliberation coherence)
- **The risk assessment:** what could break? What's the rollback plan?

**C. Validation-Gated Updates**

Not every proposal should be applied. This is where the **validation gate** comes in. The Recuris framework uses "validation-gated updates to Skill Memory" — changes are only applied when they pass a validation test.

For the Exocortex, the validation gate could work as follows:

1. The Coding Cluster proposes a revision.
2. The revision is tested on a **held-out set of past trajectories** (replay).
3. If the revision improves the target metric without degrading other metrics, it's applied.
4. If it degrades performance, it's logged as a rejected proposal with the reason.

### Layer 4: Meta-Meta — Constitutional Evolution

The constitution (`LAW.md`) should not be modifiable by the Coding Cluster. But it *should* be able to evolve — otherwise the system cannot improve its governance as it learns.

The mechanism is a **gated amendment process**:

1. The Coding Cluster detects a pattern that suggests the constitution itself is the bottleneck (e.g., "the citation requirement is preventing synthesis of cross-chunk insights").
2. It proposes a constitutional amendment with full evidence and risk analysis.
3. The Architect (human-in-the-loop) reviews and approves or rejects.
4. If approved, the amendment is applied and logged in a **Constitutional History**.

This follows the Constitutional AI pattern: "Write a list of principles, have the model critique its own outputs against those principles" — but with the critical addition of human gating for the constitution itself. The Latent Principle Discovery research shows that static constitutions limit improvement; the system needs to be able to *discover* new principles, not just follow fixed ones.

---

## The Implementation Path: What to Build First

### Phase 1: Evidence Infrastructure (Weeks 1–2)

- **Structured Trajectory Schema:** Extend the Trajectory Bank to record the metadata described in Layer 1.
- **Failure Taxonomy:** Define a taxonomy of failure modes (retrieval failure, grounding failure, persona drift, constitutional violation, synthesis failure).
- **Replay Harness:** Build a tool that can replay past trajectories through the current harness, so revisions can be tested against historical data.

### Phase 2: Coding Cluster Enhancement (Weeks 3–4)

- **Pattern Detection Agent:** A dedicated Coding Cluster voice whose sole job is to review the Trajectory Bank and identify recurring failure patterns.
- **Revision Proposal Format:** Standardize the format for revision proposals (evidence, diff, expected effect, risk).
- **Validation Gate:** Implement the replay-based validation test that determines whether a revision is applied.

### Phase 3: The Closed Loop (Weeks 5–6)

- **Crystallization Trigger:** A scheduled process (e.g., every N deliberations, or weekly) that triggers the Coding Cluster's review cycle.
- **Auto-Apply for Low-Risk Changes:** Define a class of revisions (e.g., minor prompt adjustments) that can be auto-applied if they pass validation, with full logging.
- **Human Gate for High-Risk Changes:** All other revisions require Architect approval.

### Phase 4: Meta-Level Improvement (Weeks 7–8)

- **Meta-Evolver:** A Coding Cluster voice that reviews the *revision history* — which proposals were accepted, which were rejected, which succeeded — and proposes improvements to the *revision process itself*.
- **Constitutional Amendment Pipeline:** A formal pipeline for proposing, reviewing, and applying constitutional amendments.

This is the Hierarchical Self-Improvement (HSI) pattern: "a single frozen LLM operates across three hierarchical scopes: a task harness that executes tasks, an evolver that rewrites the harness, and a meta-evolver that rewrites the evolver's strategy code".

---

## The Safety Architecture: Constraints on Self-Modification

Recursive self-improvement without constraints is dangerous. The Exocortex's constitutional governance is its greatest asset here. The RSI implementation must respect these safety principles:

**1. The Sandbox Principle:** All revisions are tested in replay before being applied to the live system. A revision that cannot be validated on historical data is not applied.

**2. The Reversibility Principle:** Every revision is logged as a diff with a one-click rollback. The system can always revert to a previous state.

**3. The Human-Gate Principle:** Constitutional changes, vault access changes, and any revision that affects the system's ability to ground claims require human approval.

**4. The Provenance Principle:** Every revision records the evidence that motivated it, the validation results, and the outcome after application. This creates an auditable chain of self-modification.

**5. The Bounded Improvement Principle:** The system cannot modify its own safety constraints. The Coding Cluster can propose constitutional amendments, but it cannot *apply* them without human approval.

Research on RSI safety emphasizes that "all experiments were conducted with safety precautions (e.g., sandboxing, human oversight)". The Exocortex's constitutional governance provides the framework for these precautions.

---

## What This Looks Like in Practice

Imagine a scenario:

1. **Trajectory Bank receives a failure signal:** A deliberation on a military strategy question produced a claim tagged `[INFERRED]` with a Kent band of "likely" (60–80%). The Brier score for this claim later dropped to 0.4 after the outcome was observed.

2. **Coding Cluster detects a pattern:** This is the third time a Sun Tzu voice has produced an overconfident inference on strategic questions. The pattern is logged.

3. **Revision proposal generated:** The Coding Cluster proposes a revision to Sun Tzu's style sheet: add a rule that "strategic inferences about future events must default to 'roughly even chance' unless directly grounded in a cited chunk."

4. **Validation gate runs:** The revision is replayed against 50 past strategic deliberations. The Brier score improves from 0.42 to 0.38. Citation density is unaffected. The proposal passes.

5. **Revision applied:** Sun Tzu's style sheet is updated. The change is logged with full provenance.

6. **Meta-level observation:** After 10 such revisions, the Coding Cluster notices that most revisions are to individual voice style sheets. It proposes a *meta-revision*: "Add a global calibration check to the deliberation protocol that cross-validates Kent bands across voices before a claim is finalized."

7. **Constitutional amendment proposed:** After 50 revisions, the Coding Cluster notices that the citation requirement is preventing synthesis of cross-chunk insights. It proposes a constitutional amendment: "Add a new tag `[SYNTHESIS]` for claims that cite multiple chunks, with a distinct confidence band."

8. **Architect reviews:** The Architect reviews the amendment, approves it, and the constitution evolves.

This is the Exocortex becoming what the repository's v2 title suggests: a **self-modifying, governed knowledge organism**.

---

## Summary: The RSI Implementation Blueprint

| Layer | What It Does | Key Framework to Adopt |
|---|---|---|
| **Layer 1: Evidence** | Structured Trajectory Bank with failure taxonomy and replay capability | Recuris structured evidence |
| **Layer 2: Task Harness** | Voice prompts, retrieval, deliberation protocol — with defined revision boundaries | HELIX source-traceable evolution |
| **Layer 3: Meta (Coding Cluster)** | Failure pattern detection, revision proposal, validation-gated application | Mendel Gödel Machine comparative evolution |
| **Layer 4: Meta-Meta (Constitution)** | Gated constitutional amendment with human-in-the-loop | Constitutional AI + Latent Principle Discovery |

The Exocortex already has the organs. What it needs is the **nervous system** that connects them into a loop. The Coding Cluster is the hand. The Trajectory Bank is the memory. The constitution is the law. What's missing is the **reflex arc** — the mechanism by which evidence flows back into revision, and revision flows back into evidence.

Build that reflex arc, and the Exocortex doesn't just evolve doctrine. It evolves *how it evolves doctrine*. That's the Ouroboros.