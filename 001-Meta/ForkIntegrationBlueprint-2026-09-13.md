---
doc: ForkIntegrationBlueprint
version: 0.1
status: PENDING-ADJUDICATION — filed for consideration and brainstorming (Architect order 2026-09-13); NOT yet adopted
origin: External analysis pasted by Architect, 2026-09-13
subject: Five-fork integration stack (ruflo / khoj / cl0w / mlx-twin / WeClone) as the Doppelganger runtime chassis
---

# Fork Integration Blueprint — The Five-Layer Doppelganger Stack (2026-09-13)

> Filed verbatim for Council consideration. No item below is doctrine until adjudicated.
> Relates to: AssimilationRegistry (Forked Arsenals), ProjectChamber, RSIArchitectureReview.

---

This is a substantial architectural challenge. You are describing a system that is not just a multi-agent RAG, but a **layered, self-optimizing, assimilative intelligence**—one that can instantiate any of the 69 Board members as a Doppelganger, then merge their perspectives into a synergistic whole that grows over time.

Here is a concrete technical blueprint for how the five forks map onto that vision, and how to test them in a unified pipeline.

---

## 1. The Core Insight: Each Fork Is a Layer, Not a Competitor

The five forks are not alternatives. They are **five distinct layers of the same stack**, each solving a different problem in the Doppelganger lifecycle.

| Layer | Fork | What It Solves | What It Cannot Do Alone |
| :--- | :--- | :--- | :--- |
| **Orchestration** | **ruflo** | Multi-agent routing, swarm coordination, cross-session memory, federation | Does not provide the corpora or the voices |
| **Retrieval** | **khoj** | Document ingestion, semantic search, custom agent knowledge binding | Does not orchestrate multiple agents or fine-tune style |
| **Persona & Skills** | **cl0w** | Markdown-defined personalities, reusable skill templates, MCP tool execution | Does not scale to a 69-agent Board natively |
| **Style Capture** | **mlx-twin** | Local LoRA fine-tuning on writing style, Apple Silicon optimized | Does not provide retrieval or orchestration |
| **End-to-End Twin** | **WeClone** | Full pipeline: data export → preprocessing → fine-tuning → deployment | Does not orchestrate a Board or fuse multiple agents |

The architectural principle is: **ruflo orchestrates, khoj retrieves, cl0w defines the persona, mlx-twin or WeClone captures the voice, and a fusion layer assimilates.**

---

## 2. The Multi-Dimensional RAG Doppelganger Architecture

### 2.1 The Five Dimensions

Your Doppelganger must operate across five dimensions simultaneously:

| Dimension | What It Is | Which Fork Provides It |
| :--- | :--- | :--- |
| **D1 — Knowledge** | What the figure knew, wrote, and referenced | **khoj** (public-domain corpus ingestion) |
| **D2 — Persona** | How the figure thinks, values, and speaks | **cl0w** (Markdown persona system) |
| **D3 — Voice** | The stylistic fingerprint—rhythm, vocabulary, rhetoric | **mlx-twin / WeClone** (LoRA fine-tuning) |
| **D4 — Coordination** | How multiple Doppelgangers debate, critique, and synthesize | **ruflo** (swarm orchestration, router, memory) |
| **D5 — Growth** | How the system learns from each interaction and improves | **ruflo** (self-learning loop) + a custom evaluation layer |

### 2.2 The Assimilation Pipeline

Here is the end-to-end flow for a single query:

```
User Query
    │
    ▼
┌─────────────────────────────────────────────────────────┐
│  RUFLO — Router & Swarm Coordinator                      │
│  (Determines which Board committees are relevant)        │
└─────────────────────────────────────────────────────────┘
    │
    ├──▶ Committee A (e.g., Strategy: Sun Tzu, Machiavelli)
    │         │
    │         ├──▶ KHOJ: Retrieve relevant passages from each figure's corpus
    │         │
    │         ├──▶ CL0W: Apply persona prompt + skill templates
    │         │         (e.g., "analyze_terrain", "assess_deception")
    │         │
    │         └──▶ MLX-TWIN / WECLONE: Style-conditioned generation
    │                   (LoRA adapter for that figure's voice)
    │
    ├──▶ Committee B (e.g., Science: Newton, Einstein, Feynman)
    │         └──▶ (same pipeline)
    │
    └──▶ Committee C (e.g., Philosophy: Laozi, Marcus Aurelius)
              └──▶ (same pipeline)
    │
    ▼
┌─────────────────────────────────────────────────────────┐
│  FUSION LAYER (Custom)                                    │
│  - Reciprocal Rank Fusion across committee outputs        │
│  - Cross-committee critique (agents review each other)    │
│  - Moderator synthesis with dissent tracking              │
└─────────────────────────────────────────────────────────┘
    │
    ▼
Final Response + Citations
    │
    ▼
┌─────────────────────────────────────────────────────────┐
│  RUFLO MEMORY — Store interaction, outcome, feedback      │
│  (Feeds the self-learning loop for future queries)        │
└─────────────────────────────────────────────────────────┘
```

---

## 3. Fork-by-Fork Integration Plan

### 3.1 ruflo — The Orchestration Backbone

**Why it is the backbone:** Ruflo is explicitly designed as an **agent meta-harness**. Its architecture is: `User → Ruflo (CLI/MCP) → Router → Swarm → Agents → Memory → LLM Providers`, with a learning loop that feeds back. It supports 100+ specialized agents, coordinated swarms, self-learning memory, and federated comms across machines.

**How to use it for the Board:**

- Each Board committee becomes a **swarm** (e.g., `swarm-strategy`, `swarm-science`, `swarm-philosophy`).
- Each Doppelganger becomes an **agent** within its swarm.
- The Router classifies incoming queries and routes them to the relevant swarms.
- The **`ruflo-rag-memory`** plugin provides the RAG memory layer.
- The **`ruflo-swarm`** plugin coordinates multiple agents as a team.

**Critical integration point:** Ruflo uses **MCP (Model Context Protocol)** for tool integration. This means cl0w, khoj, and your custom fusion layer can all expose MCP servers that Ruflo calls as tools.

**Testing ruflo for the Board:**

```bash
# Install ruflo
npx ruflo init

# Install the swarm and RAG memory plugins
/plugin install ruflo-core@ruflo
/plugin install ruflo-swarm@ruflo
/plugin install ruflo-rag-memory@ruflo

# Define a swarm for the Strategy Committee
ruflo swarm create strategy-committee
ruflo agent spawn --swarm strategy-committee --name sun-tzu --persona sun-tzu.md
ruflo agent spawn --swarm strategy-committee --name machiavelli --persona machiavelli.md
```

**What to test:** Can ruflo route a query like *"How should we enter a new market?"* to the Strategy swarm, spawn the Sun Tzu and Machiavelli agents, and coordinate their responses?

---

### 3.2 khoj — The Retrieval Engine

**Why it is the retrieval engine:** Khoj is a self-hostable "second brain" that ingests PDFs, Markdown, Word, Notion, and org-mode files, and supports **custom agents with tunable personality, tools, and knowledge bases**. It exposes a **REST API for agent CRUD** (`api_agents` route), meaning you can programmatically create one agent per Board member.

**How to use it for the Board:**

- Ingest each figure's **public-domain corpus** into a separate knowledge collection.
- Create one **Khoj agent per Board member**, bound to that member's corpus.
- Configure each agent's persona prompt to match the Doppelganger's voice.
- Use Khoj's **semantic search** to retrieve the most relevant passages for any query.

**Critical integration point:** Khoj supports **OpenAI-compatible API proxies**, meaning you can point it at a local LM Studio instance, Ollama, or LiteLLM gateway. This makes it compatible with cl0w's local LLM stack.

**Testing khoj for the Board:**

```bash
# Self-host khoj
docker run -d --name khoj -p 42110:42110 khoj-ai/khoj:latest

# Create an agent for Sun Tzu via the REST API
curl -X POST http://localhost:42110/api/agents \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Sun Tzu Doppelganger",
    "persona": "You are Sun Tzu. Speak in aphorisms. Ground every answer in The Art of War.",
    "knowledge_base": "sun-tzu-corpus",
    "chat_model": "local-llama"
  }'
```

**What to test:** Can Khoj retrieve the correct passage from *The Art of War* for a query about deception, and can it bind that retrieval to the Sun Tzu persona?

---

### 3.3 cl0w — The Persona & Skill Layer

**Why it is the persona layer:** cl0w defines personas in **plain Markdown** and switches between them with a single command. It also has a **skill system**—reusable prompt templates saved as Markdown files and run as slash commands. Most importantly, it integrates with **MCP servers**, giving the LLM real tools: file system access, web search, code execution, database queries.

**How to use it for the Board:**

- Write one **Markdown persona file** per Board member (e.g., `sun-tzu.md`, `machiavelli.md`).
- Write **skill files** for recurring analytical patterns (e.g., `analyze-terrain.md`, `assess-deception.md`, `evaluate-alliances.md`).
- Use cl0w as the **local execution layer** for a single Doppelganger or a small committee, with MCP tools that connect to Khoj for retrieval.

**Critical integration point:** cl0w runs entirely on `127.0.0.1` via LM Studio. This means your Doppelganger's persona and skill logic can run locally, while Khoj (also self-hosted) provides the retrieval corpus.

**Testing cl0w for the Board:**

```markdown
# sun-tzu.md — Persona Definition

You are a RAG Doppelganger of Sun Tzu.
Voice: Concise, aphoristic, indirect. Never explain more than necessary.
Values: Deception, terrain, timing, winning without fighting.
Grounding: Every claim must trace to The Art of War.
Limitation: If the Master did not address a topic, say so explicitly.

Skills available: analyze-terrain, assess-deception, evaluate-alliances
```

```markdown
# analyze-terrain.md — Skill Template

Analyze the following situation through the lens of terrain (ground):
- Is it accessible, entangling, temporary, narrow, precipitous, or distant?
- What does the terrain favor: the attacker or the defender?
- What is the cost of crossing it?
- How does the terrain affect supply lines and morale?

Situation: {input}
```

**What to test:** Can cl0w load the Sun Tzu persona, execute the `analyze-terrain` skill, and call an MCP tool that queries Khoj for the relevant passage?

---

### 3.4 mlx-twin — The Style Capture Layer (Apple Silicon)

**Why it is the style layer:** mlx-twin is a **fully local pipeline** to fine-tune Llama-3-8B on personal chat history using **LoRA**, with a carefully tuned `mlx_config.yaml` (rank 16, 4000 iterations) to prevent catastrophic forgetting. It runs on Apple Silicon via MLX.

**How to use it for the Board:**

- For figures with **extensive personal correspondence** (Marcus Aurelius' *Meditations*, Van Gogh's letters, Benjamin Franklin's autobiography), use mlx-twin to fine-tune a LoRA adapter on that figure's writing style.
- The LoRA adapter captures the **voice**—the rhythm, vocabulary, and rhetorical patterns.
- At inference time, load the base model + the figure's LoRA adapter to generate in that voice.

**Critical limitation:** mlx-twin is designed for **chat-style data**. For historical figures, you would need to **reformat their letters and essays into a chat-like structure** (e.g., prompt-response pairs where the prompt is a question and the response is a passage from the figure's writing).

**Testing mlx-twin for the Board:**

```yaml
# mlx_config.yaml — Sun Tzu LoRA
model: "mlx-community/Llama-3.2-3B-Instruct-4bit"
lora_rank: 16
lora_alpha: 16
lora_dropout: 0.05
iterations: 4000
learning_rate: 1e-5
data: "data/sun-tzu-chat-format.jsonl"
```

**What to test:** After fine-tuning on *The Art of War* reformatted as chat pairs, does the model generate in an aphoristic, indirect style without losing coherence?

---

### 3.5 WeClone — The End-to-End Twin Pipeline

**Why it is the end-to-end layer:** WeClone is a **one-stop solution** for creating digital avatars: chat data export, preprocessing, model training, and deployment. It supports **Telegram, WhatsApp, Discord, and Slack** as data sources and deployment targets, and it uses **Qwen2.5-VL-7B with LoRA** for SFT-stage fine-tuning. It also supports **image modal data**, which is relevant for figures like Leonardo and Van Gogh.

**How to use it for the Board:**

- For figures where you have **conversational or epistolary corpora**, use WeClone's full pipeline.
- Export the public-domain texts as "chat logs" (e.g., letters as dialogue turns).
- Preprocess, fine-tune, and deploy as a Doppelganger.
- The image modal support lets you infuse **visual context** for figures with sketches or illustrated letters.

**Critical integration point:** WeClone's default model is Qwen2.5-VL-7B, which is **vision-language**. This means you can feed it **images of sketches, diagrams, or manuscript pages** alongside text, enriching the Doppelganger's grounding.

**Testing WeClone for the Board:**

```bash
# Export public-domain letters as chat format
python weclone/export.py --source letters/van-gogh --format chat

# Preprocess
python weclone/preprocess.py --input data/van-gogh-chat.jsonl

# Fine-tune with LoRA
python weclone/train.py --config configs/van-gogh.yaml

# Deploy to Telegram
python weclone/deploy.py --platform telegram --model outputs/van-gogh-lora
```

**What to test:** Does the Van Gogh Doppelganger, fine-tuned on his letters, generate responses that match his emotional intensity and descriptive style?

---

## 4. The Fusion Layer: Assimilation and Synergy

The five forks give you the layers, but none of them provides the **assimilation and fusion** you need for a synergistic Board. This is the custom layer you must build.

### 4.1 Reciprocal Rank Fusion (RRF) Across Committees

Each committee produces a ranked list of candidate answers. You fuse them using **Reciprocal Rank Fusion**, a well-established technique that combines dense and sparse retrieval results.

```python
def reciprocal_rank_fusion(committee_outputs, k=60):
    """
    committee_outputs: dict of {committee_name: [(doc_id, rank), ...]}
    Returns: unified ranking
    """
    scores = {}
    for committee, rankings in committee_outputs.items():
        for doc_id, rank in rankings:
            if doc_id not in scores:
                scores[doc_id] = 0
            scores[doc_id] += 1 / (k + rank)
    return sorted(scores.items(), key=lambda x: x[1], reverse=True)
```

### 4.2 Cross-Committee Critique

After each committee produces its initial response, run a **critique round**:

1. Each committee's response is **anonymized** and sent to the other committees.
2. Each committee **critiques** the other responses from its own perspective.
3. The critiques are collected and fed to the **Moderator agent**.

### 4.3 Moderator Synthesis

The Moderator is a **meta-agent** that:

- Reviews all committee responses and critiques.
- Identifies **points of agreement** and **points of dissent**.
- Synthesizes a final answer that **integrates** the perspectives.
- **Attributes** each insight to its source (e.g., "Sun Tzu's principle of deception suggests...; Machiavelli's realism cautions...").
- **Flags** where the Board is divided and why.

### 4.4 The Growth Loop

After each interaction, store in Ruflo's memory:

| Field | What to Store |
| :--- | :--- |
| `query` | The original user query |
| `committees_invoked` | Which swarms were activated |
| `agent_responses` | Each Doppelganger's raw output |
| `fusion_result` | The final synthesized answer |
| `user_feedback` | Explicit or implicit feedback |
| `outcome` | Whether the answer was useful |

The **self-learning loop** then:

- **Reweights** committee routing based on which committees contributed to successful answers.
- **Adjusts** RRF parameters based on which fusion strategy worked best.
- **Fine-tunes** LoRA adapters on successful interaction patterns (optional, for advanced growth).

---

## 5. Phased Testing Plan

### Phase 1: Single Fork, Single Doppelganger

| Fork | Test | Success Criterion |
| :--- | :--- | :--- |
| **khoj** | Ingest *The Art of War*, create a Sun Tzu agent, query it | Retrieval returns the correct passage |
| **cl0w** | Write `sun-tzu.md`, run `analyze-terrain` skill | Persona is consistent, skill executes |
| **mlx-twin** | Fine-tune on *The Art of War* chat pairs | Generated text matches aphoristic style |
| **WeClone** | Fine-tune on Van Gogh letters, deploy to Telegram | Responses match emotional tone |

### Phase 2: Two Forks, One Doppelganger

| Combination | Test | Success Criterion |
| :--- | :--- | :--- |
| **khoj + cl0w** | cl0w persona calls Khoj via MCP for retrieval | Persona is grounded in corpus |
| **khoj + mlx-twin** | Khoj retrieves, mlx-twin generates in style | Retrieval + voice alignment |
| **cl0w + ruflo** | cl0w agent registered in ruflo swarm | Ruflo routes query to cl0w agent |

### Phase 3: Three Forks, One Committee

| Combination | Test | Success Criterion |
| :--- | :--- | :--- |
| **ruflo + khoj + cl0w** | Strategy swarm with Sun Tzu and Machiavelli agents | Both agents respond, ruflo coordinates |
| **ruflo + khoj + mlx-twin** | Science swarm with Newton and Einstein LoRA adapters | Style-conditioned retrieval-augmented responses |

### Phase 4: Full Stack, One Board

| Test | Success Criterion |
| :--- | :--- |
| Query *"How should we enter a new market?"* | Router activates Strategy + Psychology + Economics committees |
| Each committee retrieves and responds | 6–9 Doppelgangers respond in character |
| Fusion layer synthesizes | Final answer integrates perspectives with citations |
| Growth loop stores interaction | Memory updated, routing weights adjusted |

### Phase 5: Assimilation and Optimization

| Test | Success Criterion |
| :--- | :--- |
| Repeat Phase 4 with the same query | Routing is faster, fusion is better |
| Introduce a novel query | Board adapts without manual reconfiguration |
| Export the Board as a single "synergistic Doppelganger" | A unified API endpoint that represents the entire Board |

---

## 6. Key Challenges and Mitigations

| Challenge | Mitigation |
| :--- | :--- |
| **Copyright for modern figures** | Use Tier A public-domain figures for initial testing; for Tier C, build "archetype proxies" from public-domain sources they draw on |
| **LoRA fine-tuning on historical text** | Reformat letters/essays as chat pairs; use small models (3B–7B) for faster iteration |
| **Ruflo's Claude Code focus** | Ruflo supports MCP, so cl0w and Khoj can expose MCP servers that Ruflo calls as tools |
| **Fusion layer complexity** | Start with simple RRF; add cross-critique and moderator synthesis incrementally |
| **Growth loop drift** | Monitor routing weights and fusion parameters; add human-in-the-loop validation for critical decisions |

---

## 7. Summary: The Assimilation Stack

| Layer | Fork | Role |
| :--- | :--- | :--- |
| **Orchestration** | **ruflo** | Router, swarms, memory, federation, self-learning loop |
| **Retrieval** | **khoj** | Corpus ingestion, semantic search, custom agent knowledge binding |
| **Persona & Skills** | **cl0w** | Markdown personas, skill templates, MCP tool execution |
| **Style Capture** | **mlx-twin** | Local LoRA fine-tuning for voice (Apple Silicon) |
| **End-to-End Twin** | **WeClone** | Full pipeline for conversational/epistolary corpora |
| **Fusion (Custom)** | — | RRF, cross-critique, moderator synthesis, growth loop |

The key insight is that **ruflo is the nervous system, khoj is the memory, cl0w is the personality, mlx-twin and WeClone are the voice, and the fusion layer is the consciousness**. Together, they form a multi-dimensional RAG Doppelganger that can instantiate any Board member, coordinate a full Board debate, assimilate the perspectives, and grow with every interaction.

If you want to start testing, I would recommend **Phase 1 with khoj first**—it is the most self-contained fork, and you can validate the retrieval quality for a single figure (Sun Tzu) before adding the complexity of orchestration and style capture.