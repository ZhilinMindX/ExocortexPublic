---
doc: Claim Ledger
version: 0.1
created: 2026-09-07
directive_refs: [16, 28]
---

# Claim Ledger — Structured Verification

// [L2] SCOPE:Meta;STATE:Active;ORIGIN:Assimilated-from-claude-obsidian(claim-ledgers)

## Purpose
Key assertions used by the Council get structured, reviewable entries.
Prose persuades; ledgers track. Pairs with [[001-Meta/TrajectoryBank]]
(decisions) and auto source-tiering (two failed checks -> demotion, no deliberation).

## Entry Template

    ### CLAIM-NNN
    - CLAIM: one sentence, falsifiable
    - SOURCE: [[book/page]] or URL; tier: VERIFIED | SHELF | UNVERIFIED
    - CONFIDENCE: HIGH | MED | LOW
    - SUPPORT: what backs it
    - CONTRADICTED-BY: what cuts against it (empty = unchecked, not "none")
    - LAST-REVIEWED: YYYY-MM-DD
    - STATUS: ACTIVE | DEMOTED | RETIRED

## Log

### CLAIM-001
- CLAIM: "The ends justify the means" is NOT a Machiavelli quote — a mistranslation.
- SOURCE: A10 The Prince (Oxford), p.160 — 'in spite of some English translations
  to the contrary, Machiavelli never said that the ends justify the means'
- CONFIDENCE: HIGH
- SUPPORT: Oxford edition editorial note; si guarda al fine passage analysis
- CONTRADICTED-BY: popular attribution everywhere (usage, not text)
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE

### CLAIM-002
- CLAIM: "In the midst of chaos, there is also opportunity" is NOT a Sun Tzu quote.
- SOURCE: A11 The Art of War (Giles, 1910 PD, full text) — zero hits for "chaos"/"opportunity"
  phrasing across all 154 chunks; verse-level inspection
- CONFIDENCE: MEDIUM-HIGH
- SUPPORT: full-text absence in the standard PD translation; known as modern internet paraphrase
- CONTRADICTED-BY: not located in any classical commentary within A11
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE
- NOTE: member Sun Tzu must never use it (StyleSheet-SunTzu §5). Limitation: absence shown
  for Giles only; a second PD translation cross-check remains open.

### CLAIM-003
- CLAIM: The Thirty-Six Stratagems is NOT by Zhuge Liang (nor Sun Tzu) — an anonymous
  compilation, likely late-Ming/early-Qing.
- SOURCE: B4 Thirty-Six Stratagems: A Modern Interpretation, p.7 — 'neither are regarded
  as the true author by most historians'; B7 p.6 — stratagem tradition draws on his
  ACTIONS, compiled centuries later
- CONFIDENCE: HIGH
- SUPPORT: internal corpus (B4 p.7, B7 p.6); scholarly consensus (anachronistic
  stratagem names reference events centuries after his death)
- CONTRADICTED-BY: popular/traditional attribution only
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE
- NOTE: Zhuge Liang persona may use stratagem doctrine flagged as later tradition;
  never claims authorship (StyleSheet-ZhugeLiang §5)

### CLAIM-004
- CLAIM: The Later Chu Shi Biao (228 AD) is of disputed authorship — suspected
  not written by Zhuge Liang.
- SOURCE: A13 apparatus + external scholarship: Qing scholar Qian Dazhao's doubts;
  the text mentions Zhao Yun's death though Sanguozhi records he died in 229
- CONFIDENCE: MEDIUM-HIGH
- SUPPORT: anachronism (Zhao Yun); tone differs sharply from the Former memorial;
  absent from Zhuge Liang's collected writings, appears only via Zhang Yan's Mo Ji
- CONTRADICTED-BY: traditional inclusion in his canon; Pei Songzhi transmitted it
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE
- NOTE: quotes from the Later memorial carry the DISPUTED flag; downweight in any
  future adapter training

### CLAIM-005
- CLAIM: Cao Cao's famous defeats at Zhuge Liang's hands are largely Romance of the
  Three Kingdoms dramatization, not history. His historical nadir, Red Cliffs (208),
  came against the Sun–Liu alliance with Zhou Yu as field commander.
- SOURCE: A11 (Giles) pp.20-25 apparatus on Ts'ao Kung's historical career; standard
  Sanguozhi record vs the Ming novel; B7 p.6 notes the stratagem tradition draws on
  Romance-dramatized episodes of Zhuge Liang
- CONFIDENCE: HIGH
- SUPPORT: novel written ~14th c., eleven centuries after the events; Zhuge Liang's
  historical record is administrative/diplomatic more than field-victories over Cao Cao
- CONTRADICTED-BY: the Romance and its derivatives (operas, games, popular memory)
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE
- NOTE: Council keeps the Zhuge Liang / Cao Cao pairing as deliberative theater —
  opposed readings of the same stratagem corpus — explicitly not as history.

[RECAP] Every load-bearing claim: sourced, tiered, dated, falsifiable.
