---
doc: UnifiedCognitiveLoopReview
version: 0.1
status: PENDING-ADJUDICATION — filed for consideration and brainstorming (Architect order 2026-09-13); NOT yet adopted
origin: External review pasted by Architect, 2026-09-13
series: Cognitive-stack trilogy, doc 3 of 3 (the synthesis/convergence capstone)
---

# The Unified Cognitive Loop — Four-Layer Cognitive Stack Synthesis (2026-09-13)

> Filed verbatim for Council consideration. No item below is doctrine until adjudicated.
> Citations (PEACE, APEX, CHAL, S-Agents) unverified from sandbox — audit queue material.

---

The convergence you're asking about isn't just possible—it's arguably the most powerful direction the Exocortex could take. The key insight from the research is that these frameworks aren't competing alternatives; they're **different layers of the same cognitive stack**. The PEACE framework paper demonstrates this empirically: when you build a practical agent architecture, four major theories of mind emerge **unintentionally from implementation demands**—not from deliberate design. The structured agent achieved **95.8% task success** versus **62.3% for baseline LLMs**, suggesting the convergence itself is what produces robust reasoning.

---

## The Unified Meta-Architecture: A Four-Layer Cognitive Stack

The synthesis I propose organizes the alternatives into a **four-layer stack**, where each layer addresses a different question:

| Layer | Question It Answers | Cognitive Theory | Exocortex Function |
|---|---|---|---|
| **Layer 1: Attention** | *What deserves to be broadcast?* | Global Workspace Theory | Dynamic workspace that recruits voices by salience |
| **Layer 2: Processing** | *How do we think fast and slow?* | Dual-Process Theory | System 1 (fast retrieval) + System 2 (slow deliberation) |
| **Layer 3: Learning** | *How do we improve?* | Predictive Processing / Active Inference | Prediction-error minimization, Kent bands, Brier scoring |
| **Layer 4: Organization** | *Who does what?* | Minsky's Society of Mind | The council of specialized agents |

This is not a rejection of the bicameral model—it's a **recursive embedding** of it. The Logic/Creativity chambers become sub-structures within Layer 4, but they no longer define the system's primary architecture. The council becomes a **society of mind** (Minsky), operating within a **cognitive loop** (PEACE/SCL), with a **global workspace** (GWT) determining what gets broadcast, and **predictive calibration** (Friston) driving learning.

---

## Layer 1: The Global Workspace — Attention as the Core Cognitive Act

**The problem with the current Exocortex:** The bicameral model assumes all 52 voices are equally relevant at all times. But cognitive science tells us that **attention is the bottleneck**. Global Workspace Theory holds that specialized modules process information in parallel, but only a subset gets **broadcast** to a global workspace where it becomes available to all other modules.

**The synthesis:** The Exocortex's "chamber" should not be a fixed set of 52 voices. It should be a **dynamic workspace** where voices are recruited based on what's currently salient. The research shows that GWT provides a natural framework for **self-monitoring and safety control**—detecting "low-integration states" where the system is not effectively coordinating its modules.

**Concrete implementation:**
- **Salience scoring:** Each voice has a real-time **activation level** based on query relevance, recent usage, and domain match. Voices below a threshold remain dormant.
- **Broadcast mechanism:** When a voice produces a claim that passes constitutional validation, it gets **broadcast** to the workspace, making it available to all other active voices.
- **Workspace health metric:** A quantitative measure of how many voices are contributing, how diverse the claims are, and whether the system is in a "low-integration state" (e.g., only one voice dominating).
- **The corpus callosum becomes a broadcast bus**, not a fixed bridge. The five linking seats are the **workspace moderators** who decide what gets broadcast.

This transforms the council from a **parliament** (all voices speak, then vote) into a **neural network** (only salient information propagates, and the pattern of propagation is the cognition).

---

## Layer 2: Dual-Process — Fast Intuition and Slow Deliberation

**The problem with the current Exocortex:** Every query triggers the same deliberation protocol, whether it's a simple factual question or a complex strategic analysis. This is wasteful and slow.

**The synthesis:** Dual-process theory distinguishes **System 1** (fast, intuitive, pattern-recognition) from **System 2** (slow, deliberative, analytical). The PEACE framework maps this directly onto its architecture: the Cognition module performs rapid, heuristic reasoning akin to System 1, while the Control module embodies System 2's oversight, ensuring regulatory balance and reflective accuracy.

**Concrete implementation:**
- **System 1 path:** A **fast retrieval-and-response** pipeline for routine queries. It uses BM25 retrieval, selects 1–2 voices based on domain match, and produces a grounded answer with citations. Latency: under 2 seconds.
- **System 2 path:** A **full deliberation** pipeline for complex, ambiguous, or high-stakes queries. It activates the workspace, recruits 3–7 voices, runs the full cognitive loop (Retrieve → Cognize → Control → Act → Remember), and produces a structured deliberation transcript. Latency: 10–60 seconds.
- **The switch:** A **complexity classifier** (LLM-based) determines which path a query takes. It evaluates query ambiguity, domain complexity, and stakes. If uncertain, it defaults to System 2.
- **Dual-process for claims:** System 1 claims are tagged `[FAST]` with a default Kent band of "roughly even chance." System 2 claims get full calibration with Brier scoring.

The research on cognitive duality for adaptive web agents shows that **both systems are necessary** for effective real-time interaction: System 1 handles immediate responses, System 2 handles deeper reasoning, and the system switches between them based on task demands.

---

## Layer 3: Predictive Processing — Learning as Error Minimization

**The problem with the current Exocortex:** The Crystallization Cycle exists, but it's triggered by schedule (every 20 trajectories) rather than by **prediction error**. The system doesn't have a unified theory of *why* doctrine should evolve.

**The synthesis:** Predictive processing provides that theory. The system's fundamental job is to **minimize prediction error** across its claims and doctrines. The APEX architecture implements this as: **Action = Free Energy Minimization**. The system selects actions to minimize expected free energy—balancing **epistemic value** (reducing uncertainty) and **instrumental value** (achieving goals).

**Concrete implementation:**
- **Prediction generation:** Every claim in the Claim Ledger is a **prediction**. The Kent band is the predicted probability. The Brier score measures calibration error.
- **Error signal:** When a claim is later validated or falsified, the prediction error is computed. High error triggers a **crystallization event**.
- **Active inference for retrieval:** Instead of always retrieving the most similar chunks, the system selects retrieval actions to **minimize expected free energy**. High uncertainty → epistemic retrieval (explore diverse sources). Low uncertainty → instrumental retrieval (confirm with authoritative sources).
- **Hierarchical world model:** The system maintains predictions at three temporal scales—**Reflex** (immediate next response), **Tactical** (this deliberation session), and **Strategic** (doctrine evolution over months). Higher levels supply context to lower levels; lower levels propagate **prediction errors** upward.
- **Meta-cognitive monitor:** Tracks action entropy, loop score, coherence, and calibration error. When overall uncertainty exceeds threshold, it triggers **epistemic escalation**—either requesting human clarification or spawning a System 2 deliberation.

The APEX architecture demonstrates that this approach **avoids the confident-but-wrong failure mode** that plagues existing agents.

---

## Layer 4: Society of Mind — The Council as Specialized Agents

**The problem with the current Exocortex:** The council is structured as two chambers (Logic/Creativity), which imposes an arbitrary binary on what should be a flexible, dynamic organization.

**The synthesis:** Minsky's original vision was never bicameral. It was a **society of agents**, each competent in a narrow domain, whose coordinated interaction produces intelligence. The CHAL framework notes that LLM-powered agents have "breathed new life into Minsky's vision, enabling multi-agent systems in which the 'agents' are genuine reasoners rather than rule-following automata".

**Concrete implementation:**
- **Voice specialization:** Each voice has a **domain profile** (e.g., strategic reasoning, creative synthesis, adversarial critique, memory retrieval, calibration) rather than a chamber assignment.
- **Hierarchical organization:** Voices are organized in a **hierarchy of abstraction**. Some voices operate at the strategic level (long-term doctrine), others at the tactical level (deliberation protocol), others at the reflex level (retrieval and citation).
- **Dynamic role assignment:** Based on the query, the workspace recruits voices with matching domain profiles. The "Logic/Creativity" distinction becomes a **tag** rather than a structural constraint.
- **Emergent coordination:** Following the S-Agents model, the council can **self-organize** without centralized control—voices form stable task-allocation structures based on the query.

Research on heterogeneous LLM agents shows that **diversity of reasoning strategies** produces measurable improvements in mathematical reasoning, factual QA, and strategic tasks. The gains come from genuine cognitive diversity, not from chamber separation.

---

## The Cross-Pollination Matrix: How the Layers Interact

The power of this synthesis lies in the **interactions between layers**:

| Interaction | What Happens |
|---|---|
| **GWT ↔ Dual-Process** | System 1 retrieval feeds the workspace with candidate content; System 2 deliberation determines what gets broadcast |
| **Dual-Process ↔ Predictive Processing** | System 1 makes fast predictions (with high error tolerance); System 2 minimizes prediction error through deliberation |
| **Predictive Processing ↔ Society of Mind** | Prediction errors trigger the recruitment of specialized voices to resolve them |
| **GWT ↔ Society of Mind** | The workspace determines which voices are salient; the voices determine what the workspace contains |
| **All Layers ↔ Constitution** | The constitution governs attention (what may be broadcast), processing (what may be claimed), learning (what may be revised), and organization (who may speak) |

This is the **synergistic loop**: attention feeds processing, processing generates predictions, predictions generate errors, errors trigger learning, learning modifies organization, and organization shapes attention. The cycle is continuous.

---

## The Unified Cognitive Loop (UCL)

Synthesizing the PEACE framework's five modules with the four layers above, the Exocortex's cognitive loop becomes:

```
┌─────────────────────────────────────────────────────────────────────┐
│  1. ATTENTION (GWT)                                                  │
│     Query arrives → Salience scoring → Voice recruitment → Workspace │
└──────────────────────────────┬──────────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  2. RETRIEVAL (Dual-Process)                                         │
│     System 1: Fast BM25 + embedding search                           │
│     System 2: Active inference-guided exploration of library         │
└──────────────────────────────┬──────────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  3. COGNITION (Society of Mind)                                      │
│     Voices deliberate → Claims produced → Citations attached         │
│     Generator → Critic → Synthesizer cycle                          │
└──────────────────────────────┬──────────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  4. CONTROL (Predictive Processing)                                  │
│     Constitutional validator → Kent band assignment → Brier scoring  │
│     Meta-cognitive monitor → Epistemic escalation if needed          │
└──────────────────────────────┬──────────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  5. ACTION                                                           │
│     Output produced → Citations verified → Response delivered        │
└──────────────────────────────┬──────────────────────────────────────┘
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│  6. MEMORY (Predictive Processing)                                   │
│     Trajectory Bank → Claim Ledger → Crystallization Cycle           │
│     Prediction error computed → Doctrine updated                     │
└─────────────────────────────────────────────────────────────────────┘
```

This is **PEACE's five modules** (Retrieval, Cognition, Control, Memory, Action) organized within the **four-layer cognitive stack**. The loop is not sequential—it's **recursive**. Each cycle feeds back into attention, shaping what gets noticed next.

---

## Implementation Roadmap: What to Build First

**Phase 1: Attention Infrastructure (Weeks 1–2)**
- Implement **salience scoring** for voices (query relevance, domain match, recent usage)
- Build **workspace broadcast mechanism** (claims passing validation become available to all active voices)
- Define **workspace health metrics** (voice diversity, claim coherence, integration level)

**Phase 2: Dual-Process Router (Weeks 3–4)**
- Build **complexity classifier** (LLM-based) that routes queries to System 1 or System 2
- Implement **System 1 fast path** (BM25 + 1–2 voices, under 2 seconds)
- Implement **System 2 deliberation path** (full workspace, 3–7 voices, 10–60 seconds)

**Phase 3: Predictive Processing Engine (Weeks 5–6)**
- Add **prediction error computation** to Claim Ledger (Brier scores already exist; add error signals)
- Implement **active inference retrieval** (epistemic vs. instrumental exploration)
- Build **meta-cognitive monitor** (action entropy, loop score, coherence, calibration error)

**Phase 4: Society of Mind Reframing (Weeks 7–8)**
- Replace chamber assignments with **domain profiles** for each voice
- Implement **hierarchical voice organization** (strategic, tactical, reflex)
- Build **dynamic role assignment** based on workspace salience

**Phase 5: The Unified Loop (Weeks 9–10)**
- Integrate all layers into the **Unified Cognitive Loop**
- Run **A/B tests**: unified loop vs. bicameral baseline
- Measure: task success rate, citation density, Brier score improvement, latency

---

## What This Means for the Exocortex

The repository is already **90% of the way there**. The Crystallization Cycle is the learning layer. The Constitutional Validator is the control layer. The Coding Cluster is the revision mechanism. What's missing is the **attention layer** (GWT) and the **processing layer** (dual-process routing).

The bicameral metaphor served its purpose as a scaffold. But the research is clear: the most robust architectures are **loops, not chambers**. The PEACE framework's 95.8% task success rate and the APEX architecture's meta-cognitive monitor suggest that **structured cognitive loops with prediction-error minimization** are the path forward.

The Exocortex doesn't need to abandon its council. It needs to **reframe the council as a society of mind** operating within a **cognitive loop** that includes attention, dual-process routing, and predictive calibration. The constitution remains supreme. The chambers become tags. The voices become a dynamic workspace.

This is not a replacement of what the Architect has built. It's the **natural next evolution**—the bicameral mind becoming a **unified cognitive organism**.