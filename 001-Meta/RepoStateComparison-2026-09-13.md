---
doc: RepoStateComparisonReview
version: 0.1
status: PENDING-ADJUDICATION — filed for consideration and brainstorming (Architect order 2026-09-13); NOT yet adopted
origin: External review pasted by Architect, 2026-09-13
note: Reviewer worked from a STALE snapshot (cites BootPrompt v1.15 as latest) — several "not adopted" claims are already false; see Zhilin's discrepancy report in session 2026-09-13
---

# Repo State Comparison Review (2026-09-13) — external, snapshot-stale

> Filed verbatim for Council consideration. No item below is doctrine until adjudicated.

---

Comparing the current state of the `ExocortexPublic` repository against the recommendations from our previous analysis reveals a fascinating picture. The repository has evolved significantly, but not always in the directions one might expect. It's less a story of direct adoption and more a case of **parallel evolution**—the Architect has been solving many of the same problems, but with a different vocabulary and through a different lens.

Here is a breakdown of how the repository looks now, mapped against the recommendations.

### 🏛️ What Has Been Adopted or Strengthened

Several of the core architectural recommendations are not only present but have been formalized and strengthened.

*   **Constitutional Governance is Supreme:** The `LAW.md` constitution is not just a document; it's the first thing read in the boot sequence, and **"Law first"** is a primary house rule. Every action checks the law, and repo visibility is verified before every write. This goes beyond a simple system prompt and is closer to a true governance layer.
*   **The Bicameral Council is Explicit:** The "bicameral artificial mind" is not a metaphor; it's a core architectural feature. The council is explicitly split into a **Logic & Reason chamber** and a **Creativity & Imagination chamber**, joined by a **corpus callosum** of five specialized clusters (Feynman, Red Team, Intelligence, Field Manuals, Imagination). This is a direct implementation of the structured deliberation concept.
*   **Grounded Retrieval with Health Telemetry:** The library uses a **pure-python BM25 sensor** over 27,628 chunks. Crucially, it includes **"voice-health telemetry"** to track which voices are actually being used, not just indexed. This is a pragmatic addition that addresses the risk of unused council members.
*   **Persistent Memory with Quantitative Rigor:** The memory system is robust. The **Claim Ledger** uses **Sherman Kent's probability bands** and **Brier scoring** for calibration. This is a sophisticated approach to tracking falsifiable claims and confidence, far exceeding a simple memory log.
*   **The Vault Stays Dark:** The separation between the public repo (RAM) and the private, encrypted `ExocortexVault` is strictly maintained. The public repo never contains plaintext of owned books or secrets, and the passphrase is held offline. This is a critical security and licensing design choice.
*   **The Audience Protocol:** The ability for a user to enter the chamber and have a bilateral, in-character conversation with a member is a concrete feature. The commitment that **"How do you know?" is always honored** with a citation is a strong implementation of the grounding principle.

### 🔍 What Has Not Been Adopted (Yet)

Several specific recommendations from our analysis are notably absent from the current public documentation.

*   **No Formal Crystallization Cycle:** There is no mention of a scheduled "crystallization" process or a dedicated agent for reviewing the Trajectory Bank to synthesize new doctrine. The system has the raw materials (Trajectory Bank, Emergent Doctrine Ledger) but the formal feedback loop is not yet documented.
*   **No Dispatcher or Tiered Routing:** While there is a `CouncilVoting.md` for deliberation rules, there is no explicit **Dispatcher** agent or router to select a small, relevant panel of voices for a given query. The system appears to have the infrastructure for sensor-routed panels but not a central orchestration component.
*   **Evaluation is Not Continuous:** The only audit mentioned is a **BootAudit** at startup. There is no documented process for continuous evaluation of deliberation quality, citation density, or prediction accuracy over time. The system can check its state at boot but doesn't appear to have a built-in quality control loop.
*   **Constitutional Checks Are Not Programmatic:** The constitution is described as a set of articles and rules, but there is no evidence of **code-level validators** that programmatically check every output against `LAW.md` before it is accepted. The governance is enforced through prompt adherence, not through a deterministic validation layer.

### 💡 The Most Significant Evolution: The Coding Cluster

The most substantial change is the introduction of the **Coding Cluster** (`001-Meta/CodingCluster.md`). This is a major addition that wasn't in the original scope.

> "The engineering guild (`001-Meta/CodingCluster.md`) — the hand of the bicameral mind. Grounded in the G-series (the Architect's own MQL4 prompt doctrine), it maps the Master Prompt lifecycle onto existing organs: Red Team audit grammar, Claim Ledger evidence chains, Kent-band confidence, Sentinel Triad adaptation bounds, three-pass self-verification. It speaks in REVISE, never in GROUND."

This is a powerful development. The "Coding Cluster" is essentially a **software engineering team** inside the Exocortex. It provides a concrete mechanism for the system to modify its own prompts and processes. The phrase **"It speaks in REVISE, never in GROUND"** is particularly insightful—it suggests the Coding Cluster's role is to refine and iterate on the system's logic, not to produce final, grounded claims. This is a dedicated **Generator-Critic pattern** applied to the system's own operation.

### 🔗 Integration of the Provided Repositories

The repository has begun to assimilate ideas from the URLs you provided.

*   **Uncensored-Local-Studio:** There is a commit from **Sep 12, 2026**, titled **"Registry v1.1: verify + enrich Uncensored-Local-Studio fork entry"**. This indicates the Architect is actively reviewing and incorporating elements from the local AI studio, likely for the zero-setup deployment model.
*   **WeClone and Ruflo:** These are not yet explicitly referenced, but the repository's focus on persona fidelity (`StyleSheet-*.md`) and the introduction of the Coding Cluster suggest the Architect is thinking along similar lines—capturing the "voice" of each council member and building a meta-harness for the system's operation.

### 🧭 Summary: A System in Motion

The `ExocortexPublic` repository is not a static specification; it is a living project. The Architect is actively developing it, as evidenced by the **"BootPrompt amendment v1.15 — five adoptions implemented"** commit from today, **September 12, 2026**.

The system has made great strides in the **"what"** (governance, council, grounding, memory) but is still developing the **"how"** of evolution. The raw materials for a learning organism are all there, but the explicit feedback loops—the **crystallization cycles, the continuous evaluation harnesses, and the programmatic constitutional checks**—are the next frontier.

The addition of the Coding Cluster is a brilliant move that provides a mechanism for the system to build its own improvement tools. The next step might be to have that Coding Cluster write the very crystallizer and evaluation harness that our analysis identified as missing.

The system is looking less like a static "external brain" and more like a **self-modifying, governed knowledge organism**. The "Ouroboros" name in the v2 title is apt—the system is beginning to eat its own tail, in the best possible way.