# DES-V1-006 — Core Loop Engagement Diagnosis

## Task ID
DES-V1-006

## Status
Active — blocking MKT-V1-002

## Source
Bin played the prototype with live coaching during a walkthrough. After seeing the full encounter loop with explanation, Bin's direct feedback was: **"I neither feel fun and challenging."** This is a pre-MKT finding — if the studio lead doesn't feel engagement even with coaching, external recruitment should not proceed.

## Problem
The core encounter loop (read situation → pick emotional response → see consequence) is mechanically sound but not **felt** by the player. Three specific gaps:

### Gap 1 — Encounter prompts are too abstract
The current encounter descriptions are scenario labels, not emotional experiences. "Someone thinks they were ignored on purpose" tells you what happened but doesn't make you **feel** the moment. A player encountering this for the first time needs to be dropped into the situation, not given a description of it.

**What needs to change:** Encounter prompts should read like a moment, not a summary. The emotional subtext should be legible. The player should know how they are supposed to feel before they pick a card.

### Gap 2 — Card effects are logical but not visceral
The game calculates consequences correctly. But there's no emotional weight to playing Shame in a tense moment, or Relief in a breakthrough. Cards produce results, not feelings.

**What needs to change:** Card text and resolution feedback should communicate the emotional experience of the outcome, not just the stat changes. "Tension drops by 1" reads as a number. "The room calms" reads as a feeling.

### Gap 3 — Stakes don't build through carry-forward
The carry-forward system exists and is architecturally correct. But Bin didn't feel a bad early decision hitting him in encounter 3. The mechanical consequence was there; the emotional consequence wasn't.

**What needs to change:** Run history should be more visible and consequential. Players should be reminded of what they did in earlier encounters and how it shaped the current moment. The emotional through-line of the run should be legible.

## Diagnosis Tasks

### DES-V1-006a — Encounter Prompt Rewrite
Rewrite all 5 encounter prompts to be experiential, not descriptive. Each prompt should:
- Drop the player into a moment
- Make the emotional stakes immediately clear
- Communicate how the player is supposed to feel

### DES-V1-006b — Card Resolution Language
Audit all card resolution feedback. Replace stat-change language with felt-language where possible. Add short emotional feedback to every resolution ("This lands. The tension breaks." vs "+2 Clarity").

### DES-V1-006c — Carry-Forward Visibility
Review how run history is surfaced to the player. Each encounter start should remind the player of the emotional through-line from prior encounters. Run summary should emphasize what the run **meant**, not just what happened.

## Dependencies
- Blocks: MKT-V1-002 (do not proceed with external recruitment until engagement is confirmed)
- Blocked by: No engineering dependency — this is design and content work
- Downstream: DES-V1-007 (if engagement is confirmed, card balance and encounter tuning can proceed)

## Success Criterion
**Bin plays the revised prototype without coaching and describes the experience as "fun" or "compelling."** If that bar is not met after DES-V1-006 revisions, escalate to the team for a broader conversation about the core concept before further investment.

---

**Canonical file:** `projects/emotion-cards-four/gdd/des-v1-006-engagement-diagnosis.md`
