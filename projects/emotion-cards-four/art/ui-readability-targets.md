# Emotion Cards Four — UI Readability Targets

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-003
- **Purpose:** Define implementation-facing readability targets for card presentation, HUD hierarchy, safe areas, text density, controller use, and spectator clarity
- **Status:** Draft for active production use
- **Related docs:**
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
  - `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
  - `projects/emotion-cards-four/src/prototype-architecture-baseline.md`

---

## 1. Goal

Prototype UI should let both a first-session player and a passive observer answer five questions quickly:
1. What is the situation?
2. What did the player choose?
3. What changed?
4. Why did that happen?
5. Is Breakthrough opening or blocked?

This pass should optimize **legibility and causal clarity**, not decorative polish.

---

## 2. Readability Priorities

Preserve in this order:
1. category recognition
2. primary effect readability
3. visible state labels and response windows
4. turn-by-turn change summary
5. reaction explanation text
6. breakthrough status cue
7. illustration space
8. decorative motion/VFX

If something has to be cut, cut decorative density before cutting explanation.

---

## 3. Card Size Targets

### Enlarged / focused card target
Recommended readable width for the focused card:
- **280–360 px** equivalent in the prototype UI

This focused state should make the following readable without extra submenu depth:
- card name
- category
- primary effect
- conditional / risk
- key icon row

### In-hand card target
Recommended visible width for cards in hand:
- **160–220 px** equivalent

At in-hand size, cards do **not** need fully readable body text, but they must preserve:
- instant category recognition,
- title legibility where possible,
- obvious primary/secondary hierarchy,
- clear selected / illegal / disabled states.

### Scaling rule
Use the focused card as the primary reading state and treat the hand row as a **scan state**, not a full reading state.

---

## 4. Hand Size Targets

### Default hand target
Readability should be tuned for a default hand of:
- **4 cards visible**

### Stress-test range
The layout should remain workable at:
- **4–5 cards visible**

If a 5-card hand makes the UI feel cramped, reduce decorative footprint before shrinking text to unsafe levels.

### Hand readability rule
A player should be able to identify, at a glance:
- which card categories they hold,
- which card is currently focused,
- which card is selected as primary,
- whether support card selection is currently available.

---

## 5. Keyword Density Targets

### Ideal keyword density
Per card:
- **1–2 visible keywords** is ideal
- **3 visible keywords max** for prototype cards

If more than three keywords are needed to explain a card, the effect language is probably doing too much for first-session readability.

### Keyword use rules
- reuse a small shared vocabulary consistently
- do not introduce one-off terms lightly
- use icon support where it improves scan speed
- keep category identity separate from effect keywords

Outcome states should remain in plain language:
- Breakthrough
- Partial Resolution
- Stalemate
- Collapse

---

## 6. Text Load Targets

### Card body text target
Recommended primary rules text target:
- **14–28 words** ideal
- **32–36 words max** in exceptional cases

### Text hierarchy target
Cards should clearly separate:
1. card identity
2. primary effect
3. conditional / risk
4. support/detail info

### Practical rule
Players should be able to answer these questions after one quick read:
- What is this card trying to do?
- What state does it affect?
- What can go wrong if I misplay it?

If the card requires a paragraph to explain, the design or layout should simplify.

---

## 7. Card Layout Hierarchy

Recommended card layout order:
1. **Title**
2. **Category marker / icon**
3. **Primary effect text**
4. **Conditional / risk cue**
5. **Illustration slot**
6. **Tag/icon support row**

### Card-face rule
The card should communicate function before flavor.

### Breakthrough card rule
Breakthrough cards should look visibly distinct as **earned payoff states**, not as ordinary hand cards with a new border color.

---

## 8. HUD Layout Priorities

The encounter HUD must always expose:
- current encounter prompt
- readable labels for **Tension / Trust / Clarity / Momentum**
- response windows (open / closed / blocked)
- focused-card read panel or equivalent card-inspect state
- recent change summary
- plain-language reaction explanation
- current outcome direction / breakthrough status cue

### Recommended HUD priority order
1. encounter prompt
2. state labels/meters
3. response windows
4. focused card / selected play package
5. recent change summary
6. reaction explanation
7. outcome direction / result banner

If any of these elements become optional or hidden behind extra navigation, readability will drop fast.

---

## 9. Safe-Area / Screen Composition Targets

### Core safe-area rule
Keep all critical gameplay information inside a conservative central-safe read region.

Critical elements that must stay in the safe zone:
- encounter prompt
- state labels/meters
- response windows
- focused card / play area
- change summary
- reaction explanation
- outcome banner / breakthrough cue

### Composition rule
Reserve the center of the screen for:
- active encounter context
- card interaction
- immediate gameplay feedback

Peripheral zones can hold secondary context, but **no critical explanation should live only in corners or edge space**.

### Stream/capture rule
Assume the UI will be viewed via:
- Discord stream compression
- smaller laptop playback
- recorded footage
- creator overlays that may cover edges

If the UI only works comfortably full-screen on a local monitor, it fails the prototype’s readability goal.

---

## 10. Controller Readability Targets

### Navigation targets
Every playable card must be reachable in a predictable left/right flow with no ambiguous cursor jumps.

Primary action order should stay stable:
1. read encounter state
2. inspect hand
3. select primary card
4. optionally add support
5. confirm play

Illegal actions should stay visible but clearly marked as unavailable rather than disappearing.

### Focus readability targets
Focused card must enlarge enough to clearly read:
- name
- category
- primary effect
- conditional/risk

In-hand cards must still preserve instant category recognition through frame, color band, and icon.

### Practical controller target
- **1-button primary read:** focused card shows a full readable summary without nested menus
- **max 2 focus moves** from default turn state to the current most relevant action area
- support card state must visibly show one of:
  - available
  - selected
  - illegal for this package
  - locked by current response window

### Strong recommendation
Use a **single active focus rail** with:
- strong card enlargement,
- persistent side panel or equivalent read area,
- stable confirm/cancel logic.

That is cleaner for prototype testing than trying to make every hand card fully readable at once.

---

## 11. Focus State Targets

Every interactable UI element should support clear visual differences for:
- default
- focused
- selected
- disabled / illegal
- resolving / locked during animation

### Minimum separation rule
Focus should not rely on one subtle cue alone. Combine at least:
- scale change
- brightness/value lift
- outline or frame accent
- reduced contrast on non-focused items

### Best prototype choice
**Scale + border + dim-rest-of-row** is stronger than soft glow-only focus, especially on streams and compressed capture.

---

## 12. Spectator Readability Targets

A spectator should be able to read, from the live HUD alone:
- the current encounter prompt
- current state labels for Tension / Trust / Clarity / Momentum
- open / closed response windows
- selected primary card and optional support card
- what changed this turn
- reaction reason in plain language
- current outcome direction: Breakthrough possible / blocked / not ready

### Spectator success target
A spectator should be able to explain the last turn in one sentence after watching only the HUD.

### Visibility rules
- important consequences cannot happen off-screen
- support card contribution must be surfaced explicitly
- result-state transitions should use clear readable labels, not subtle effects alone
- breakthrough readiness should have a visible state cue, not be hidden purely in backend logic

---

## 13. Turn Summary / Explanation Requirements

### Strong implementation-facing recommendation
Include both:
1. a **persistent focused-card read panel**
2. a **post-resolution turn summary strip**

These two features do the most work for controller use, spectator readability, and causal clarity.

### Recommended turn summary content
After resolution, show:
- **Played:** [Primary] + [Support]
- **Changed:** e.g. Trust +1, Clarity +1
- **Reaction:** e.g. Response window narrowed due to low clarity
- **Direction:** e.g. Breakthrough opening / blocked / not ready

This is one of the highest-value UI elements in the prototype.

---

## 14. Result / Explanation Visibility Rules

Each turn should visibly present, in order:
1. pre-play state
2. selected play package
3. resulting state changes
4. encounter reaction
5. current outcome direction

### Plain-language rule
The prototype must not rely on invisible math alone. State changes and reactions should be readable in plain language, even if raw values remain hidden or partially hidden.

### Explanation rule
If a card or reaction materially changed the encounter, the player and observer should be able to tell **what changed and why** without opening a debug panel.

---

## 15. Practical Validation Checklist

The UI is on target if:
- category is recognizable before full text is read
- 4-card hand state is readable at a glance
- focused card is readable without extra submenu digging
- card body text remains within practical limits
- response windows are visible and understandable
- Tension / Trust / Clarity / Momentum are always readable
- recent change summary is always visible after a turn
- reaction cause text is visible and understandable
- breakthrough/collapse direction is visible
- controller focus is obvious at all times
- the UI remains understandable when viewed at reduced capture size

---

## 16. Do / Don’t Rules

### Do
- prioritize scan readability first
- make state labels and response windows non-optional
- keep the center read zone focused on prompt + card play + immediate feedback
- use short labels over dense explanatory blocks when possible
- support meaning with icon, hierarchy, and layout
- keep motion restrained and explanatory

### Don’t
- hide critical explanation at the screen edges
- rely on full text readability for hand cards
- stack multiple simultaneous effects that obscure text or card identity
- depend on color-only feedback for major state shifts
- bury reaction cause text behind extra menus
- shrink text to preserve decorative layout

---

## 17. Bottom Line

Best ART-003 target for this prototype:
- **controller-friendly**
- **focus-obvious**
- **spectator-readable**
- **stream-safe**
- **causally clear**

For Emotion Cards Four, the most important UI win is not prettier cards — it is making the player and the viewer understand **why the encounter shifted**.
