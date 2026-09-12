"""
Constitutional Validators v1.0 — LAW enforcement at the output boundary.
Origin: SecondOpinionReview-2026-09-12 adoption B.2. Coding Cluster module.
The constitution is no longer only prompted — it is checked.

Usage: validate_output(text) -> {"ok": bool, "violations": [ ... ]}
"""
import re

# Kent WEP bands (verbatim 1964); bare percentages for confidence are banned.
KENT = re.compile(
    r"(Almost certain|Probable|Chances about even|Probably not|Almost certainly not)"
    r"[^.\n]*\d+\s*%\s*\u00b1\s*\d+\s*%", re.I)
BARE_CONF = re.compile(r"\bconfidence[:\s]+\s*(high|medium|low)\b", re.I)
BARE_PCT = re.compile(r"\bconfidence[:\s]+\s*\d+\s*%", re.I)

# Grounding: either a chunk citation [A## p.##] / [B##] / [G#] / [E#] style
# anchor, or an explicit [INFERRED] / [F-DOCTRINE] / [YI-COUNSEL] tag.
CITE = re.compile(r"\[(?:A|B|C|D|E|G)\d+[^\]]*\]|\[INFERRED\]|\[F-DOCTRINE\]|\[YÎ-COUNSEL\]")
CLAIM_LIKE = re.compile(r"\b(is|are|was|were|will|would|must|shall)\b", re.I)

def validate_output(text, require_citation=True):
    v = []
    # Rule 1 — Kent bands: any stated confidence must be a WEP band with %±%
    if BARE_CONF.search(text):
        v.append("LAW: bare HIGH/MEDIUM/LOW confidence forbidden — use Kent WEP band")
    if BARE_PCT.search(text) and not KENT.search(text):
        v.append("LAW: bare percentage confidence forbidden — use Kent band with ±")
    # Rule 2 — grounding: deliberative output must cite chunks or tag [INFERRED]
    if require_citation and not CITE.search(text):
        v.append("LAW: no corpus citation and no [INFERRED] tag — ungrounded output")
    return {"ok": not v, "violations": v}

def validate_deliberation(turns):
    """turns: [{voice, text}...] -> per-turn verdicts + session summary."""
    out = [(t["voice"], validate_output(t["text"])) for t in turns]
    bad = [v for v, r in out if not r["ok"]]
    return {"turns": out, "ok": not bad, "offending_voices": bad}
