# BEST_PRACTICES.md — TeknoLite Fleet Craft Codex
**Version:** 1.1 · **Established:** 2026-10-07 · **Mandate:** the
operational distillation of LESSONS_LEARNED.md — every law, fossil and
assimilation, rendered as *what we actually do*.

> **Law vs. Practice.** The Ledger remembers *why* (fossils, failures,
> strata). This Codex prescribes *how* — the checkable, repeatable craft.
> Every practice cites its parent law (L#) or ruling (R#/T#). When a new
> stratum lands, this codex is updated in the same commit.
> Scope: coding first — then everything else the Fleet touches:
> telemetry, process, design/form, and review method.

---

## I. CODING — Mechanism Plane

1. **One machine, many expressions.** Shared machinery lives in one
   module; hulls specialize, never re-implement. Six detectors = six
   bugs. (L1)
2. **State lives in variables, never in rendering hints.**
   `OBJPROP_STATE` is a face, not a memory. (L3) — *Epoch nuance:
   object-as-memory was valid pre-GV grammar (L31); the Fleet's memory
   is GV-backed, written at event time, never at deinit.* (R2)
3. **Click handlers are microseconds:** persist → repaint → raise flag →
   return. Engine work happens in OnCalculate on the flag. (L4, R7)
4. **Prefix discipline, one grammar.** `g_FTB_`-style module prefixes;
   object names `FLEET_{FAMILY}_{ChartID}_BTN`; GV keys
   `FLEETBTN_{FAMILY}_{SYMBOL}[_{SLOT}]_{Field}` — symbol verbatim,
   no TF segment, 63-char fail-loud. (L5, R1, R4)
5. **Bound every loop.** Every history walk carries a lookback cap
   (InpMaxBars pattern). Unbounded per-tick full replay is rejected
   architecture. (L27, Channel v1.03)
6. **Close the b1470 overload traps:** always explicit 3-arg
   `ObjectsTotal(0,-1,-1)` / `ObjectName(0,i,-1,-1)` / `ObjectDelete(0,x)`.
   (L1-era field failure)
7. **Debounce human input** (500 ms, wraparound-safe unsigned
   subtraction). (L2-era)
8. **OnInit is idempotent against ghosts:** sweep family-root objects
   from dead ChartID eras; verify on a *fresh chart*. (L17, R4)
9. **Validate inputs in OnInit, fail loudly, never clamp silently.**
   (Trident §4.8 class)
10. **New inputs append at END only** — the `.set` is senior; positional
    re-seating is a breaking change. (L16)
11. **Unified Starting Defaults.** Fleet-wide shared defaults — one bars-
    history standard (no hull at 89, none at 610, unless its engine
    *proves* the need), one ATR length, one anchor policy — so no hull
    hogs resources and none starves of candles; "bars enough for the
    job" is never in doubt. Deviations must justify themselves in the
    header HYPOTHESIS. (Captain's ruling, 2026-10-07)

## II. CODING — Contract Plane (the Second-Opinion gates, L22)

12. **Run every Analysis in two passes:** Mechanism (engine, state, math)
    then Contract (ink, alerts, logs, GV, inputs, namespaces). One plane
    audited = five bugs hidden. (L22)
13. **Representation Parity:** every outward channel renders *current*
    truth — ink uses managed stop, not birth stop; log tags name the
    actual build. (L23)
14. **Temporal Honesty:** for every drawn object and every external
    read — "was this knowable at this time coordinate?" HTF reads inside
    historical loops must be time-indexed (`iBarShift`), never
    present-tense. (L24)
15. **Range & evaluation-order check:** any arithmetic feeding a
    time/price/key is cast before it overflows — the bug lives in the
    32-bit intermediate. (L25)
16. **Namespaces survive N instances per chart:** identity = family +
    chart + instance (or a documented one-per-chart ruling with an
    escape hatch). (L26, R8)
17. **Alert contracts are payloads, not decoration:** direction, action,
    symbol, TF in every message; dedup by *event identity*, not bar time;
    an event×mode matrix proves every alertable path fires. (Trident
    §4.3/§4.4 class)
18. **Sovereignty:** publisher hulls gate RENDERING ONLY — beacons,
    alerts, journals never sleep. The ink gate never strangles the wire.
    (L2, R7, CSR/LevelTrading debts)

## III. TELEMETRY

19. **Every module carries one-line L2** with SCOPE / STATE (enum:
    DEFINED→WIRED→FIELD-TESTED→HARDENED→FROZEN / DEPRECATED) /
    HYPOTHESIS. (T1, T2; L9, L10)
20. **The ### step log is FIFO, last 3, and logs failures first.** A
    lesson not in the step log doesn't exist for the next hull. (L7, L8,
    L20)
21. **SESSION CONTEXT ships in the skeleton,** not in memos. (L11, T4)
22. **Telemetry tiers have measured triggers or are retired.** (L12)
23. **Comment surgery earns its own version.** (L21)

## IV. PROCESS

24. **Brainstorm before blueprint, blueprint before brick.** Rulings
    first, code second. (L15)
25. **Standards are extracted from convergent behavior,** not imposed
    against it. (L6)
26. **Field evidence outranks elegance** — journals and hit-rates govern
    what gets built next. (L18)
27. **Cite your ancestors.** When a pattern has a known origin
    (forex-station, TraderNeo, a forum post), the fossil names it.
    (L30)
28. **Defect vs. design fork, always:** bound a strength, don't rewrite
    it. Remedies are audited separately from findings. (L27)
29. **Append-only memory:** ledgers, inventories and hull archives gain
    strata; nothing is erased. (Ledger law)
30. **Original is sacred; rendering is tagged.** Verbatim sources are
    copied, never edited; every Fleet change rides as `[ENH]`/`[IMP]`/
    `[OPT]` with its law cited. (Inventory law)

## V. DESIGN / FORM

31. **Form and Function are separate jurisdictions.** A graft may
    inherit function wholesale; the FORM is re-seated to the Fleet
    Standard regardless. (L32)
32. **Form is set explicitly in code** — bevel, palette, geometry:
    `BORDER_RAISED`, C1 palette (aqua/red on #373737/#222222), 89×21.
    A default you rely on is a default that can change. (L32 corollary,
    R5)
33. **The market writes the thickness** — maturation speaks through an
    existing visual channel (width), never a new face. (L33, W4)
34. **In a reconstrue, "improvement" of the visible surface is drift.**
    Fix the hull, never the face — unless the Captain rules a form
    change. (Parity Law, S2 fossil)

## VI. REVIEW METHOD

35. **Every hull receives a Second Opinion;** the Second Opinion itself
    is analyzed — findings, remedies, and *its* method. (L28, standing
    order)
36. **Differential, not verdict:** diff catches both ways, log what each
    side saw and missed; the miss-list feeds the audit gates. The method
    learns from being reviewed. (L28)
37. **Severity is triaged:** "critical" is reserved for what silently
    falsifies truth — look-ahead, muted signals, lying ink. (L29)
38. **Audit the Standard-bearer first** at every new stratum; doctrine
    untemplated is doctrine unpropagated. (L19, L11)

---

*Codex law: when this document and the Ledger disagree, the Ledger is
right — and the Codex gets fixed in the same commit.*
