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

### CLAIM-006
- CLAIM: Most famous English "Musashi quotes" in circulation are Victor Harris's 1974
  translation phrasing (The Book of Five Rings, Allison & Busby) — copyrighted, and not
  verifiable against the classical Japanese original as HIS words.
- SOURCE: corpus recon 2026-09-07 — Gutenberg: zero Musashi holdings; Aozora: zero
  original works (only Yoshikawa's novel); all English translations (Harris, Cleary,
  Wilson, Bennett, Tokitsu) in copyright
- CONFIDENCE: HIGH
- SUPPORT: the Adelaide/archive.org copies are Harris's text; translator died 2017
- CONTRADICTED-BY: widespread unattributed quotation (usage, not rights)
- LAST-REVIEWED: 2026-09-07
- STATUS: ACTIVE
- NOTE: member Musashi quotes classical Japanese (A18/A19) + own glosses ONLY.
  General principle: quoted ≠ author's; translation phrasing belongs to the translator.


## CLAIM-007 — Heuer's unproven-vs-disproved standard (adopted)
- CLAIM: An unproven hypothesis is not a disproved one; unproven hypotheses
  must be kept alive until disproved. Absence of evidence is not evidence of
  absence of deception.
- SOURCE: A22 (Heuer, Psychology of Intelligence Analysis, CIA 1999, PD)
- TYPE: doctrine-adjacent standard (adopted as evidentiary rule, 2026-09-08)
- CONFIDENCE: HIGH (verbatim from PD source)
- STATUS: ACTIVE — governs all future CLAIM entries

## CLAIM-008 — A24 is a partial-text intake
- CLAIM: A24 (UFMCS Red Team Handbook v9.0) was ingested from fetch-service
  excerpts + verified TOC page map, not the full 218-page PDF.
- CAUSE: home.army.mil / usacac.army.mil DNS-blocked from sandbox (same class
  as cia.gov, wikisource, archive.org failures).
- ACTION: reconcile against full PDF when reachable; page numbers in the
  48-technique catalog are from the verified TOC and are reliable.
- RESOLVED 2026-09-12: full v9.0 PDF supplied by user (RedTeamHB.pdf,
  "approved for public release, distribution unlimited"); A24 re-chunked to
  127 page-anchored chunks (pp. 1-238). Full text confirms the partial intake:
  Key Assumptions Check, Premortem, Outside-In, Four Ways of Seeing all present.
- STATUS: CLOSED


## CLAIM-009 — Kent WEP table values
- CLAIM: Kent's Words of Estimative Probability original bands are:
  Almost certain 93%±6%; Probable 75%±12%; Chances about even 50%±10%;
  Probably not 30%±10%; Almost certainly not 7%±5%.
- SOURCE: A26 (Kesselman, NPS 2008, quoting Kent, Studies in Intelligence,
  Fall 1964) — secondary quotation, not the primary PDF (cia.gov unreachable).
- RESOLVED 2026-09-12: 1964 original supplied by user (KENWOE.pdf), ingested
  as A29. Primary-source table verified verbatim: 93%±6 / 75%±12 / 50%±10 /
  30%±10 / 7%±5 — identical to the A26 secondary quotation.
- CONFIDENCE: Almost certain (93% band) — primary source.
- STATUS: CLOSED (operating standard confirmed).

## CLAIM-010 — Simple Sabotage Field Manual provenance
- CLAIM: The manual is OSS Strategic Services Field Manual No. 3, dated
  17 January 1944, signed by William J. Donovan; declassified by CIA in 2008;
  PD as a US Government work. Gutenberg #26184 text verified complete
  (5 sections, through "Do not cooperate in salvage schemes").
- CONFIDENCE: Almost certain (93% band).
- STATUS: ACTIVE.


## CLAIM-011 — ATP 2-33.4 provenance
- CLAIM: A28 is the authentic ATP 2-33.4 Intelligence Analysis, Headquarters,
  Department of the Army, 18 August 2014 (58k+ words, 147 pages, full contents
  verified). US Government work, public domain by statute (17 U.S.C. §105);
  original copy carried a FOUO distribution restriction (administrative, not
  copyright) — user-directed assimilation 2026-09-12 on public-domain grounds.
  Retrieved via publicintelligence.net mirror (armypubs.army.mil unreachable).
- CONFIDENCE: Almost certain (93% band).
- STATUS: ACTIVE.


## CLAIM-012 — Field Manuals vault provenance (A30-A47)
- CLAIM: A30-A47 are authentic US military doctrinal publications, supplied
  by user 2026-09-12 from a declassified-files vault. All are US Government
  works (public domain by statute, 17 U.S.C. §105). Distribution statements
  verified per volume: A31/A32/A33/A34/A35/A39/A42/A44 explicitly "approved
  for public release, distribution unlimited"; A30 OSS 1944 (PD by age and
  statute); A36/A37/A38/A41/A43/A45/A46 pre-restriction-era field manuals.
  EXCEPTION: A40 (FM 31-20-5 Special Reconnaissance) carries "Distribution
  authorized to U.S. Government agencies only" — administrative restriction,
  not copyright; assimilated per user ruling of 2026-09-12 (same class as
  A28/CLAIM-011). A47 (ST 31-91B) is a scanned edition; OCR intake.
- CONFIDENCE: Almost certain (93% band).
- STATUS: ACTIVE.


## CLAIM-013 — Vault Store v2 + first owned copyrighted work
- CLAIM: ExocortexVault RAG Store v2 (committed 2026-09-12) contains all 74
  library books (16,900 chunks) — closing the pending A11-A47 vault gap —
  plus one Architect-OWNED copyrighted work: the Victor Harris 1974
  translation of the Book of Five Rings (epub, purchased by Architect).
  PD English translation search exhausted 2026-09-12: exactly four English
  translations exist (Harris 1974, Cleary 1993, Nihon Services 1982,
  Kaufman 1999), all copyrighted; CLAIM-006 confirmed against primary
  evidence. The Harris epub is vault-only: never public, never quoted at
  length, cataloged in the public MOC as metadata only.
- CONFIDENCE: Almost certain (93% band).
- STATUS: ACTIVE.


## CLAIM-014 — Bak Mei doppelganger provenance
- CLAIM: Sifu Bak Mei is inducted as a dual-layer member: (1) the legendary
  Elder — a charter myth traceable to Wan Nian Qing (1893) and secret-society
  folklore, ZERO contemporaneous records, seated explicitly AS myth/patron;
  (2) the documented art systematized by Cheung Lai Chuen (1880-1966), who
  left no writings (oral transmission). Grounding corpus: B10 public dossier
  (Taiping Institute + Wikipedia CC BY-SA). The 《白眉拳譜》 (Jiang Chaowei,
  30-year compilation) is the designated A-series anchor, acquisition pending.
  Doppelganger law: cite the art's own verses, never film depictions.
- AMENDMENT 2026-09-12 (ACH per RedTeamRules v2): the Hong Kong Pak Mei
  association (pakmei.org, Cheung family lineage body) has issued a formal
  repudiation of the 《白眉拳譜》: (1) its demonstrations are the author's
  personal interpretation, not school practice; (2) techniques differ
  substantially from lineage understanding; (3) most "forms" are allegedly
  non-lineage material from other styles. CONSEQUENCE: if acquired, the
  book is ingested as CONTESTED SOURCE — it grounds the documented public
  layer, NOT the orthodox transmission. No single published manual may be
  treated as Pak Mei scripture; the art's authoritative layer remains
  oral/closed-door by the lineage's own account.
- AMENDMENT 2 (2026-09-12, ACH continued): author identity resolved —
  Jiang Chaowei is a VIETNAM-BRANCH inheritor (student of Tsang Wai Bok,
  the Saigon line founder, per B10) and a medical doctor; the book is the
  Vietnam branch's 30-year compilation (博學出版社, ISBN 978-988-14034-6-9;
  also a Vietnamese two-volume edition 上/下). The HK repudiation is
  therefore a BRANCH DISPUTE (Cheung-family HK line vs. Tsang Wai Bok
  Vietnam line), not evidence of spurious content. RECLASSIFICATION: the
  book is the Vietnam branch's manual — contested by HK, legitimate as
  Vietnam-lineage doctrine. Purchase channel identified: books.com.tw
  ebook E050039608 (lawful owned-work path).
- CONFIDENCE: Almost certain (93% band) on the myth/art distinction;
  technical principles Probable (75% band); the 白眉拳譜 Probable (75%
  band) AS VIETNAM-BRANCH doctrine, Chances about even (50% band) as a
  description of the HK/Cheung-family line.
- STATUS: ACTIVE.


## CLAIM-015 — A48 48 Laws of Power provenance
- CLAIM: A48 is the Architect-owned Penguin epub of Robert Greene's The 48
  Laws of Power (ISBN 9780140280197), ingested 2026-09-12 as 654 law-anchored
  chunks. Copyrighted owned work: plaintext lives only in the local working
  library and the encrypted vault (Store v3); public repo carries metadata
  only. Vault Store v3 now covers all 76 books + 2 owned epubs.
- CONFIDENCE: Almost certain (93% band).
- STATUS: ACTIVE.


## CLAIM-016 — A49 Cao Cao poems provenance
- CLAIM: A49 contains seven Cao Cao yuefu (短歌行二首, 觀滄海, 龜雖壽, 蒿里行,
  苦寒行, 卻東西門行) in the classical originals, sourced verbatim from
  zh.wikisource.org (works PD worldwide: author died 220 CE, published
  pre-1931). English renderings are OUR OWN glosses — no PD English
  translation exists (same class as CLAIM-006). Variant readings follow
  wikisource apparatus (e.g. 騰蛇/螣蛇).
- CONFIDENCE: Almost certain (93% band).
- STATUS: ACTIVE.

[RECAP] Every load-bearing claim: sourced, tiered, dated, falsifiable.
