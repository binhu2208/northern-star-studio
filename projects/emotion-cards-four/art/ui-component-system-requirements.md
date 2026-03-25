# Emotion Cards Four — UI Component System Requirements

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-004
- **Purpose:** Define reusable card frame, icon, and HUD/UI component system requirements for prototype implementation after style direction selection
- **Status:** Draft for active production use
- **Related docs:**
  - `projects/emotion-cards-four/art/style-exploration-pass.md`
  - `projects/emotion-cards-four/art/ui-readability-targets.md`
  - `projects/emotion-cards-four/art/art-scope-sheet.md`

---

## 1. Goal

Build a **reusable, controller-friendly, stream-safe component system** that makes each turn readable in plain language and keeps engineering from inheriting a messy art-dependent UI.

The system should let a player or spectator quickly understand:
1. what the situation is,
2. what card package was played,
3. what changed,
4. why it changed,
5. whether Breakthrough is opening, blocked, or unavailable.

This system should follow the selected style lane:
- **Calm Diagnostic** as the base
- small warmth accents where useful
- readable first
- no melodrama

---

## 2. System Principles

### A. Reusable over bespoke
Scope the prototype as a **shared component system**, not one-off encounter screens or flattened card art.

### B. Readability before decoration
Preserve in this order:
1. state readability
2. card/action readability
3. response-window clarity
4. change/explanation clarity
5. result visibility
6. illustration and decorative polish

### C. Data-driven and iteration-safe
UI text, labels, and outcome language must remain separate from art so tuning and wording changes do not break layouts.

### D. Spectator-readable
Critical state change and reaction explanation must happen **on-screen and in plain language**, not through hidden logic or subtle FX alone.

---

## 3. Reusable Card Frame System Requirements

### Required frame families
The card system must support **5 reusable frame families**:
1. Emotion
2. Memory
3. Reaction
4. Shift
5. Breakthrough

### Shared structure
All card frames must use one common structural template so cards remain data-driven and consistent.

Every frame family should support:
- title zone
- category marker zone
- primary rules text zone
- conditional/risk support zone
- icon/tag row
- focal illustration slot
- selected/focused/disabled state treatment

### Per-family differentiation rules
Each family should feel distinct enough for instant recognition without breaking the shared system.

#### Emotion
- softer rounded / expressive cues
- open category banding
- emotionally present, not chaotic

#### Memory
- inset archival / contextual cues
- contained visual space suggesting recall/context
- grounded and reflective feel

#### Reaction
- angular active / tactical cues
- immediate-action energy without combat-game aggression
- strongest “in the moment” family

#### Shift
- offset / transitional / reframing cues
- implies perspective change, not force

#### Breakthrough
- luminous resolved / payoff cues
- clearly earned outcome state, not rarity gimmick

### Frame state variants
Each family must support consistent visual variants for:
- default
- focused
- selected
- disabled / illegal
- resolving / locked
- compact hand state
- enlarged focused state

### Implementation-facing frame requirements
- cards must behave as **data-populated layouts**, not flattened art composites
- text must remain separate from frame graphics
- title and rules zones must tolerate wording changes
- frame families must preserve recognition at scan size
- selected/focused/illegal states must be readable without color alone
- category differentiation should come from a mix of structure, icon placement, and accent treatment — not only hue

### Frame-system acceptance check
The frame system is on target if:
- categories are recognizable before full text is read
- all five families still feel like one coherent system
- focused cards remain readable without extra UI layers
- hand cards preserve scan readability
- state variants remain obvious under stream compression or reduced scale

---

## 4. Reusable Icon System Requirements

### Goal of the icon system
The icon system exists to improve **scan speed, causal clarity, and category recognition** across cards and encounter UI.

This is a **core UX dependency**, not polish.

### Icon categories
#### Card category icons
Required for:
- Emotion
- Memory
- Reaction
- Shift
- Breakthrough

#### Core state icons
Required for:
- Tension
- Trust
- Clarity
- Momentum

#### Response / system icons
Required for:
- response window open
- response window closed
- response window blocked
- risk / warning
- positive delta
- negative delta
- selected
- disabled / illegal
- breakthrough available
- breakthrough blocked
- collapse warning

### Icon style rules
Icons must be:
- shape-first
- readable at small sizes
- monochrome-legible before color
- reusable across cards and HUD
- distinct by semantic group
- safe under stream/compression conditions

Detailed style constraints:
- simple silhouettes first
- thick, clean strokes
- minimal internal detail
- no fragile linework, filigree, or texture noise
- color supports meaning but does not carry it alone
- one stroke logic and one silhouette discipline across the set

### Semantic shape mapping
Use consistent shape language so meaning survives without text or color.

- **Trust:** open, rounded, receptive shapes
- **Tension:** compressed, sharper, pressured shapes
- **Clarity:** symmetrical, lens-like, clean shapes
- **Momentum:** directional, forward-driving shapes

Category bias should also stay coherent:
- Emotion = softer/organic
- Memory = framed/inset/container
- Reaction = firmer/angular/active
- Shift = offset/transitional
- Breakthrough = uplifted/radiant/resolved

### Icon usage rules
#### Cards
Icons should support, not replace, the card hierarchy:
1. Title
2. Category marker
3. Primary effect
4. Conditional / risk
5. Illustration slot
6. Tag/icon row

#### Hand cards
At hand size, prioritize:
- category recognition
- selected/focused state
- disabled/illegal state
- obvious primary identity

Do not overload hand cards with too many small icons.

#### HUD
HUD icon use should prioritize:
- Tension / Trust / Clarity / Momentum labels
- response window state
- recent turn change summary
- breakthrough/collapse direction

Critical explanation must not be icon-only; pair icons with readable labels where stakes are high.

### Icon state variants
Each icon family should support:
- default
- focused
- selected
- disabled / illegal
- resolving / locked

State changes should be communicated through:
- scale
- value/contrast
- outline/accent
- dimming of non-active elements

Do not rely on glow-only or color-only treatment.

### Icon-system acceptance check
The icon system is on target if:
- card categories are recognizable before full text is read
- Tension / Trust / Clarity / Momentum are easy to distinguish instantly
- open / closed / blocked response states are obvious
- positive vs negative change reads clearly
- focused, selected, and illegal states are visible at a glance
- meaning survives without relying on color alone

---

## 5. Reusable HUD / UI Component Requirements

### Required reusable components
The prototype HUD/UI system must provide reusable versions of the following:
1. focused-card read panel
2. turn summary strip
3. state meter family
4. response window component family
5. result banner set
6. reaction / explanation callout
7. shared focus-state treatment

### 5.1 Focused-card read panel
Persistent read area for the currently focused card or selected play package.

#### Must show
- card title
- category icon/label
- primary effect
- conditional/risk text
- key icons/tags
- selected state and support relationship where applicable

#### Requirements
- supports all card families through one shared layout shell
- readable without opening a separate submenu
- uses strong hierarchy: title → category → primary effect → risk/conditional
- supports compact inspect state and enlarged confirm state

### 5.2 Turn summary strip
Post-resolution strip showing what happened this turn.

#### Must show
- **Played:** primary card + support card if used
- **Changed:** stat deltas
- **Reaction:** short plain-language consequence
- **Direction:** Breakthrough opening / blocked / not ready

#### Requirements
- appears immediately after resolution
- remains readable under controller use and spectator viewing
- uses short labels and delta icons
- remains visible long enough to parse at compressed sizes
- reusable across all encounters with no bespoke layout changes

This component is mandatory. It is one of the highest-value readability pieces in the prototype.

### 5.3 State meter family
Reusable meter/label components for:
- Tension
- Trust
- Clarity
- Momentum

#### Must show
- state name
- current readable level/value presentation
- positive/negative change feedback
- temporary highlight when affected

#### Requirements
- labels must always stay visible
- do not rely on color alone
- icons/shapes should reinforce semantic meaning
- must support before/after feedback without debug UI

### 5.4 Response window components
Reusable UI set for response opportunities and restrictions.

#### Must support states
- open
- closed
- blocked
- locked by current play/package

#### Forms
- badge/chip
- inline HUD slot
- optional emphasized callout when state changes

#### Requirements
- readable at a glance
- visible from the main HUD without extra navigation
- illegal/blocked states remain visible rather than disappearing
- should pair with short explanation text when changed by resolution

### 5.5 Result banner set
Reusable result-state banners for:
- Breakthrough
- Partial Resolution
- Stalemate
- Collapse

#### Requirements
- strong readable label first
- distinct shape/icon treatment per result state
- visually separate from ordinary notifications
- usable both as direction cue and larger end/result emphasis
- should feel like system feedback, not cinematic overlay spectacle

### 5.6 Reaction / explanation callout
Plain-language explanation area for why the encounter reacted the way it did.

#### Must show
- reaction summary
- cause or trigger language
- relationship to state/window changes where relevant

#### Requirements
- always on-screen after meaningful reaction
- short readable phrasing
- supports spectator understanding in one glance
- should work alongside the turn summary strip, not replace it

---

## 6. Focus-State Requirements

Every interactable element must support:
- default
- focused
- selected
- disabled / illegal
- resolving / locked

### Minimum visual separation
Do not rely on one cue alone. Combine at least:
- scale change
- border/outline accent
- brightness/value shift
- dimming of non-focused elements

### Strong prototype recommendation
Use **scale + border + dim-rest-of-row** as the base focus language.

Additional rules:
- illegal actions remain visible but clearly unavailable
- selected state must be distinct from focused state
- resolving/locked state should reduce confusion during animation

---

## 7. Safe-Area and Layout Requirements

### Critical safe zone
Keep all critical gameplay information inside a conservative central-safe region.

The following must stay inside the safe area:
- encounter prompt
- state meters
- response windows
- focused-card read panel / active play area
- turn summary strip
- reaction explanation
- result / breakthrough direction cue

### Edge rule
Do not place only at screen edges:
- reaction cause text
- outcome direction
- important turn change feedback
- response-window status

### Screen composition
Reserve the center for:
- active encounter context
- current card interaction
- immediate result feedback

Peripheral zones may hold secondary context, but no critical explanation should live only in corners.

### Stream/capture assumption
The layout must remain understandable on:
- Discord streams
- laptop playback
- recordings
- partially obstructed capture layouts

If it only works full-screen on a local monitor, it fails the prototype target.

---

## 8. Data-Driven Separation Rules

To keep engineering sane, the following should remain separate from decorative art:
- text labels
- rules copy
- reaction/explanation text
- state values/labels
- outcome wording
- response-window state text

### Structural rule
Art should provide reusable shells and visual states.
Data/system logic should drive:
- content strings
- state changes
- icon mapping
- focused/selected/illegal variants
- turn summary text
- reaction explanation text

### Why this matters
If these are baked into flat art, iteration speed drops immediately and localization/future expansion gets worse.

---

## 9. Production Order Recommendation

If implementing the system in stages, build in this order:
1. card frame family shell
2. icon library
3. state meter family
4. focused-card read panel
5. response window components
6. turn summary strip
7. reaction/explanation callout
8. result banners
9. polish/state-motion layer

If scope tightens, cut decorative polish before cutting readable labels, explanation systems, or focus clarity.

---

## 10. Validation Checklist

The component system is on target if:
- frame families remain coherent and distinct
- focused cards are readable without submenu depth
- state meters are always readable
- response windows are visible and understandable
- a spectator can tell what changed this turn
- support-card contribution is visible when used
- result direction is readable in plain language
- focus/selected/illegal states are unmistakable
- critical information survives reduced-size viewing
- the system works as a shared shell across multiple encounters

---

## 11. Bottom Line

ART-004 should define the prototype UI as a **reusable explanation-first component system**.

The most important deliverables are not decorative screens. They are the reusable parts that make the game readable:
- frame families
- icon library
- focused-card panel
- turn summary strip
- state meters
- response-window indicators
- reaction explanation
- result banners
- strong focus states
- safe-area-respecting layout

If those pieces are solid, the prototype will be understandable, testable, and much easier to iterate.
