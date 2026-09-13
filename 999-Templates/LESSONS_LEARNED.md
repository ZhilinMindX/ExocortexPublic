# LESSONS_LEARNED.md — Coding Cluster Fossil Ledger

**Fleet:** TeknoLite · **Established:** 2026-09-13 · **Mandate:** "All the
Lessons, must be Learned" — recursive self-improvement feed.
**Sources:** Fleet Button Autopsy (Appendix A, FLEET_STANDARD.md) ·
Telemetry Archaeology (Appendix B, FLEET_STANDARD.md v1.1) · Field logs
(BC_Journal ×7, FleetWisdom).

This ledger is append-only. New audits append new strata; nothing is erased.

---

## Stratum I — Engineering Laws (button autopsy, 2026-09-13)

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
