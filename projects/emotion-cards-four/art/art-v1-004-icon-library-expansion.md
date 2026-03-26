# Emotion Cards Four — ART-V1-004: Icon Library Expansion

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-V1-004
- **Purpose:** Expand the prototype icon system to cover all v1 keyword, encounter state, and UI signal needs — new icons, updated categories, and implementation-facing specifications
- **Status:** Draft for v1 implementation
- **Related docs:**
  - `projects/emotion-cards-four/art/ui-component-system-requirements.md`
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/art/style-exploration-pass.md`
  - `projects/emotion-cards-four/art/art-v1-002-nac-component.md`
  - `projects/emotion-cards-four/art/art-v1-003-card-frame-expansion.md`

---

## 1. Current Icon System (Prototype Baseline)

The prototype established:
- **5 card category icons:** Emotion, Memory, Reaction, Shift, Breakthrough
- **4 core state icons:** Tension, Trust, Clarity, Momentum
- **11 response/system icons:** response window states, deltas, selected/disabled, breakthrough/collapse signals
- **style:** shape-first, thick strokes, simple silhouettes, monochrome-readable, reusable across cards and HUD

Prototype icons are documented in `art/ui-component-system-requirements.md` and referenced in the style exploration pass.

---

## 2. v1 Icon Expansion Scope

### 2.1 What needs to expand

The prototype icon system was designed for a 27-card prototype. v1 introduces:

**New keyword / encounter state icons**
v1 adds encounter keywords, condition types, and state signals not in the prototype:
- additional encounter result states
- new condition/requirement signals beyond the prototype vocabulary
- carry-forward and reward choice indicators
- expanded turn/phase state signals

**NAC-specific icons**
The Next-Action Cue (ART-V1-002) needs its own icon support:
- action recommendation icons (contextual directional cues)
- state-change indicators for NAC display
- signal-to-text mapping icons

**Expanded system icons**
Additional UI states and signals for the v1 HUD shell:
- tutorial/on-ramp state indicators
- session/route markers
- choice confirmation signals

### 2.2 Expansion principles

Following the prototype rules:
- **shape-first** — meaning survives silhouette
- **thick strokes** — survives compression
- **monochrome-readable** — works without color
- **reusable across cards and HUD** — one icon, many uses
- **semantic shape mapping** — trust is rounded, tension is sharp, etc.

### 2.3 What NOT to add

The expansion should not create:
- bespoke icons for single-use moments
- decorative icons that carry no system meaning
- one-off encounter-specific badges
- icons that require color to read

---

## 3. New Icon Categories for v1

### 3.1 Encounter State Icons

Additional icons for encounter and run-level state:

#### Result-state icons
- **Breakthrough** — already in prototype (keep)
- **Partial Resolution** — new: distinct from breakthrough
- **Stalemate** — new: distinct from partial resolution
- **Collapse** — already in prototype (keep)

These must be visually distinct from each other and from progress/action icons.

#### Carry-forward / reward icons
- **Pending reward** — indicates a carry-forward reward is available
- **Reward claimed** — indicates reward has been taken
- **Carry-forward effect active** — indicates a stored effect from a prior encounter

#### Turn / phase icons
- **Turn count marker** — indicates which turn of the encounter
- **Phase indicator** — compact icon for current phase state

### 3.2 Condition / Keyword Icons

New icons for v1 card conditions and keywords beyond the prototype vocabulary:

#### Condition-type icons
- **stat threshold** — represents a numeric stat check (tension >= X, trust <= Y, etc.)
- **window-type** — represents a response window requirement
- **encounter-type** — represents an encounter-specific condition
- **result-type** — represents a resolution-state requirement
- **state-flag** — represents a boolean state check (collapseArmed, breakthroughReady)

#### Keyword support icons
v1 cards may introduce new keywords beyond the prototype set. The icon system should define a flexible keyword icon approach:
- **generic keyword badge** — reusable container for new keywords
- **specific keyword icons** — created as new keywords are locked in design

### 3.3 NAC-Specific Icons

The NAC component (ART-V1-002) needs its own icon vocabulary:

#### Action recommendation icons
- **suggested action** — indicates NAC is recommending an action
- **suggested card type** — indicates which card type NAC is recommending (uses category icons)
- **priority indicator** — indicates NAC recommendation strength

#### NAC state icons
- **active recommendation** — NAC is surfacing a specific recommendation
- **neutral** — NAC is present but no specific recommendation
- **no signal** — NAC is suppressed
- **locked/waiting** — NAC is in locked state

### 3.4 Tutorial / On-ramp Icons

For the tutorial UI (ART-V1-005):
- **hint marker** — indicates a tutorial hint is available
- **step progress** — indicates tutorial step progress
- **skip available** — indicates tutorial can be skipped
- **learn more** — indicates additional context available

---

## 4. Icon Style Specifications

### 4.1 Core style rules (from prototype, still apply)

All v1 icons must follow:
- simple silhouettes first
- thick, clean strokes
- minimal internal detail
- no fragile linework, filigree, or texture noise
- color supports meaning but does not carry it alone
- monochrome-legible before color
- one stroke logic across the set
- one silhouette discipline across the set

### 4.2 Shape mapping (prototype, still applies)

| Concept | Shape Language |
|---------|--------------|
| Trust | open, rounded, receptive |
| Tension | compressed, sharper, pressured |
| Clarity | symmetrical, lens-like, clean |
| Momentum | directional, forward-driving |
| Emotion | softer, organic |
| Memory | framed, inset, container |
| Reaction | firmer, angular, active |
| Shift | offset, transitional |
| Breakthrough | uplifted, radiant, resolved |

### 4.3 New shape mappings for v1 icons

| Concept | Shape Language |
|---------|--------------|
| Partial Resolution | contained, moderate, settled |
| Stalemate | blocked, static, no-forward |
| Reward available | open, positive, incoming |
| Reward claimed | closed, checked, confirmed |
| Carry-forward active | layered, forwarding |
| Turn count | sequential marks, tick-based |
| Phase indicator | state-circle, cycle indication |
| Condition: threshold | bracket + value indicator |
| Condition: window | arch, opening |
| Condition: state-flag | toggle, binary marker |
| Tutorial hint | bulb, question-dot |
| Tutorial skip | chevron, bypass marker |

### 4.4 Sizing and stroke rules

Following prototype standards:
- base icon grid: 24×24 px minimum
- stroke weight: 2px minimum for legibility at small sizes
- internal detail threshold: if it disappears at 16×16, it is too detailed
- all icons must hold meaning at 12×12 px thumbnail size

### 4.5 Color use for v1 icons

Prototype rule: color supports meaning, does not carry it.

v1 extension:
- icons may use category accent colors when placed on cards or HUD
- icons must remain readable in monochrome (grayscale) before color is applied
- critical state icons (collapse, breakthrough) should be readable in monochrome

---

## 5. Icon Production Guidelines

### 5.1 Icon set structure

Organize v1 icons by group:

```
icons/
  categories/       # card category icons (prototype — existing)
  states/          # Tension, Trust, Clarity, Momentum (prototype — existing)
  system/          # response windows, deltas (prototype — existing)
  results/         # breakthrough, partial, stalemate, collapse (new)
  conditions/      # threshold, window, state-flag, result-type (new)
  carryforward/    # reward, effect, pending (new)
  nac/             # NAC-specific icons (new)
  tutorial/       # hint, skip, progress (new)
  ui/              # general UI state icons (new)
```

### 5.2 Icon naming conventions

Follow the prototype naming pattern:
- lowercase with underscores
- semantic names: `trust_up.svg`, `tension_spike.svg`, `breakthrough_ready.svg`
- state suffixes: `_active`, `_inactive`, `_warning`

### 5.3 Delivery format

For the spec document:
- list each icon with name, concept, shape description, and intended use
- note which icons are new vs prototype-existing
- note any that need variants (active/inactive, small/medium)

For implementation:
- SVG preferred for all icons (scalable, monochrome-safe)
- each icon as a separate file
- consistent viewBox (24×24 recommended)

---

## 6. v1 Icon Inventory

### 6.1 Prototype icons (retain)

**Category icons** — retain as-is:
- `emotion.svg`
- `memory.svg`
- `reaction.svg`
- `shift.svg`
- `breakthrough.svg`

**State icons** — retain as-is:
- `tension.svg`
- `trust.svg`
- `clarity.svg`
- `momentum.svg`

**System icons** — retain as-is:
- `window_open.svg`
- `window_closed.svg`
- `window_blocked.svg`
- `risk.svg`
- `delta_positive.svg`
- `delta_negative.svg`
- `selected.svg`
- `disabled.svg`
- `breakthrough_available.svg`
- `breakthrough_blocked.svg`
- `collapse_warning.svg`

### 6.2 New icons for v1

**Result state icons (4 new):**
- `result_breakthrough.svg` — breakthrough result (update if needed)
- `result_partial.svg` — partial resolution result
- `result_stalemate.svg` — stalemate result
- `result_collapse.svg` — collapse result (update if needed)

**Carry-forward / reward icons (3 new):**
- `reward_pending.svg` — carry-forward reward available
- `reward_claimed.svg` — reward taken
- `carryforward_active.svg` — stored effect active

**Condition icons (5 new):**
- `condition_threshold.svg` — numeric stat check
- `condition_window.svg` — response window requirement
- `condition_stateflag.svg` — boolean state check
- `condition_encounter.svg` — encounter-specific condition
- `condition_result.svg` — result-state condition

**Turn / phase icons (2 new):**
- `turn_marker.svg` — turn count indicator
- `phase_state.svg` — current phase indicator

**NAC icons (4 new):**
- `nac_active.svg` — NAC in active recommendation state
- `nac_neutral.svg` — NAC in neutral/no-recommendation state
- `nac_none.svg` — NAC suppressed
- `nac_locked.svg` — NAC locked / waiting

**Tutorial icons (4 new):**
- `hint_marker.svg` — tutorial hint available
- `tutorial_skip.svg` — tutorial skip available
- `tutorial_progress.svg` — tutorial step progress
- `learn_more.svg` — additional context available

**UI state icons (3 new):**
- `session_marker.svg` — session or route indicator
- `choice_confirm.svg` — choice confirmation signal
- `choice_cancel.svg` — choice cancellation signal

### 6.3 Total v1 icon count

| Group | Existing | New | Total |
|-------|----------|-----|-------|
| Categories | 5 | 0 | 5 |
| States | 4 | 0 | 4 |
| System | 11 | 0 | 11 |
| Results | 0 | 4 | 4 |
| Carry-forward | 0 | 3 | 3 |
| Conditions | 0 | 5 | 5 |
| Turn/Phase | 0 | 2 | 2 |
| NAC | 0 | 4 | 4 |
| Tutorial | 0 | 4 | 4 |
| UI states | 0 | 3 | 3 |
| **Total** | **20** | **29** | **49** |

---

## 7. Icon Implementation Rules

### 7.1 Data-driven icon mapping

Icon usage should be driven by data, not hardcoded into art assets:
- icon references in card data
- icon references in encounter state data
- icon references in NAC signal data
- UI state icons referenced in component state

### 7.2 Icon variant rules

Some icons need variants (active/inactive, highlighted/dimmed). Handle via:
- CSS class / state modifier on the icon container
- not separate icon files for state variants
- exceptions: if shape changes significantly between states, separate files OK

### 7.3 Icon accessibility

- all icons used in UI must have accessible text equivalents
- icons used as only视觉 indicators must have `aria-label` or equivalent
- icon color should not be the only differentiator for meaning

---

## 8. Dependencies and Next Steps

### ART-V1-004 depends on
- ART-004 (icon system — prototype existing)
- ART-V1-002 (NAC component — done)
- ART-V1-003 (card frame expansion — done)

### ART-V1-004 feeds into
- ART-V1-005 (HUD shell + tutorial UI)
- DEV-V1-007 (UI integration)

### Coordination with DEV-V1-007
Engineering needs the icon list and semantic mappings to wire icons to game state. This document provides that specification — DEV can implement icon rendering once the icon set is finalized.

---

## 9. Acceptance Criteria

ART-V1-004 is complete when:
- all 29 new v1 icons are specified with name, concept, shape description, and intended use
- existing prototype icons are confirmed as retained without modification
- icon set is organized by group with clear naming conventions
- semantic shape mapping covers all new icon types
- icon implementation rules are documented (data-driven, variants, accessibility)
- icon inventory table is complete and ready for asset creation
- specification feeds cleanly into ART-V1-005 (HUD shell) and DEV-V1-007 (UI integration)

---

## 10. Bottom Line

ART-V1-004 delivers an expanded icon library covering all v1 needs:
- **29 new icons** across result states, carry-forward, conditions, turn/phase, NAC, tutorial, and UI
- **20 prototype icons** confirmed as retained
- **49 total icons** in a clean organized structure
- all following the shape-first, monochrome-readable, thick-stroke style of the prototype

The icon system then feeds into the HUD shell (ART-V1-005) and UI integration (DEV-V1-007).
