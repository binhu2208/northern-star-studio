# DEV-002 — Prototype State UI and Readability Support

## Purpose
Define the placeholder UI and readability support needed to make the DEV-001 combat scenario understandable in play, in screenshots, and in short clips.

This is not a final UI art spec.
It is the **minimum implementation-ready readability layer** for the prototype.

Its job is to make sure a first-session player can answer, at a glance:
- what emotional state am I in?
- what does that state mean right now?
- what is the enemy about to do?
- which cards escalate, stabilize, or exploit the current moment?
- did the game clearly show when I crossed into danger?

Reference files:
- `projects/emotion-cards-three/src/prototype-combat-scenario.md`
- `projects/emotion-cards-three/art/readability-guide.md`
- `projects/emotion-cards-three/tests/qa-001-usability-and-readability-checks.md`

---

## 1. UI Goals
The prototype UI should prove three things quickly:

1. **State visibility**
   - the current emotional state is always easy to find

2. **Decision readability**
   - card/state/enemy-intent relationships are understandable before play

3. **Moment readability**
   - entering Overwhelmed creates a clear and legible peak moment suitable for screenshots and clips

### Non-goals
This phase should **not** attempt:
- final HUD polish
- dense animation systems
- long keyword glossaries
- broad accessibility feature sets beyond clear text/contrast/shape support
- content-heavy UI frameworks for future expansion

The goal is a readable prototype, not a production interface.

---

## 2. Core Screen Layout
Use a simple, stable combat layout.

### Recommended screen zones
#### Top center
- **Enemy panel**
- enemy HP
- enemy intent
- enemy temporary condition marker (example: Exposed)

#### Top right or top left
- **Turn summary / lightweight combat log**
- optional but helpful for state-change confirmation

#### Center battlefield
- player side and enemy side
- state-change flashes should anchor to unit position, not to random screen overlays

#### Bottom center
- **Hand of cards**
- card role and state-shift language must be readable here at gameplay size

#### Bottom left
- **Player panel**
- player HP
- current emotional state badge
- short current-state effect summary

#### Bottom right
- **Turn controls / end turn / energy**

### Layout principle
The player should not need to search more than one zone to answer any core combat question.

---

## 3. Emotional State HUD
The emotional-state display is the most important new UI element in the prototype.

## 3.1 Required state widget
The player HUD must include a dedicated **state widget** with all of the following:
- state badge icon
- state name in plain text
- state color treatment
- state shape treatment
- one-line gameplay summary

### Example widget content
**Focused**
- Badge: blue diamond / reticle shape
- Summary: `2nd card each turn gains a bonus`

The summary should be visible without hover in the prototype.
Do not make players inspect a tooltip just to know what their current state does.

## 3.2 Placement rule
The player state widget should appear:
- near player HP
- above or beside the hand, but not inside the hand
- in a stable position that does not move during card play

The enemy can optionally receive a smaller state/condition area if needed later, but DEV-002 only requires strong player-state visibility plus enemy conditions/intents.

## 3.3 Visual language by state
Follow ART-001 directly.

### Calm
- color: cool teal / muted cyan
- shape: rounded ring / circular silhouette
- one-line summary example: `Guard cards gain +2 block`

### Focused
- color: clear blue / indigo
- shape: diamond / reticle silhouette
- one-line summary example: `2nd card each turn gains a bonus`

### Agitated
- color: amber / orange
- shape: angled spike / rising diagonal silhouette
- one-line summary example: `Attack +2, Guard -1`

### Overwhelmed
- color: crimson / red-violet
- shape: fractured burst / broken star silhouette
- one-line summary example: `Attack +4, discard 1 next turn`

## 3.4 Shape-first fallback rule
If color is reduced or missed, the state widget must still read correctly by:
- badge silhouette
- label text
- motion style

Color alone is not enough.

---

## 4. State Transition Feedback
Players must clearly notice when state changes.

## 4.1 Required feedback event
Whenever the player's emotional state changes, the game should show:
- old state → new state
- short state-name callout
- matching color/shape shift on the state badge
- one brief impact cue near the player panel or avatar

### Example
`Focused → Agitated`

This should appear as a short, readable transition, not a large cinematic interruption.

## 4.2 Motion direction rules
To reinforce the ladder visually:
- upward shifts should feel sharper, brighter, more unstable
- downward shifts should feel smoother, softer, more centered

### Upward transitions
- Focused → Agitated: pulse spike, angled flare
- Agitated → Overwhelmed: fracture burst, warning flash, louder emphasis

### Downward transitions
- Overwhelmed → Agitated: burst collapse, reduced glow
- Agitated → Focused: settle animation, reduced edge tension
- Focused → Calm: ring closure / gentle softening

## 4.3 Overwhelmed special event
Entering **Overwhelmed** is the key spectacle beat of the prototype and must receive stronger feedback than normal shifts.

Minimum special treatment:
- larger badge flare
- brief screen-edge pulse or concentrated red-violet flash
- state text callout: `OVERWHELMED`
- next-turn downside reminder appears immediately after the shift

This moment should be readable in a still image and obvious in a short clip.

---

## 5. Card Readability Support
DEV-002 does not redesign the card system, but it must make card-state relationships visible enough to test.

## 5.1 Card layout requirements
Each card should visibly separate:
- card name
- cost
- primary action
- state shift / condition line
- role tag strip

### Suggested placeholder card structure
- **Top:** name + cost
- **Center:** simple icon badge + main text
- **Lower text line:** state shift text
- **Bottom tags:** Attack / Guard / Setup / Shift / Burst / Recover

## 5.2 State-shift text rule
Any card that changes emotional state must display the shift explicitly in consistent language.

Required wording style:
- `Shift 1 toward Calm`
- `Shift 1 toward Focused`
- `Shift 1 toward Agitated`
- `If already Agitated, become Overwhelmed`

Do not replace this with abstract verbs in the prototype.
Clarity wins.

## 5.3 Role tagging
To improve first-session readability, cards should include small role tags.

Recommended tags:
- **Attack**
- **Guard**
- **Setup**
- **Shift**
- **Burst**
- **Recover**

These tags are especially useful in screenshots where card art may still be placeholder.

## 5.4 Active-state synergy cue
If the current state changes a card's output, show a simple cue before play.

Examples:
- a small `+2` attack glow on attack cards while Agitated
- a `Bonus active` marker on the second card in Focused turns
- a warning border on guard cards while Agitated

This must stay subtle enough not to clutter the hand.

---

## 6. Enemy Intent and Condition Readability
The combat scenario depends on players understanding what the enemy is about to do and when the enemy is vulnerable.

## 6.1 Enemy intent panel
The enemy panel must show:
- current intended action
- expected damage value
- special reactive rule if relevant

### Example intent formats
- `Pressure Jab — 6 damage`
- `Feint and Open — 4 damage`
- `Punish Overreach — 9 damage (+3 if you end Agitated/Overwhelmed)`

Intent should be readable before the player acts, without hover.

## 6.2 Exposed condition marker
The enemy's **Exposed** turn is one of the prototype's key precision windows.
It must be impossible to miss.

Required support:
- condition label: `Exposed`
- distinct condition icon/badge
- one short plain-language summary near enemy intent or condition area: `First hit against this enemy deals +3`

### Visual note
Exposed should not look like another emotional state.
Use a separate treatment from the state system so players do not confuse condition icons with emotional-state badges.

## 6.3 Threat readability rule
When the enemy is on **Punish Overreach**, the UI should help players connect that threat to their emotional state.

Recommended support:
- the enemy intent line includes the exact trigger text
- the player state widget gains a mild warning accent if currently Agitated or Overwhelmed
- ending turn while in danger should not feel like a hidden gotcha

---

## 7. Current-State Summary Text
The prototype should include one short rules summary near the player state badge.

### Goal
Players should not need to memorize all four state rules after one tutorial message.

### Recommended format
`Current State: Focused — 2nd card each turn gains a bonus`

### Rules
- keep to one short sentence
- prioritize current impact over full system explanation
- update immediately when state changes

This single line will likely do a lot of work for first-session clarity.

---

## 8. Lightweight Combat Log
A full log is not required, but a minimal event feed is strongly recommended.

## 8.1 What it should capture
- state shifts
- enemy gains Exposed
- Overwhelmed downside queued
- card bonus triggers when useful

### Example entries
- `Shifted to Agitated`
- `Enemy is Exposed`
- `Entered Overwhelmed — discard 1 next turn`
- `Focused bonus triggered`

## 8.2 Why it matters
This supports:
- QA note-taking
- debugging comprehension failures
- screenshot annotation
- player confirmation during fast turns

The log should be compact and not become the main explanation layer.

---

## 9. Screenshot and Clip Support
DEV-002 should intentionally support at least one readable screenshot and one short readable combat clip.

## 9.1 Best screenshot target moment
The clearest screenshot target is:
- enemy is **Exposed**
- player has just entered **Overwhelmed**
- a burst card is highlighted or resolving
- enemy intent for the next turn is visible

This frame communicates:
- card battler
- emotional state hook
- danger/reward timing
- immediate combat consequence

## 9.2 Screenshot must-read checklist
At minimum, the captured frame should clearly show:
- player emotional state badge and label
- enemy condition or intent
- one readable card or combat effect
- health context for both sides
- enough contrast that Discord/mobile compression does not erase hierarchy

## 9.3 Clip moment target
A 6–10 second clip should ideally show:
1. player is Focused or Agitated
2. player plays the burst setup line
3. state shifts into Overwhelmed
4. damage lands on an Exposed enemy
5. downside reminder appears for next turn

If that clip works without narration, the prototype hook is in good shape.

---

## 10. Placeholder Visual Priority Order
Build UI support in this order:

### Priority 1 — Must have for prototype readability
- player state badge + label + summary
- enemy intent text
- enemy Exposed marker
- explicit state-shift callouts
- readable card state-shift text

### Priority 2 — Strongly recommended
- active-state card bonus indicators
- lightweight combat log
- Overwhelmed special transition effect
- warning accent during Punish Overreach risk

### Priority 3 — Nice if cheap
- micro-animations for state badge idling
- screenshot mode crop-safe framing guides
- simple end-turn reminder when current state is risky

This keeps the work tight and validation-focused.

---

## 11. QA Validation Hooks
QA-002 should be able to test this UI layer with direct questions.

The UI is doing its job if testers can answer:
- Where is your emotional state shown?
- What does your current state do?
- Which card in your hand is helping you stabilize or escalate?
- What is the enemy about to do?
- Why is this turn a danger turn or opportunity turn?
- Did you notice when you became Overwhelmed?

If testers miss those answers, the UI needs simplification before polish.

---

## 12. Engineering Notes
Keep implementation cheap and explicit.

Recommended prototype rules:
- prefer text + icon + color + shape together instead of deep animation work
- do not hide key rules in hover-only tooltips
- reuse one badge component with variant states instead of bespoke widgets per state
- keep all critical text in plain language
- avoid stacking too many simultaneous popups during the Overwhelmed transition

The prototype should feel readable first, stylish second.

---

## 13. Handoff Recommendation
Proceed with DEV-002 implementation as a focused placeholder UI pass supporting the DEV-001 combat scenario.

The minimum success bar is simple:
**a new player can identify state, read enemy intent, notice state change, and understand why the Overwhelmed moment matters without outside explanation.**

If the UI can do that, the prototype is ready for QA-002 and screenshot/clip review.