# Emotion Cards Four — ART-V1-002: Next-Action Cue (NAC) Component Design

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-V1-002
- **Purpose:** Design the Next-Action Cue (NAC) component for the run-state surface — visual treatment, states, placement, and implementation-facing specifications
- **Status:** Draft for implementation
- **Related docs:**
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/art/ui-readability-targets.md`
  - `projects/emotion-cards-four/art/ui-component-system-requirements.md`
  - `projects/emotion-cards-four/production/art-v1-scope-update.md`

---

## 1. NAC Purpose

The Next-Action Cue (NAC) is a persistent guidance element in the run-state surface that shows the player their most useful next action based on current encounter state.

The NAC should feel like **readable context**, not game scripting. A player should think "I see why that makes sense" rather than "the game is telling me what to play."

### NAC design principles
- readable at a glance
- controller-friendly and stream-safe
- visually subordinate to state meters and encounter prompts
- emotionally honest — shows state signals, not prescriptions
- follows the **Calm Diagnostic** visual lane

---

## 2. Stable Signal Inputs

These signals are confirmed from the current engine (DEV-V1-003/004) and are stable enough to design against:

- `phase` — current turn phase
- `runHealth` — derived from tension/trust/clarity/momentum with tone labels
- `openWindows` — array of open response window IDs
- `breakthroughReady` — boolean
- `collapseArmed` — boolean
- `encounter.name` — encounter display name
- `encounter.result` — current result state if resolved

DEV-V1-005 will add:
- `rewardChoices` — carry-forward reward options post-encounter

Design for the stable set now. Update if `rewardChoices` introduces a meaningful new signal pattern.

---

## 3. NAC Component States

The NAC must handle four states:

### State 1: Active Recommendation
The NAC has a clear, specific next action to suggest.

Visual treatment:
- visible label + icon
- elevated contrast / highlight relative to neutral state
- short causal link shown: "why this action makes sense given current state"
- paired icon representing the recommended card type or play pattern

### State 2: Neutral / Situation Clear
The current state is readable and no specific action dominates.

Visual treatment:
- present but subdued
- short neutral guidance: "your turn — choose a card" or equivalent
- no highlight or elevated contrast
- still visible, not suppressed

### State 3: No Signal
The NAC cannot generate a useful recommendation from current state.

Visual treatment:
- suppressed visually — not removed from layout
- very minimal presence
- no clutter or misleading guidance

### State 4: Locked / Encounter Resolving
The player cannot act; the encounter or transition is resolving.

Visual treatment:
- clearly distinct from interactive states
- short locked/waiting label
- no recommendation shown

---

## 4. NAC Visual Treatment

### Position
The NAC belongs in the **run-state surface panel**, not as a floating overlay or modal.

Recommended HUD reading order:
1. encounter prompt
2. state meters (Tension / Trust / Clarity / Momentum)
3. response window indicators
4. **Next-Action Cue (NAC)**
5. focused-card panel
6. hand cards
7. turn summary strip

The NAC is priority layer 4 — important but never dominant.

### Typography
- short, plain-language phrasing
- use language a first-session player would recognize
- do not use raw engine language or stat threshold names

Example phrasing patterns:
- "try connecting first" — when trust is building and a connect play is available
- "memory support helps here" — when a memory card would clarify a situation
- "open a trust window" — when trust-building is the logical next step
- "a reframe could shift this" — when perspective change would help

### Icon pairing
Pair the text label with a simple icon:
- use the card category icon set already designed (Emotion / Memory / Reaction / Shift)
- add a small directional or state-change icon where helpful
- icons must follow the shape-first, thick-stroke style from the icon system

### Color treatment
Follow **Calm Diagnostic**:
- restrained accent for active recommendation state only
- do not use aggressive color pops
- do not rely on color alone to convey meaning
- support guidance with icon + text, not color coding

### Scale and safe-area
- NAC must remain readable at reduced capture/screenshot size
- keep all text inside the central safe read zone
- do not place at screen edges or corners
- test at stream-compressed quality before finalizing

---

## 5. NAC Text Generation Guidance

The NAC text is driven by engine signals, but the phrasing rules are an art + design concern.

### Signal → guidance mapping principles

#### `phase`
- Read the current phase name and surface appropriate action
- `play_response` → show NAC
- `encounter_reaction` / `check_outcome` → show locked state

#### `runHealth`
- Map tone labels to plain-language guidance
- If trust is building → suggest trust-building plays
- If tension is high → suggest de-escalation or boundary-setting
- If clarity is low → suggest memory or clarity-building cards

#### `openWindows`
- Surface what response types are currently available
- If no windows open → NAC shows "nothing available — wait" or equivalent
- If a specific window is open → suggest the relevant card type

#### `breakthroughReady`
- If true → surface that a breakthrough path is open and what would capitalize
- If false → do not show breakthrough as an option

#### `collapseArmed`
- If true → surface that the situation is fragile, suggest caution plays
- Do not obscure the warning — make it readable

#### `encounter.name`
- Used for context only — do not expose in NAC text directly

### NAC text rules
- write guidance as plain language that a first-session player would recognize
- never expose raw stat values or engine flags in NAC text
- when in doubt, show the state signal ("trust is building") rather than the prescription ("play Memory card")
- keep to one short sentence max

### Fallback behavior
If no useful signal can be generated:
- show a neutral "your turn" state, not a blank
- never leave the NAC area visually empty during active play

---

## 6. State Variants Implementation

### Visual state matrix

| State | Visibility | Contrast | Icon | Text |
|-------|-----------|----------|------|------|
| Active Recommendation | full | elevated | category + directional | specific + causal |
| Neutral | visible | baseline | minimal or absent | generic |
| No Signal | minimal | suppressed | absent | very short / empty |
| Locked | visible | baseline | lock/wait icon | "wait" equivalent |

### Focus state rules
The NAC is not directly focusable as a game element — it is a read-only guidance strip.
- it does not need selected/disabled states
- it may have a subtle highlight when a new recommendation becomes active
- no hover state needed

---

## 7. Integration with Run-State Surface

The NAC slots into the existing run-state surface panel established in the prototype and refined in ART-003 / ART-004.

### Layout integration
- NAC occupies a dedicated slot in the run-state surface
- it does not push encounter prompt, state meters, or response windows out of the safe zone
- if the run-state surface already has a "what's next" or "current guidance" area, NAC replaces or formalizes that existing element

### Data integration
- NAC receives engine signals as inputs
- it does not need to read hand cards directly — it operates on encounter/state signals only
- if hand composition is needed for guidance, that data must be exposed as a signal by engineering

### Controller / spectator rules
- NAC is a read element — no controller interaction required
- it must be readable from the main game view without extra navigation
- spectator must be able to see the NAC recommendation in a one-second glance

---

## 8. Deliverables for ART-V1-002

This task produces:
1. **NAC component specification** — this document
2. **NAC visual design** — the actual visual treatment with states, colors, typography, and layout
3. **NAC signal-to-text mapping** — plain-language guidance rules for each signal input
4. **Run-state surface update** — layout adjustment to accommodate NAC cleanly

These deliverables feed directly into DEV-V1-007 (UI integration) and ART-V1-005 (HUD shell).

---

## 9. Dependencies and Next Steps

### This task depends on
- Joint NAC Signal Spec with @John (inline coordination, not a separate task)
- DEV-V1-005 will add `rewardChoices` — review and update if needed

### This task gates
- ART-V1-003 (card frame expansion) — NAC component must be finalized first
- ART-V1-005 (HUD shell) — NAC slot must be defined in the HUD layout
- DEV-V1-007 (UI integration) — engineering needs NAC spec to wire the component

### Coordination with @John
Once this document is finalized, share with @John so engineering can implement the NAC signal-to-display pipeline. The signal set is stable; the implementation concern is how to turn those signals into NAC text and state changes.

---

## 10. Acceptance Criteria

ART-V1-002 is complete when:
- NAC is visible in the run-state surface during active play
- all four states (active recommendation, neutral, no signal, locked) are visually distinct
- NAC text is in plain language — no engine jargon
- NAC follows Calm Diagnostic style (restrained, readable, not melodramatic)
- NAC survives stream/capture at reduced scale
- NAC does not crowd core state meters or encounter prompts
- a first-session player can tell their most useful next action from the NAC without debug or extra navigation
- QA-002-TC-21 can be cleared against the new run-state surface with NAC

---

## 11. Bottom Line

ART-V1-002 delivers a **Next-Action Cue component** that:
- sits in the run-state surface
- has four clear visual states
- uses plain-language text generated from engine signals
- follows Calm Diagnostic styling
- is readable at a glance for both players and spectators
- does not make the game feel scripted or hand-holding

That component then feeds into the HUD shell (ART-V1-005) and UI integration (DEV-V1-007).
