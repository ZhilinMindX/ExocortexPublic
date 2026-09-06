---
doc: Project Schema (GOAP-adapted)
version: 0.1
created: 2026-09-07
directive_refs: [15, 20, 46]
---

# Project File Schema — Preconditions First

// [L2] SCOPE:Templates;STATE:Active;ORIGIN:Assimilated-from-ruflo(GOAP-planner)

## Purpose
Every file in 002-Projects declares its plan structure in frontmatter.
When a precondition breaks, the replan trigger fires — no flailing,
no burning cycles on a dead path (see TRAJ-001).

## Frontmatter Template

    ---
    project: <name>
    status: ACTIVE | PARKED | BLOCKED | DONE
    goal: <one sentence, plain language>
    preconditions:
      - <what must be true before any action>
    actions:
      - <ordered steps>
    success_criteria:
      - <measurable end states>
    replan_triggers:
      - <event -> fallback path, e.g. "API write fails twice -> Architect manual route">
    pace:                # Red Team #16
      primary: <main route>
      alternate: <backup>
      contingency: <if alternate fails>
      emergency: <last resort>
    ---

## Rules
1. No heavy execution without preconditions verified — verify, don't assume.
2. A triggered replan is logged as a trajectory in [[001-Meta/TrajectoryBank]].
3. Success criteria are binary: met or not. No vibes.

[RECAP] Plan with exits. Break early, replan cheap.