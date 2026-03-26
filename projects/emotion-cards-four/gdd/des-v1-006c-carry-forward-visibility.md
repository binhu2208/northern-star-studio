# DES-V1-006c — Carry-Forward Visibility

## Task ID
DES-V1-006c

## Source
DES-V1-006 — Core Loop Engagement Diagnosis

## Problem
The carry-forward system exists and is architecturally correct. But Bin didn't feel a bad early decision hitting him in encounter 3. The mechanical consequence was there — the emotional weight was invisible.

Players need to feel the through-line of their run, not just see stat modifiers.

## Design Principle
Before each encounter, the player should be able to answer: **what did my last encounter feel like, and how is it affecting this one?**

## Changes Required

### At Encounter Start — "Last Time" Summary
Before each encounter (after encounter 1), display a one-line emotional readout of the previous encounter result:

Format: "**[Encounter N result]** — [one line emotional summary]"

Examples:
- "Last time: You broke through. The air shifted. Something changed."
- "Last time: It stalled. You're both still standing in the same place."
- "Last time: It collapsed. The wall went up."

This should be the first thing visible at the encounter open — before the hand, before the prompt. The emotional through-line comes first.

### At Encounter Start — Carry-Forward State Readout
Below the last-time summary, show how prior encounters are affecting this one:

Format: "[Stat or keyword] → [effect on current encounter]"

Examples:
- "Trust carried forward: The silence between you is louder now."
- "Tension carried forward: The air is still thick from before."
- "A pattern repeated: This is the third time you've both done this."

### At Run Summary — "What the Run Meant"
The current RunSummaryGenerator outputs a structured log. Add an emotional summary layer:

"The run left you with [state of relationship] — [one sentence summary]. [Standout moment], [emotional consequence of outcome distribution]."

Example:
"The run left you with an open door — you broke through once, collapsed once, and the last conversation is still unfinished. The hardest part wasn't the conflict. It was the silence after."

### In the HUD — Passive Carry-Forward Indicators
Add small persistent indicators showing carry-forward direction:
- Trust carried forward: warm/cool tint on the trust meter
- Tension carried forward: color shift on the tension meter
- Pattern indicator: small icon when Repeated Pattern was played in a prior encounter

## Implementation Notes

This is primarily a UI/text layer addition. Engineering needs to:
1. Pass encounter result summary text to the UI alongside stat changes
2. Surface `carryForwardModifiers` and `runResultHistory` at encounter open
3. Hook the RunSummaryGenerator emotional summary into the end-of-run display

No changes to engine logic required — only UI and content.

## Dependencies
- Blocks: MKT-V1-002
- Engineering: John (for UI hooks into carryForwardModifiers and encounter result history)
- Content: The emotional readout text is in this document

## Success Criterion
After encounter 2, Bin can answer: "How did my encounter 1 decision affect encounter 2?" If he can answer that without being told, carry-forward is legible. If he can't, it needs more work.

---

**Canonical file:** `projects/emotion-cards-four/gdd/des-v1-006c-carry-forward-visibility.md`
