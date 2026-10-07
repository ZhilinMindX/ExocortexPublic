# FLEET HULLS — Whole-Code Registry
**Version:** 1.1 · **Date:** 2026-10-08

> A **HULL** is a whole code, preserved complete at a frozen version.
> (Reusable *parts* live in `../CODE_INVENTORY.md` as SNIPPETS.)
> Hulls are committed when the Captain rules them final — not before.
> Each hull carries its own L2 headers, SESSION CONTEXT and step log
> per FLEET_STANDARD v1.1 (T1–T5).

## Registry

| # | Hull | File | Version | State | Lineage / Notes |
|---|------|------|---------|-------|-----------------|
| 0 | Fleet Standard Button (reference template) | `FleetToggleButton_v3_0.mq4` | 3.1 (FTB_VERSION 3.0 frozen) | FROZEN | The Standard made flesh. Self-test harness hull. Source of SNIPPET #001 Fleet Rendering. |
| 1 | Fleet Standard Button (form & parity patch) | `FleetToggleButton_v3_2.mq4` | 3.2 (FTB_VERSION 3.0 frozen) | CURRENT | Patch of hull #0, Captain-authorized 2026-10-08: F1 explicit `BORDER_RAISED` bevel (form codified — L32 corollary), F2 log tags = build version (L23), F3 one-family-per-chart ruling in R3 (L26). Memory format untouched — no desk resets. Now the reference source of SNIPPET #001 Fleet Rendering. |

*Hulls #2+ (TeknoLite_Channel v1.03, and each fleet member as it is
unified to the new Standards) will be committed in the proper time,
per Captain's ruling.*

---

## ROADMAP — unification of the Fleet

**Wave 2 — Beacon Consensus v7 (next major work).**
All fleet versions of every shared mechanism must be aligned to speak
one language and unified to the new Standards:
- one memory grammar (`FLEETBTN_`, `BEACON_` TTL doctrine — SPHINX),
- one button module (SNIPPET #001, v3.2 rendering — hull #1),
- one telemetry codicil (T1–T5), one step-log discipline,
- lookback bounds as law (InpMaxBars pattern — the Trident's unbounded
  per-tick full replay is expressly rejected in our implementations).

**Wave 3 — Fleet Ledger on the Beacon wire.**
The Trident's *simulated trade ledger* — an excellent idea placed here,
after the wire exists, because a ledger needs a defined event to track.
Our implementation: **incremental spine, replay on demand** (never
Trident's per-tick full-history replay). Listens to `BEACON_` events;
records consequence (entry/stop/targets at fire time, outcome,
bars-to-outcome, R achieved); GV-persisted (`FLEETLEDG_` family);
verdict rendering per Trident's label grammar (SNIPPET reserved #005).
Detection says "consensus fired"; the Ledger remembers whether it was
right. Sovereignty: the Ledger listens, never intrudes.

**Wave 4 — Trident verbatim induction** (SNIPPETs #002–#005 archived
in full) as the Wave-2/3 work consumes them.
