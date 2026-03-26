# Emotion Cards Four — ART-V1-005: HUD Shell + Tutorial / On-Ramp UI

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-V1-005
- **Purpose: Design the v1 HUD shell and first-session tutorial/on-ramp UI — slot definitions, layout rules, component placement, and implementation-facing specifications for the v1 encounter interface
- **Status:** Draft for v1 implementation
- **Related docs:**
  - `projects/emotion-cards-four/art/ui-component-system-requirements.md`
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/art/art-v1-002-nac-component.md`
  - `projects/emotion-cards-four/art/art-v1-003-card-frame-expansion.md`
  - `projects/emotion-cards-four/art/art-v1-004-icon-library-expansion.md`

---

## 1. Purpose and Scope

ART-V1-005 delivers the v1 HUD shell — the production encounter interface that hosts all other art components — and the first-session tutorial/on-ramp UI.

This is the final art gate before QA-V1-003 can execute.

### What this task delivers
1. **HUD shell specification** — layout, slots, safe-area, and component placement
2. **Component slot definitions** — where each component (NAC, state meters, cards, portraits, etc.) lives in the shell
3. **Tutorial/on-ramp UI** — first-session introduction screens and guidance states
4. **Implementation-facing spec** — engineering can build the HUD shell from this document

---

## 2. HUD Shell — Design Principles

### 2.1 Core shell principles

The v1 HUD shell is the production encounter interface. It must:
- host all v1 components cleanly (NAC, state meters, portraits, cards, turn summaries, result banners)
- remain readable under stream compression and reduced scale
- keep critical gameplay information inside the safe read zone
- follow the **Calm Diagnostic** visual lane with **Soft Storybook warmth** for portraits
- feel like one coherent visual system, not a collection of separate panels

### 2.2 Screen zones

The HUD shell is organized into five zones:

```
┌─────────────────────────────────────────────────────┐
│  TOP BAR: encounter name + phase + turn count       │
├─────────────────────────────────────────────────────┤
│                                                      │
│  LEFT PANEL:     │  CENTER:        │  RIGHT PANEL:  │
│  portrait +       │  encounter      │  state meters  │
│  emotional        │  prompt +       │  (Tension /    │
│  overlay          │  NAC +          │  Trust /       │
│  state           │  turn summary   │  Clarity /      │
│                  │                 │  Momentum)      │
├─────────────────────────────────────────────────────┤
│  BOTTOM: hand cards + focused card panel            │
└─────────────────────────────────────────────────────┘
```

### 2.3 Zone specifications

#### Top Bar
- **Content:** encounter name, current phase label, turn count
- **Height:** compact — ~40–50px
- **Position:** always visible, not scrollable
- **Style:** restrained, calm — minimal visual weight

#### Left Panel — Encounter Counterpart
- **Content:** base portrait + emotional overlay state
- **Size:** fixed slot, portrait fills the panel with padding
- **Position:** left third of encounter area
- **States:** base + 4–6 emotional overlay variants per encounter
- **Integration:** receives emotional state from engine via portrait/emotion overlay system (ART-V1-003)

#### Center — Encounter Core
- **Content:** encounter prompt, NAC, turn summary strip, reaction explanation, result banners
- **Priority order (top to bottom):**
  1. encounter prompt (always visible)
  2. NAC (ART-V1-002)
  3. turn summary strip
  4. reaction explanation
  5. result banners (when applicable)
- **Width:** flexible, fills center
- **Style:** clearest text hierarchy — encounter prompt is the dominant element

#### Right Panel — State Meters
- **Content:** Tension, Trust, Clarity, Momentum meters
- **Size:** fixed width, vertical stack
- **Position:** right third of encounter area
- **Meters:** icon + label + value indicator per stat
- **Style:** clear but not dominant — important, not attention-grabbing

#### Bottom — Player Area
- **Content:** hand cards + focused card panel
- **Position:** bottom of screen, always visible during play
- **Hand cards:** compact row, category recognizable at glance
- **Focused card panel:** enlarges on focus, shows full card details
- **Style:** stable, consistent — this is the player's primary interaction zone

---

## 3. Component Slot Definitions

### 3.1 Component placement

| Component | Zone | Priority | Visibility |
|-----------|------|----------|------------|
| Encounter prompt | Center-top | 1 | Always |
| NAC | Center | 2 | Always during play |
| Turn summary | Center | 3 | Post-resolution |
| Reaction explanation | Center | 4 | After encounter reaction |
| Result banner | Center | 5 | On result |
| Portrait + overlay | Left panel | 1 | Always during encounter |
| State meters | Right panel | 1 | Always |
| Hand cards | Bottom | 1 | Always during play |
| Focused card panel | Bottom overlay | 2 | On card focus |
| Top bar | Top | 1 | Always |

### 3.2 Safe-area rules

All critical gameplay elements (prompt, NAC, state meters, hand cards) must stay within:
- **80% width / 80% height** of the central gameplay safe zone
- outer 10% margins are decorative framing only
- no critical text or icons at screen edges

### 3.3 Layout constraints

- encounter prompt must be readable at a glance without scrolling
- NAC must be visible from default view without extra navigation
- state meters must be readable without entering a sub-screen
- hand cards must be scannable without enlarging
- focused card details must be readable without entering a nested menu

---

## 4. NAC Integration in HUD Shell

### 4.1 NAC placement

The NAC (ART-V1-002) slots into the **Center zone**, directly below the encounter prompt.

Required NAC slot behavior:
- visible during all active play phases
- persists across turns
- clearly subordinate to the encounter prompt
- clearly above the turn summary strip

### 4.2 NAC sizing

- NAC should occupy approximately **10–15% of the center zone height**
- text must be readable at reduced capture scale
- icon + text combination must remain legible at 16px equivalent font size

### 4.3 NAC states in HUD context

| State | Visual | HUD Behavior |
|-------|--------|-------------|
| Active recommendation | highlighted, visible | full opacity, elevated contrast |
| Neutral | subdued | baseline opacity |
| No signal | suppressed | minimal presence |
| Locked | distinct | visible but non-interactive |

---

## 5. Portrait Integration in HUD Shell

### 5.1 Portrait slot

The encounter counterpart portrait lives in the **Left panel**.

Slot specifications:
- **aspect ratio:** portrait (approximately 3:4)
- **position:** left panel, vertically centered in encounter area
- **size:** fills panel with ~8–12% horizontal padding
- **background:** subtle, non-distracting — does not compete with center content

### 5.2 Emotional overlay integration

Portrait receives emotional state from the engine:
- overlay state changes when encounter state changes
- transition should be subtle (fade or crossfade ~200–300ms)
- overlay does not require a full redraw — layer swap is sufficient

### 5.3 Encounter-specific portraits

Each v1 encounter gets its own base portrait:
- Missed Signal counterpart
- Public Embarrassment counterpart
- Quiet Repair counterpart

Portrait style: Calm Diagnostic base with Soft Storybook warmth. Each portrait should be recognizably the same character type across emotional states.

---

## 6. State Meter Integration in HUD Shell

### 6.1 Meter slot

State meters (Tension / Trust / Clarity / Momentum) live in the **Right panel**.

Slot specifications:
- **layout:** vertical stack, icon + label + meter bar per stat
- **width:** fixed ~60–80px
- **spacing:** consistent gap between meters
- **position:** right panel, vertically centered in encounter area

### 6.2 Meter appearance

Each meter shows:
- icon (from icon library — ART-V1-004)
- stat name label
- current value indicator (bar, number, or both)
- change indicator (delta up/down after resolution)

Style: restrained, clean — state meters should be readable but not visually dominant.

### 6.3 Meter behavior

- meters update on every state change
- change indicators flash briefly (~500ms) then fade
- meter bars should smoothly animate between values (not instant jump)
- critical thresholds (high tension, low trust) should be visually distinct

---

## 7. Tutorial / On-Ramp UI

### 7.1 Purpose

The tutorial/on-ramp UI introduces first-session players to the core loop before they encounter a live encounter.

### 7.2 On-ramp screen sequence

**Screen 1: Welcome / Game Introduction**
- game title and brief tone-setting
- one-line pitch: "read emotions, choose carefully, connect or collapse"
- continue / skip option

**Screen 2: Core Loop Introduction**
- shows the 3-encounter run structure simply
- encounter → play cards → resolve → next encounter
- continue / skip option

**Screen 3: Card Basics**
- shows the 5 card categories briefly (icon + one-line description each)
- shows card anatomy: title, category, effect, risk
- continue / skip option

**Screen 4: State Basics**
- shows the 4 encounter stats (Tension / Trust / Clarity / Momentum) with plain-language meaning
- shows breakthrough and collapse as the two poles
- continue / skip option

**Screen 5: Your First Encounter**
- brief instruction: "You'll start with 4 cards. Play one, then see how the encounter reacts."
- start button

### 7.3 Tutorial style rules

- tutorial screens use the same **Calm Diagnostic** visual language as the main HUD
- text is short and plain-language
- visuals use the card frame system and icon library already designed
- no animation that blocks player understanding
- player can skip any screen

### 7.4 In-game tutorial hints (post-on-ramp)

During the first encounter, brief contextual hints may appear:
- appears near the relevant UI element
- auto-dismisses after ~5 seconds
- only appears on first relevant encounter state, not repeatedly
- clearly marked as hint, not game instruction

Hint triggers:
- first time a response window opens: "this shows what the encounter needs"
- first time a card is played: "you played [card] — see what changed"
- first time a reaction happens: "the encounter reacted because..."

### 7.5 Tutorial/on-ramp deliverables

For ART-V1-005, the tutorial work produces:
1. **On-ramp screen specifications** — layout, text, visuals, and flow for screens 1–5
2. **In-game hint system** — trigger conditions, appearance, dismissal rules
3. **Tutorial styling** — consistent with Calm Diagnostic HUD shell
4. **Implementation notes** — how engineering wires tutorial flow

---

## 8. Top Bar Specification

### 8.1 Top bar content

- **Encounter name** — e.g. "Missed Signal" — left-aligned
- **Phase label** — e.g. "Your Turn" or "Resolving" — centered
- **Turn count** — e.g. "Turn 3" — right-aligned

### 8.2 Top bar styling

- **height:** ~40–50px
- **background:** subtle, low-contrast — does not draw attention
- **text:** small, readable — 12–14px equivalent
- **style:** minimal, informational — this is not a prominent UI element

### 8.3 Top bar behavior

- encounter name changes between encounters
- phase label updates per phase transition
- turn count increments per turn

---

## 9. Bottom Player Area Specification

### 9.1 Hand card row

- **position:** bottom of screen, horizontal row
- **card size:** compact (in-hand size ~160–220px width)
- **category visible at glance:** frame color, category icon
- **selected state:** highlight on selected card
- **focus behavior:** clicking a card focuses it in the panel above

### 9.2 Focused card panel

- **position:** appears above hand row when a card is focused
- **size:** enlarged (focused size ~280–360px width)
- **content:** full card details — title, category, effect, conditional, icon row
- **text:** fully readable without further interaction
- **style:** clean, elevated — clear that this is the active selection

### 9.3 Play area

- **primary card slot:** where the selected primary card is shown
- **support card slot:** where the optional support card is shown
- **confirm button:** "Play" / "Confirm" — appears when a legal package is selected
- **cancel/clear:** resets selection

---

## 10. Visual Consistency Rules

### 10.1 Style alignment

All HUD elements must follow the **Calm Diagnostic** visual lane:
- restrained color palette
- clean typography hierarchy
- minimal decorative elements
- readable first, attractive second

### 10.2 Typography hierarchy

| Element | Font | Size | Weight |
|---------|------|------|--------|
| Encounter prompt | Inter Tight | large (~20–24px) | bold |
| NAC text | Inter Tight / Atkinson Hyperlegible | medium (~14–16px) | regular |
| Stat labels | Inter Tight | small (~12px) | medium |
| Card titles | Inter Tight | medium (~14–16px) | bold |
| Card body | Atkinson Hyperlegible | small (~12px) | regular |
| Top bar labels | Inter Tight | small (~11–12px) | regular |

### 10.3 Color usage

- **category accents:** per-frame family colors (subdued, not saturated)
- **stat meters:** neutral base with stat-specific accent for highlights only
- **result banners:** distinct per result type — Breakthrough (uplifted), Collapse (compressed/warning)
- **NAC active:** subtle highlight accent — not dominant
- **no aggressive color pops anywhere in the HUD**

### 10.4 Spacing and rhythm

- consistent padding unit (base unit ~8px)
- encounter area has generous internal padding
- hand card row is tight and functional
- top bar is minimal, compact
- components do not crowd each other

---

## 11. Implementation-Facing Specifications

### 11.1 HUD shell structure

Engineering should build the HUD as a modular shell:
- each zone is a container with defined slots
- components are injected into their slots
- shell handles layout, spacing, and safe-area enforcement
- components handle their own internal rendering

### 11.2 Component interface requirements

Each component slot requires:
- defined dimensions (width, height, position)
- data inputs it consumes
- events it emits
- state variants it supports

### 11.3 Responsive / scaling behavior

- HUD should scale to fit the viewport while maintaining safe-area
- minimum supported width: ~800px equivalent
- below minimum: graceful degradation (smaller fonts, tighter spacing)
- hand cards scroll horizontally if hand size exceeds visible area

### 11.4 Accessibility

- all text has sufficient contrast (WCAG AA minimum)
- interactive elements are keyboard-accessible
- screen reader labels on all icon-only elements
- color is not the only indicator of meaning

---

## 12. Dependencies and Next Steps

### ART-V1-005 depends on
- ART-V1-002 (NAC component — done)
- ART-V1-003 (portrait/frame system — done)
- ART-V1-004 (icon library — done)

### ART-V1-005 gates
- DEV-V1-007 (UI integration) — engineering builds the HUD shell from this spec

### Coordination with DEV-V1-007

Engineering needs this document to:
- build the HUD shell layout
- wire component slots to data/state
- implement the tutorial flow
- handle responsive/scaling behavior

---

## 13. Acceptance Criteria

ART-V1-005 is complete when:
- HUD shell layout has all 5 zones with defined slots and positions
- all component slots are specified with dimensions and behavior
- NAC integration is defined with sizing and state behavior
- portrait slot is defined with emotional overlay integration
- state meter slot is defined with appearance and behavior
- top bar is specified with content and styling
- bottom player area is specified (hand cards + focused panel + play area)
- tutorial/on-ramp screens are fully specified (5 screens + in-game hints)
- visual consistency rules are documented (typography, color, spacing)
- implementation-facing specs cover shell structure, component interfaces, responsive behavior, and accessibility
- engineering can build the full v1 HUD from this document

---

## 14. Bottom Line

ART-V1-005 delivers the **production HUD shell** — the v1 encounter interface that hosts all art components (NAC, portraits, frames, icons, meters, cards) — and the **first-session tutorial/on-ramp UI**.

Together with the component specifications from ART-V1-002/003/004, this gives engineering everything needed to build the v1 UI in DEV-V1-007.

Once this lands, the full art lane is complete and QA-V1-003 can execute.
