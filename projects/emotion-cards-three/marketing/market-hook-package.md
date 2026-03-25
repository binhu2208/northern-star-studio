# MKT-005 — Market Hook Package

## Purpose
Turn the prototype readability work into a compact market-facing hook package the team can use for greenlight review, internal pitching, wishlist-facing tests, and capture guidance.

This package defines:
- one primary one-line pitch
- one screenshot hook target
- one short combat clip target with pass/fail criteria

It is built from the current readability and vertical-slice outputs, not from final art assumptions.

---

## 1. One-Line Pitch
**Emotion Cards Three is a deckbuilding battler where your emotional state changes what your cards do, so every fight is about choosing whether to steady yourself, sharpen your focus, or push into dangerous overdrive.**

### Short alt versions
Use these when space is tighter:
- **A deckbuilding battler where your emotional state is your strategy.**
- **Play a card battler where staying calm, getting focused, or going overwhelmed changes every turn.**
- **An emotion-driven deckbuilder where the riskiest state can win the fight — or wreck your next turn.**

### Why this pitch works
It preserves the three most marketable truths proven by the current docs:
- the game is a **deckbuilding battler** immediately
- the hook is **emotional state changes card behavior**
- the tension is **risk vs control**, not flavor-only mood text

### Messaging guardrails
Keep the pitch anchored to strategy, not abstraction.

#### Say
- emotional state changes what your cards do
- steady, focus, risk, overdrive, overwhelm
- readable tactical tradeoffs
- deckbuilding/combat decisions tied to emotion

#### Avoid
- vague therapy-game wording
- purely narrative framing that hides the combat hook
- overclaiming content scale beyond the current slice
- jargon that makes the system sound academic instead of playable

---

## 2. Core Market Read
### What the market-facing hook actually is
The hook is **not** just “a game about emotions.”
That is too broad and too soft.

The hook is:
**your emotion is the combat stance, and changing that stance changes what your cards are good at right now.**

That matters because it gives the game a clean, legible promise in screenshots and clips:
- visible state
- visible shift
- visible consequence

### What the first impression should communicate
A new viewer should be able to understand, within seconds, that:
- this is a card battler
- the player has a current emotional state
- that state affects the current turn
- pushing harder creates both upside and danger

If the capture does not show those four things, it is not the right market-facing asset.

---

## 3. Screenshot Hook Target
### Primary screenshot target
Capture the moment where:
- the player has just entered **Overwhelmed**
- the enemy is visibly **Exposed**
- a high-impact burst/attack card is highlighted or resolving
- the enemy intent for next turn is still visible

This is the best single-frame hook because it communicates:
- card battler structure
- emotional-state system
- danger/reward tension
- a dramatic, understandable decision moment

### Why this is the best screenshot target
From the readability docs, Overwhelmed is the strongest shape/color/spectacle state.
From the combat/readability support doc, Exposed + Overwhelmed + visible intent is the clearest “I get what is happening” frame.

In plain terms: it looks like a moment, not just a UI screen.

### Screenshot composition requirements
The frame should clearly show:
- player emotional state badge + readable label: **Overwhelmed**
- one-line state summary or downside reminder
- enemy intent panel
- enemy **Exposed** marker
- at least one readable card or attack result
- health context for both sides

### Screenshot focal hierarchy
The visual read order should be:
1. **Overwhelmed** state callout / badge
2. enemy vulnerability or incoming threat
3. burst card / hit result
4. supporting health and combat context

### Screenshot acceptance criteria
The screenshot is good enough if a viewer can infer all of the following without explanation:
- this is a combat card game
- emotion is a gameplay system, not flavor text
- the player is in a dangerous power state
- this turn is a payoff moment

### Screenshot failure signs
Reject the frame if:
- the emotional state is visible only after zooming
- the frame looks like generic buff/debuff clutter
- the enemy threat/opportunity is not readable
- the card text is too small to support the moment
- the frame looks idle instead of decisive

### Cropping guidance
If the image is later cropped for Discord, social, or store capsule tests, it should still preserve:
- state badge/name
- enemy condition/intent
- one action cue

If cropping removes the emotional-system read, the screenshot is not robust enough.

---

## 4. Short Combat Clip Target
### Primary clip concept
A short 6-10 second clip should show a clear emotional escalation and payoff sequence:
1. player starts in **Focused** or **Agitated**
2. player plays a setup or shift card
3. state escalates into **Overwhelmed** with a clear transition
4. player lands a heavy hit on an **Exposed** enemy
5. the immediate downside reminder appears for the next turn

### Why this is the right clip
It proves the hook in motion:
- state is readable before the action
- state changes during the action
- power payoff is immediate
- risk cost is also visible

That is the exact “emotion as strategy” promise the concept-validation brief says the prototype must support.

### Clip pass criteria
The clip works if a viewer can understand, without narration, that:
- the player changed emotional state mid-sequence or just before payoff
- the new state improved the attack or made the moment more explosive
- that power comes with a visible cost or danger

### Clip timing criteria
Aim for:
- **0-2 sec:** current state and enemy intent readable
- **2-5 sec:** setup/shift card is played
- **5-7 sec:** Overwhelmed transition lands clearly
- **7-10 sec:** burst payoff + downside reminder

If it takes longer than that to explain itself, the clip is too slow for top-of-funnel use.

### Clip readability criteria
The clip should preserve:
- readable state label text
- distinct state shape/color change
- visible enemy condition or intent
- one obvious damage/payoff event
- clear downside reminder after the peak

### Clip failure signs
Reject the clip if:
- the viewer sees effects but cannot tell why they happened
- Overwhelmed looks like a generic red flash with no gameplay meaning
- the enemy’s vulnerable window is unclear
- the downside is invisible, making the system look like pure upside
- multiple overlapping popups make the action noisy instead of legible

---

## 5. Capture Guidance for the Team
### For design/dev
When preparing a capture build, protect these items first:
- stable state badge placement
- readable enemy intent text
- obvious Exposed treatment
- explicit state transition callout
- short current-state summary text

### For art/UI
Readability beats polish.
If a decorative effect makes the key state/intent/card read harder, cut it for capture.

### For producer review
Do not approve a screenshot or clip just because it looks energetic.
Approve it only if it shows:
- what the current emotional state is
- why that state matters right now
- what the player is exploiting or risking

---

## 6. Suggested Asset Review Checklist
Use this before presenting the hook package in greenlight or external-facing tests.

### One-line pitch
- [ ] says card battler/deckbuilder plainly
- [ ] states that emotional state changes gameplay
- [ ] implies risk/control tension
- [ ] does not over-explain lore or narrative framing

### Screenshot
- [ ] state is readable in under 2 seconds
- [ ] Overwhelmed reads as dangerous, not just stronger
- [ ] enemy opportunity or threat is visible
- [ ] one decisive action dominates the frame
- [ ] image survives compression/cropping

### Clip
- [ ] emotional state is visible before payoff
- [ ] state change is legible in motion
- [ ] payoff lands clearly
- [ ] downside is shown immediately after
- [ ] clip works without voiceover

---

## 7. Final Recommendation
Lead with the strategy-first version of the concept.

The strongest market angle available right now is:
**this is a deckbuilding battler where emotion is not theme dressing — it is the combat stance system, and pushing into Overwhelmed creates the kind of dangerous, screenshot-and-clip-friendly payoff the prototype can actually prove.**

That is the promise the current slice can support honestly, and it is the one the team should protect in every capture and pitch review.
