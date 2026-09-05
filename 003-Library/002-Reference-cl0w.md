---
title: Reference Mirror — ge4sis/cl0w
type: External Reference / Mirror
source_repo: https://github.com/ge4sis/cl0w
mirror_repo: https://github.com/ZhilinMindX/cl0w
license: MIT
created: 2026-09-05
status: Mirrored for study; assimilation deferred
---

# REFERENCE — cl0w / ZeroClaw

// [L2] SCOPE:ReferenceCl0w;STATE:Mirrored;HYPOTHESIS:cl0w is useful as a local-agent pattern but not as a wholesale dependency;DEPS:RoleplayModel,CouncilOfVoices,MoscowRules,RedTeamRules;DIRS:#9,#15,#16,#17,#28,#46,#52;ANCHORS:Source=ge4sis/cl0w,Mirror=ZhilinMindX/cl0w,License=MIT,Decision=PatternOnly;BLOCKER:ForkSyncLag;NEXT:Study mirror and extract LocalAgent pattern

## What it is

`cl0w` is a local-first personal AI agent: Telegram frontend, LM Studio local inference, MCP tool use, Markdown personas, Markdown skills, and file handling. It is MIT licensed.

## Mirror

- **Source:** https://github.com/ge4sis/cl0w
- **Mirror:** https://github.com/ZhilinMindX/cl0w

The mirror exists for study and reference. It is not an endorsement of production readiness.

## Council Assessment

**Steward:** Useful. It validates the Exocortex direction: plain-Markdown control plane, local inference, tool use through MCP, privacy by architecture.

**Critic:** Do not import blindly. Early codebase, no visible test discipline, Korean spec/error strings, thin prompt-injection defenses, MCP stdio equals local code execution risk, Telegram whitelist is necessary but not sufficient.

**Synthesis:** Assimilate patterns, not code.

## Extract / Adopt

1. **Markdown control plane** — personas and skills as plain files; maps to Directives, Council voices, RoleplayModel.
2. **MCP gateway discipline** — `mcp.json`, `/mcp list`, `/mcp reload`, `/mcp status` as a control surface.
3. **Local-first threat table** — whitelist, loopback inference, gitignored secrets, no inbound ports, file caps.
4. **Zero-weight philosophy** — minimal dependencies; small understandable core.

## Defer / Avoid

- Telegram as primary Exocortex interface.
- LM Studio dependency as default runtime.
- Whole-repo import into ExocortexPublic.
- Treating “secure by design” as proven.

## Security Notes for Future Local Agent

- MCP servers are executable trust boundaries; allowlist by path and hash where possible.
- File ingestion needs stronger prompt-injection isolation than size caps alone.
- Secrets must never enter prompts, logs, or committed state.
- Local inference reduces cloud exposure but increases endpoint responsibility.

## Next Use

Study mirror → draft `LocalAgent Pattern v0.1` → only then decide whether any implementation belongs in the Exocortex.
