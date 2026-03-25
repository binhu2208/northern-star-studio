# Emotion Cards Four - Prototype Card Taxonomy

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DES-002
- **Purpose:** Define the initial card taxonomy and first prototype card list for the flagship mode
- **Status:** Draft for active production use
- **Dependencies satisfied by:** `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
- **Canonical proposal reference:** `docs/proposals/emotion-cards-four-project-proposal.md`

---

## 1. Prototype Deck Design Goals
The first prototype card set exists to prove readability and emotional interaction, not content breadth.

The card taxonomy should support:
- quick first-session understanding,
- visible differences between emotional approaches,
- enough combination depth to create replay value,
- implementation-friendly tagging for state and synergy logic,
- scope that art and engineering can support without fake precision.

### Prototype target size
**24 core prototype cards** across four active categories, plus **3 breakthrough outcome cards** that are primarily unlocked by conditions rather than regularly drawn.

This yields:
- enough variety for multiple short encounters,
- manageable UI / content volume,
- a clear first implementation slice.

---

## 2. Card Category Structure

### A. Emotion Cards
Represent the emotional stance the player is bringing into the encounter.

**Gameplay role:**
- set the tone of a turn,
- influence trust / tension / momentum,
- signal the player’s immediate approach.

**Prototype count:** 7

### B. Memory Cards
Represent personal history, shared context, promises, regrets, patterns, or emotional baggage.

**Gameplay role:**
- explain why a response lands differently,
- improve or complicate interpretation,
- create strong synergy with emotion or reaction cards.

**Prototype count:** 6

### C. Reaction Cards
Represent immediate response patterns in the moment.

**Gameplay role:**
- de-escalate, confront, defend, redirect, or stabilize,
- directly manipulate encounter state,
- rescue bad momentum or push risky plays.

**Prototype count:** 7

### D. Shift Cards
Represent reframing, reinterpretation, perspective change, or emotional state transition.

**Gameplay role:**
- open closed response windows,
- convert weak states into playable states,
- set up breakthrough opportunities.

**Prototype count:** 4

### E. Breakthrough Cards
Represent earned high-value outcome moments.

**Gameplay role:**
- pay off aligned play,
- make outcome quality legible,
- reinforce encounter-resolution structure.

**Prototype count:** 3

---

## 3. Shared Data Model
Each prototype card should support the same minimum schema for design, engineering, and QA.

## Required fields
- **Card ID** — stable identifier
- **Name** — player-facing name
- **Category** — Emotion / Memory / Reaction / Shift / Breakthrough
- **Intent Tag** — primary play purpose
- **Tone Tag** — emotional or behavioral color
- **Primary Effect** — one clear gameplay effect
- **State Influence** — change to tension / trust / clarity / momentum
- **Synergy Tags** — what this card pairs well with
- **Risk Tag** — what can go wrong if misplayed
- **Readability Note** — short explanation for why it should make sense to first-session players

## Recommended implementation representation
### Intent tags
- `connect`
- `stabilize`
- `reveal`
- `protect`
- `pressure`
- `reframe`
- `recover`

### Tone tags
- `open`
- `guarded`
- `vulnerable`
- `assertive`
- `uncertain`
- `warm`
- `defensive`
- `playful`
- `heavy`

### Risk tags
- `escalates_if_trust_low`
- `fails_if_clarity_low`
- `weak_if_tension_high`
- `punished_if_repeated`
- `requires_memory_support`
- `requires_open_window`

---

## 4. State Influence Rules
To keep prototype readability high, each card should have one primary state effect and at most one conditional bonus effect.

### Core state axes
- **Tension**
- **Trust**
- **Clarity**
- **Momentum**

### Design rule
A card should not try to manipulate all four values at once.

### Typical patterns
- Emotion cards: set direction and lightly shift trust / momentum
- Memory cards: shift clarity / trust depending on context
- Reaction cards: strongly affect tension or response windows
- Shift cards: alter clarity, momentum, or available response windows
- Breakthrough cards: resolve outcome rather than acting like generic stat cards

---

## 5. Encounter Keywords / Response Windows
These keywords are used by encounters and cards to create clear interaction logic.

### Encounter keywords
- `fragile`
- `guarded`
- `misread`
- `public`
- `private`
- `heated`
- `stalled`
- `repairable`
- `defensive`
- `open_window`

### Usage intent
Example:
- a `guarded` encounter favors softer trust-building plays
- a `public` encounter makes shame and deflection more volatile
- a `misread` encounter rewards clarity-building and memory support

---

## 6. Prototype Card List

## Emotion Cards (7)

### E-001 Concern
- **Intent Tag:** connect
- **Tone Tag:** open
- **Primary Effect:** +1 Trust
- **Conditional:** If paired with a Memory card, +1 Clarity
- **Risk Tag:** weak_if_tension_high
- **Readability Note:** A gentle caring response should make emotional sense immediately.

### E-002 Relief
- **Intent Tag:** recover
- **Tone Tag:** warm
- **Primary Effect:** +1 Momentum after tension is reduced this turn
- **Conditional:** If Trust is medium or higher, may help trigger Breakthrough
- **Risk Tag:** requires_open_window
- **Readability Note:** Relief makes sense as a payoff emotion once pressure has eased.

### E-003 Shame
- **Intent Tag:** reveal
- **Tone Tag:** heavy
- **Primary Effect:** +1 Clarity, -1 Momentum
- **Conditional:** If paired with a supportive Memory, +1 Trust
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** Shame exposes something real but is dangerous in unsafe situations.

### E-004 Anger
- **Intent Tag:** pressure
- **Tone Tag:** assertive
- **Primary Effect:** +1 Pressure on encounter; may force state change
- **Conditional:** If encounter is already heated, also +1 Tension
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** Anger is easy to understand and creates obvious stakes.

### E-005 Hope
- **Intent Tag:** recover
- **Tone Tag:** vulnerable
- **Primary Effect:** +1 Momentum
- **Conditional:** If Clarity is medium or higher, +1 Trust
- **Risk Tag:** fails_if_clarity_low
- **Readability Note:** Hope reads as a future-facing attempt to move forward.

### E-006 Doubt
- **Intent Tag:** reveal
- **Tone Tag:** uncertain
- **Primary Effect:** +1 Clarity, -1 Trust if unsupported
- **Conditional:** If paired with a Reaction that protects the player, ignore the trust penalty
- **Risk Tag:** requires_memory_support
- **Readability Note:** Doubt can reveal uncertainty but destabilize the exchange.

### E-007 Relief Through Laughter
- **Intent Tag:** stabilize
- **Tone Tag:** playful
- **Primary Effect:** -1 Tension in non-heated encounters
- **Conditional:** In `public` encounters, also +1 Momentum if accepted
- **Risk Tag:** punished_if_repeated
- **Readability Note:** Lightness can help, but repeated deflection feels fake.

## Memory Cards (6)

### M-001 Old Promise
- **Intent Tag:** connect
- **Tone Tag:** warm
- **Primary Effect:** +1 Trust if encounter is not hostile
- **Conditional:** If paired with Concern or Hope, +1 Clarity
- **Risk Tag:** fails_if_clarity_low
- **Readability Note:** Shared history creates understandable emotional grounding.

### M-002 Shared Joke
- **Intent Tag:** stabilize
- **Tone Tag:** playful
- **Primary Effect:** -1 Tension in `public` or `fragile` encounters
- **Conditional:** If paired with Shame or Relief Through Laughter, +1 Trust
- **Risk Tag:** weak_if_tension_high
- **Readability Note:** A shared joke can soften embarrassment if timed well.

### M-003 Unkept Promise
- **Intent Tag:** reveal
- **Tone Tag:** heavy
- **Primary Effect:** +2 Clarity
- **Conditional:** If paired with Guarded Honesty, unlock a stronger repair line
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** Painful history clarifies the real issue but raises stakes.

### M-004 Quiet Support
- **Intent Tag:** protect
- **Tone Tag:** warm
- **Primary Effect:** Prevent the first trust loss this turn
- **Conditional:** If paired with Shame or Doubt, +1 Trust
- **Risk Tag:** weak_if_tension_high
- **Readability Note:** Supportive context makes vulnerability safer.

### M-005 Repeated Pattern
- **Intent Tag:** reveal
- **Tone Tag:** guarded
- **Primary Effect:** +1 Clarity and mark encounter as `defensive`
- **Conditional:** If followed by a Shift card next turn, gain +1 Momentum
- **Risk Tag:** punished_if_repeated
- **Readability Note:** Naming a pattern helps understanding but can harden the exchange.

### M-006 Missed Signal
- **Intent Tag:** reveal
- **Tone Tag:** uncertain
- **Primary Effect:** Remove one `misread` penalty from the encounter
- **Conditional:** If paired with Concern, open a safer response window
- **Risk Tag:** requires_open_window
- **Readability Note:** Reinterpreting a misunderstanding is central to the game’s pitch.

## Reaction Cards (7)

### R-001 Guarded Honesty
- **Intent Tag:** reveal
- **Tone Tag:** guarded
- **Primary Effect:** +1 Clarity, -1 Tension
- **Conditional:** If paired with a Memory card, reveal a safer dialogue option
- **Risk Tag:** fails_if_clarity_low
- **Readability Note:** Honest but careful communication is a strong prototype anchor card.

### R-002 Deflect
- **Intent Tag:** protect
- **Tone Tag:** defensive
- **Primary Effect:** Prevent 1 Tension increase this turn
- **Conditional:** Next turn -1 Clarity unless repaired
- **Risk Tag:** punished_if_repeated
- **Readability Note:** Deflection is intuitive and creates visible tradeoffs.

### R-003 De-escalate
- **Intent Tag:** stabilize
- **Tone Tag:** open
- **Primary Effect:** -2 Tension in `heated` or `fragile` encounters
- **Conditional:** If Momentum is negative, move it to neutral
- **Risk Tag:** weak_if_tension_high
- **Readability Note:** Players should instantly understand what this is for.

### R-004 Hold Boundary
- **Intent Tag:** protect
- **Tone Tag:** assertive
- **Primary Effect:** Prevent Collapse from direct pressure this turn
- **Conditional:** If Trust is medium or higher, +1 Respect / Momentum
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** Boundary-setting adds non-submissive emotional play.

### R-005 Pressure Back
- **Intent Tag:** pressure
- **Tone Tag:** assertive
- **Primary Effect:** force encounter reaction immediately
- **Conditional:** If Clarity is high, may expose contradiction and gain +1 Clarity
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** A risky card that shows aggressive play is possible but costly.

### R-006 Sit With It
- **Intent Tag:** recover
- **Tone Tag:** vulnerable
- **Primary Effect:** Skip escalation from the encounter’s next reaction step
- **Conditional:** If paired with Shame or Doubt, +1 Trust
- **Risk Tag:** requires_open_window
- **Readability Note:** Choosing not to react instantly can be emotionally legible and strategic.

### R-007 Reframe Gently
- **Intent Tag:** reframe
- **Tone Tag:** open
- **Primary Effect:** Convert one negative Momentum into neutral and +1 Clarity
- **Conditional:** In `misread` encounters, open a new response window
- **Risk Tag:** fails_if_clarity_low
- **Readability Note:** This is one of the clearest “change the interpretation” tools.

## Shift Cards (4)

### S-001 Change of Lens
- **Intent Tag:** reframe
- **Tone Tag:** open
- **Primary Effect:** remove one encounter keyword penalty tied to `misread` or `defensive`
- **Conditional:** If paired with a Memory card, +1 Clarity
- **Risk Tag:** requires_memory_support
- **Readability Note:** Directly supports the project’s interpretation-first promise.

### S-002 Slow the Room
- **Intent Tag:** stabilize
- **Tone Tag:** guarded
- **Primary Effect:** lock Tension from increasing for one turn
- **Conditional:** If used in `public` encounters, next turn gains +1 Trust if player follows with connect/stabilize play
- **Risk Tag:** weak_if_tension_high
- **Readability Note:** A clear pacing control tool for high-volatility scenes.

### S-003 Name the Pattern
- **Intent Tag:** reveal
- **Tone Tag:** heavy
- **Primary Effect:** +2 Clarity
- **Conditional:** Encounter becomes `fragile`; next poor-fit aggressive play gets punished harder
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** Big clarity spike with obvious emotional danger.

### S-004 Try Again Differently
- **Intent Tag:** recover
- **Tone Tag:** warm
- **Primary Effect:** replay the encounter reaction check with one improved state value of your choice
- **Conditional:** Only usable after a failed or weak turn
- **Risk Tag:** requires_open_window
- **Readability Note:** Strong prototype card for teaching that outcomes can be reshaped.

## Breakthrough Cards (3)

### B-001 Mutual Recognition
- **Intent Tag:** connect
- **Tone Tag:** vulnerable
- **Primary Effect:** Resolve encounter as Breakthrough if Trust and Clarity are both high
- **Conditional:** stronger reward if triggered after a Memory-supported play
- **Risk Tag:** requires_open_window
- **Readability Note:** The most classic “we finally understand each other” payoff.

### B-002 Stable Repair
- **Intent Tag:** recover
- **Tone Tag:** warm
- **Primary Effect:** Convert likely Partial Resolution into Breakthrough when Tension is low and Momentum is positive
- **Conditional:** grant carry-forward trust bonus into next encounter
- **Risk Tag:** fails_if_clarity_low
- **Readability Note:** Lets calm, sustained play pay off visibly.

### B-003 Hard Truth, Open Door
- **Intent Tag:** reveal
- **Tone Tag:** assertive
- **Primary Effect:** Resolve encounter positively after a high-Clarity, high-risk honesty line
- **Conditional:** only available if the player accepted vulnerability without collapsing trust
- **Risk Tag:** escalates_if_trust_low
- **Readability Note:** Supports the game’s promise that honesty can hurt before it heals.

---

## 7. Starter Prototype Deck Recommendation
For the first playable build, start each run with a simple deck that teaches the system.

### Suggested starter mix (12 cards)
- Concern
- Hope
- Shame
- Old Promise
- Quiet Support
- Missed Signal
- Guarded Honesty
- De-escalate
- Deflect
- Reframe Gently
- Change of Lens
- Slow the Room

### Why this mix
It gives the player:
- at least one clean connect line,
- at least one recovery line,
- at least one risky vulnerability line,
- one direct reframe tool,
- enough contrast to create meaningful misplays.

---

## 8. Synergy Rules for Prototype
To keep the first build manageable, use simple two-card synergy logic.

### Primary synergy pairs
- **Emotion + Memory** = stronger trust / clarity effects
- **Reaction + Memory** = safer difficult truths / better repair windows
- **Emotion + Shift** = state reinterpretation
- **Reaction + Shift** = rescue / reset plays

### General synergy principle
A strong combo should either:
- improve Clarity,
- reduce Tension,
- safely raise Trust,
- or open a better response window.

Do not require deep combo chains in the first prototype.

---

## 9. Encounter Fit Recommendations
These cards are designed to support at least three prototype encounters.

### Encounter A - Missed Signal
Best-fit cards:
- Concern
- Missed Signal
- Guarded Honesty
- Change of Lens
- Relief

### Encounter B - Public Embarrassment
Best-fit cards:
- Shared Joke
- Deflect
- De-escalate
- Shame
- Slow the Room

### Encounter C - Quiet Repair
Best-fit cards:
- Hope
- Quiet Support
- Sit With It
- Reframe Gently
- Stable Repair

These recommendations should help QA and DEV test whether encounter logic is producing understandable outcomes.

---

## 10. Content Constraints for Art / Engineering

### Art constraints
- Keep the prototype visually template-driven.
- Category identity should come from layout, color grouping, icon language, and one clear illustration slot.
- Avoid assuming bespoke illustration for every card in first prototype planning.

### Engineering constraints
- Cards should use shared effect primitives where possible.
- Most cards should map to small combinations of:
  - state increase / decrease,
  - keyword add / remove,
  - response window open / close,
  - conditional result unlock.

### QA constraints
- Every card should be testable in isolation and in one obvious synergy pair.
- Players should be able to explain card purpose in plain language after one use.

---

## 11. Open Questions for DEV-001A
- Should `Response Window` be modeled as tags on encounters, tags on cards, or both?
- Is `Momentum` a scalar value, directional enum, or threshold band?
- Should breakthrough cards exist as hidden unlocks, visible earned cards, or conditional encounter actions?
- How many effect primitives are enough to express this set without bespoke scripting per card?

---

## 12. Recommendation
This taxonomy is sufficient to unblock:
- **ART-001** art scope assumptions,
- **ART-003** readability planning,
- **DEV-001A** architecture baseline,
- **DEV-001B** schema / integration planning,
- future encounter and prototype implementation work.

The next best design move after this file is to let engineering translate the effect model into implementation primitives while design pressure-tests wording and card-role clarity.

---

**Canonical file:** `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
