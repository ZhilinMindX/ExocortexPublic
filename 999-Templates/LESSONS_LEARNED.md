# LESSONS_LEARNED.md — Coding Cluster Fossil Ledger

**Fleet:** TeknoLite · **Established:** 2026-09-13 · **Mandate:** "All the
Lessons, must be Learned" — recursive self-improvement feed.
**Sources:** Fleet Button Analysis (Appendix A, FLEET_STANDARD.md) ·
Telemetry Archaeology (Appendix B, FLEET_STANDARD.md v1.1) · Field logs
(BC_Journal ×7, FleetWisdom) · Trident Second Opinion differential
(MarkitTick review, 2026-10-07).

This ledger is append-only. New audits append new strata; nothing is erased.

---

## Stratum I — Engineering Laws (button analysis, 2026-09-13)

1. **Duplication is the real enemy, not bugs.** Six new-bar detectors = six
   chances to be wrong; every fix applied six times. Shared machinery,
   specialized expression.
2. **Sovereignty violations hide in the engine, not the button.** Trace the
   flag, not the click. (CSR: innocent handler, guilty `OnCalculate`
   early-return.)
3. **Never use `OBJPROP_STATE` as storage.** It is a rendering hint other
   code may legitimately force. State lives in a variable; the button only
   displays it. (Dadas doctrine vs Czernobog doctrine — Czernobog won.)
4. **Event handlers are not engines.** A click handler's budget is
   microseconds: persist, repaint, raise a flag, return. (DLH rebuilt its
   whole engine mid-click; Chimaera reset history twice.)
5. **One name, one grammar.** Six spellings of the button object name
   (`g_buttonName`, `gButtonName`, `g_btnName`, `g_btnId`, `buttonId`,
   `gBtnName`) is how fleet-wide tooling dies. Prefix discipline ends it.
6. **The fleet votes with its keyboards.** Sixteen hulls converged on one
   six-step toggle skeleton independently. Standards should be extracted
   from convergent behavior, not imposed against it.

## Stratum II — Telemetry Laws (L2 archaeology, 2026-09-13)

7. **The STEP log is the most valuable fossil bed.** Named epochs
   ("The Orchestra", "The Council", "The Blackboard") reconstruct history
   without git. A version number tells you when; a name tells you why.
8. **Log the failure, not just the fix.** Vertex STEP 030→031: a field bug
   (subwindow-only arrows), its diagnosis, and its cure — preserved in-band.
   Fossils prevent re-bleeding.
9. **Free-text STATE is anarchy.** One field held version stamps, lifecycle
   phases, design patterns, and noise. Controlled vocabulary: `DEFINED →
   WIRED → FIELD-TESTED → HARDENED → FROZEN` (+ `DEPRECATED`).
10. **HYPOTHESIS is the hidden gem.** Rationale embedded at module level
    ("Fail-fast prevents runtime errors") survives every refactor that
    memory does not. Mandatory field.
11. **Doctrine untemplated is doctrine unpropagated.** SESSION CONTEXT
    existed in the style guide; zero hulls carried it. Ship doctrine inside
    the skeletons, not in memos.
12. **A telemetry tier without triggers is decoration.** ANOMALY: 2 static
    occurrences in ~115k lines. Define measured triggers or retire the tier.
13. **One L2, one line.** Wrapped blocks break machine readability; prose
    carries the continuation. That is what the dual-layer split is for.
14. **Telemetry adoption correlates with auditability.** The seven blind
    hulls (CustomTF, Dadas, Divergence, HiLoFibo, GARCH, OTC Clock,
    Nautilus) are exactly where audits required pure code reading. The
    Standard now sets a floor (T1/T3).

## Stratum III — Process Laws (fleet operations, 2026-09-13)

15. **Brainstorm before blueprint, blueprint before brick.** The button
    Standard succeeded because seven rulings were deliberated before one
    line was written. Gold Standard, not only Standard.
16. **The `.set` is senior.** The button abides configuration; it never
    overrides it. Configuration sovereignty outranks UI convenience.
17. **Verify removal on a fresh chart.** Debris that survives on the
    current chart proves nothing. OnInit must be idempotent against any
    prior incarnation's ghosts.
18. **Field evidence outranks elegance.** Journal hit-rates (12,828 pooled
    signals) sit in the doctrine shelf beside the code — the ledger of what
    actually happened governs what gets built next.

## Stratum IV — Meta Laws (self-audit of the reference hull, 2026-09-13)

19. **Audit the Standard-bearer first.** The v3.0 reference hull failed the
    v1.1 codicil on three counts (missing HYPOTHESIS, free-text STATE, no
    SESSION CONTEXT) — the very laws written the day after it. Every new
    codicil's first audit target is the reference hull itself, or doctrine
    teaches by memo again.
20. **Log the failure in the fossil, not the chat.** The "event handling
    function not found" compile failure lived only in conversation until
    S4 was written. A lesson that isn't in the step log doesn't exist for
    the next hull.
21. **Comment surgery deserves its own version.** v3.1 changed zero
    functional lines — yet compliance, fossils, and context all moved.
    Telemetry is payload, not decoration.

## Stratum V — The Second Opinion (Trident differential, 2026-10-07)

*Origin: an external review of `Trident_Swing_Projector` caught five
defect classes our own Analysis missed — all of them on the contract
surfaces (alerts, ink, arithmetic, namespaces), while we had audited the
mechanism. Assimilated, merged and generalized below. The Captain's
standing order: every code receives a Second Opinion, and the Second
Opinion itself is analyzed — we learn from the reviewer too.*

22. **Audit both planes: Mechanism AND Contract.** The engine can be
    sound while the surfaces lie. Every Analysis runs two passes —
    Mechanism (state machine, architecture, math) and Contract (ink,
    alerts, logs, GV memory, inputs, namespaces). Auditing one plane
    and grading the whole hull is how five bugs hide in plain sight.
23. **Representation Parity: the face must not lie about the engine.**
    (Merge of the reviewer's "managed stop not drawn" + "alert omits
    direction".) Every outward channel — ink, alert payload, log line,
    GV memory — is a *representation* of state; audit each against the
    CURRENT truth, not the birth value. A dashboard that says "BE"
    while the chart draws the old stop is one bug with two faces.
24. **Temporal Honesty (the Knowability Gate).** For every drawn object
    and every external read: *"at this time coordinate, was this
    knowable?"* Levels drawn from pivot-C time when the setup was only
    knowable at arm-bar; `iClose(HTF)` read inside a historical loop —
    same violation, seen from two sides. Sharper than repaint detection:
    it audits *information*, not just ink.
25. **Range & Evaluation-Order Audit.** Every arithmetic feeding a
    time/price coordinate or key is checked against its evaluation type:
    `Period() * 60 * diff` overflows 32-bit int before any cast can save
    it; GV keys die at 63 chars; array caps truncate silently. The bug
    lives in the *intermediate*, invisible in the source line.
26. **Namespaces must survive N-instances-per-chart.** ChartID scopes
    per *chart*, not per *instance*: two copies of one hull on one chart
    share the prefix and delete each other's objects. R3's no-collision
    doctrine extended: identity = family + chart + instance.
27. **Distinguish defect from design fork before prescribing.** The
    reviewer prescribed rewriting the Trident's full-replay into
    incremental state — trading its one great strength (self-healing
    consistency) for speed a lookback cap alone delivers. Bound the
    strength; don't rewrite it. Audit the reviewer's REMEDIES as
    separately as their FINDINGS: their delete-all fix = per-tick
    flicker; their ungated alerts = historical spam. A correct diagnosis
    can carry a lethal prescription.
28. **The Differential Protocol (standing order).** Every hull receives
    a Second Opinion; we diff catches both ways, log what each side saw
    and missed, and — the recursion — *the miss-list feeds the audit
    gates themselves*. The method learns from being reviewed. Out of
    the box is a place we now visit on schedule.
29. **Severity without triage is noise.** Seven "Criticals" triage to
    zero. Grade against the STATE enum and the debt register; reserve
    "critical" for what silently falsifies truth (look-ahead, muted
    signals), not for what is merely missing.

---

## Open Debt Register (tracked, not yet authorized)

| Debt | Hull | Class |
|---|---|---|
| `OnCalculate` early-return silences beacon when button dark | CSR v1.10 | Sovereignty — Critical |
| `OBJPROP_STATE` as state store | Dadas v5.0 | Fragility — High |
| Engine rebuild inside click handler | DLH v2.11 | R7 — High |
| Palette inverted vs Standard | Czernobog, Nautilus | Visual — Medium |
| Button gates beacon emission | Gatekeeper (BOB) | Sovereignty — High |
| Pullback engine never emits beacons (TrendBars 42.9% hit) | Chameleon lineage | Wire — Medium |
| Beacon families unread by Admiral | Balancer, Thermometer | Wire — Low |
| Filename/hull version mismatches ×4 | Registry | Hygiene — Low |
| Ink draws birth-state, not managed state (§4.5 class) | Trident v1.01 | Parity — High |
| Alert path broken under input mode + dead payload params | Trident v1.01 | Contract — High |
| 32-bit intermediate overflow in time extrapolation | Trident v1.01 | Range — Medium |
| ChartID-only prefix collides at 2nd instance on same chart | Trident v1.01 | Namespace — Medium |
