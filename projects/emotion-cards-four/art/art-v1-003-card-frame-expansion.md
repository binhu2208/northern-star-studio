# Emotion Cards Four — ART-V1-003: Card Frame Expansion + Portrait/Emotion Overlay System

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-V1-003
- **Purpose:** Expand the card frame system from the prototype baseline to cover the full v1 card pool, and build out the portrait/emotion overlay system designed in the prototype phase
- **Status:** Draft for v1 implementation
- **Related docs:**
  - `projects/emotion-cards-four/art/ui-component-system-requirements.md`
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/art/style-exploration-pass.md`
  - `projects/emotion-cards-four/gdd/des-v1-004a-card-balance-pass.md`

---

## 1. Purpose and Scope

ART-V1-003 covers two parallel workstreams:

### Workstream A: Card Frame Expansion
The prototype established 5 card frame families (Emotion, Memory, Reaction, Shift, Breakthrough) with a modular template system. ART-V1-003 expands that system to cover the full v1 card pool with:
- frame variants for new card types beyond the 27-card prototype
- state variant refinement for all frames
- data-driven layout implementation for v1 card content

### Workstream B: Portrait/Emotion Overlay System
The prototype specified the approach: **base portrait + modular overlays** for emotional state representation. ART-V1-003 builds that system out for v1 use:
- base portrait treatments for each encounter type
- emotional state overlay library
- integration with encounter HUD

Both workstreams follow the **Calm Diagnostic** style lane with **Soft Storybook warmth** borrowed for portraits and breakthrough moments.

---

## 2. Card Frame Expansion — v1 Scope

### 2.1 Current frame system (prototype baseline)

The prototype established:
- **5 frame families:** Emotion, Memory, Reaction, Shift, Breakthrough
- **1 shared modular template** with title zone, category marker, rules text, conditional/risk, icon row, illustration slot
- **7 state variants per frame:** default, focused, selected, disabled/illegal, resolving/locked, compact hand, enlarged
- **template-driven, data-populated layout** — text separate from art

### 2.2 v1 frame expansion requirements

The v1 card pool (per DES-V1-004a) currently has 15 cards in data.js across the 5 categories. The frame system must support:
- full v1 card content as defined in the design docs
- any new card types or categories introduced in v1
- card rarity or tier indicators if they emerge in v1
- functional state variants beyond the prototype set

### 2.3 Frame expansion rules

#### Family expansion
Each of the 5 families can produce sub-variants within the shared template:
- **Emotion sub-variants:** warmth intensity, openness level, vulnerability vs assertion cues
- **Memory sub-variants:** intimacy level, recency/urgency cues
- **Reaction sub-variants:** defensiveness level, speed/force of response
- **Shift sub-variants:** magnitude of reframing, direction of shift
- **Breakthrough sub-variants:** earned level, resolution quality

Sub-variants should remain within the family structure — they are not separate frames.

#### New frame considerations
If v1 introduces a new card category not in the prototype 5:
- it must go through the same frame family process
- it needs its own visual identity distinct from existing families
- it must share the core template structure

For v1, no new card categories are currently planned beyond the 5 prototype families.

#### State variant refinement
The 7 prototype state variants are sufficient for v1. Refinements:
- ensure all 7 states work cleanly at v1 art scale
- verify focused/selected/disabled states are visually distinct under stream compression
- confirm compact hand state remains readable at v1 hand size targets

### 2.4 Data-driven layout rules for v1

Following the prototype principle:
- all card text remains separate from frame art
- title, rules, conditional, and tags are data fields
- frame art provides the visual shell only
- v1 frames must tolerate wording changes without requiring art redraws

### 2.5 Frame expansion deliverables

For ART-V1-003, the frame work produces:
1. **Expanded frame family specifications** — detailed visual rules for each family including sub-variant treatment
2. **Frame implementation guide** — how to apply frames to new v1 card content
3. **State variant specification** — refined visual treatment for all 7 states per family
4. **v1 frame asset requirements** — list of new or modified frame assets needed beyond the prototype

---

## 3. Portrait / Emotion Overlay System — v1 Build-Out

### 3.1 Prototype approach (to be expanded)

The prototype specified:
- **3 encounter portraits** for the 3 sample encounters
- **3–4 emotional states per portrait** max
- **overlay-first implementation** — base portrait + modular overlays, not full redraws

For v1, this system needs to be built out for actual use.

### 3.2 Encounter portrait requirements

The v1 encounters (per DES-V1-003 verification) are:
- Missed Signal
- Public Embarrassment
- Quiet Repair
- (potentially 2 additional encounters to be defined in DES-V1-003)

For each encounter, a base portrait treatment is needed:
- character presence for the encounter counterpart
- consistent with the Calm Diagnostic + Soft Storybook warmth style
- clear emotional readability at encounter-scale size

### 3.3 Emotional state overlay library

Each encounter portrait needs an overlay system covering:
- **Base/neutral** — calm, receptive state
- **Guarded/resistant** — defensive, uncertain state
- **Vulnerable/open** — emotionally exposed state
- **Escalated/destabilized** — high-tension state

Additional states as needed by encounter logic:
- **Collapse-imminent** — near-collapse warning state
- **Breakthrough-ready** — breakthrough path open state

### 3.4 Overlay implementation approach

Use a **layered overlay system**:
- base portrait as the stable layer
- emotional state as an overlay treatment: tint, lighting shift, subtle pose change, or expression swap
- UI framing adds encounter context (response window state, tension level)

This keeps the portrait count manageable:
- 1 base portrait per encounter
- 4–6 overlay treatments per portrait
- total output: 3 encounters × 1 base + 4–6 states = 12–21 portrait assets

### 3.5 Portrait style rules

Following the style exploration:
- **Calm Diagnostic base** — restrained, clear, not melodramatic
- **Soft Storybook warmth** borrowed for emotional states — tender, not saccharine
- avoid overly dramatic or hyper-expressive portrait treatment
- keep portraits consistent with the card frame aesthetic
- ensure portraits read clearly at encounter HUD scale

### 3.6 Portrait/overlay deliverables

For ART-V1-003, the portrait work produces:
1. **Portrait base specifications** — one per v1 encounter with visual treatment rules
2. **Overlay state library** — 4–6 emotional states per portrait with visual treatment
3. **Encounter HUD integration notes** — how portraits slot into the v1 HUD shell
4. **Portrait asset requirements** — list of needed portrait/overlay assets

---

## 4. v1 Frame + Portrait — Consolidated Requirements

### 4.1 Frame family visual summary

| Family | Core Feel | Sub-variant Approach | Prototype Status |
|--------|----------|---------------------|-----------------|
| Emotion | soft rounded, expressive | warmth/openness intensity | prototype frame exists |
| Memory | inset archival, contextual | intimacy/urgency level | prototype frame exists |
| Reaction | angular active, tactical | defensiveness/speed | prototype frame exists |
| Shift | offset transitional | magnitude/direction of shift | prototype frame exists |
| Breakthrough | luminous resolved, payoff | earned level, resolution quality | prototype frame exists |

v1 work: refine sub-variant treatment and add implementation guide for new v1 card content.

### 4.2 Portrait system summary

| Encounter | Base Portrait | Emotional States | Overlay Approach |
|----------|-------------|-----------------|------------------|
| Missed Signal | needed | 4–6 states | tint/lighting + expression |
| Public Embarrassment | needed | 4–6 states | tint/lighting + expression |
| Quiet Repair | needed | 4–6 states | tint/lighting + expression |

### 4.3 Production rules

- portraits and frames must feel like one coherent visual system
- both must work within the Calm Diagnostic + Soft Storybook lane
- data-driven layout principle applies to both: text separate from art
- both must remain readable under stream compression and reduced scale

---

## 5. Dependencies and Next Steps

### ART-V1-003 depends on
- ART-002 (style exploration — done)
- ART-004 (component system requirements — done)
- DES-V1-003 (encounter template verification — done)

### ART-V1-003 gates
- ART-V1-004 (icon library expansion) — frame system must be finalized first
- ART-V1-005 (HUD shell) — portrait/HUD integration depends on both frame and portrait systems

### Coordination with DEV-V1-007
The frame and portrait systems feed into the v1 HUD shell (ART-V1-005) which is integrated by DEV-V1-007. Frame and portrait assets must be finalized before HUD shell integration begins.

---

## 6. Acceptance Criteria

ART-V1-003 is complete when:
- all 5 frame families have updated specifications for v1 card content including sub-variant treatment
- frame implementation guide exists for applying frames to new v1 cards
- 3 encounter portraits have base treatments defined
- 4–6 emotional overlay states are defined per portrait
- portrait/HUD integration notes are provided for ART-V1-005
- frame and portrait systems are visually coherent with the Calm Diagnostic + Soft Storybook lane
- all assets are specified as data-driven layouts where applicable
- frame and portrait systems are ready for ART-V1-004 (icons) and ART-V1-005 (HUD shell) to proceed

---

## 7. Bottom Line

ART-V1-003 delivers:
- an **expanded frame system** ready for the full v1 card pool
- a **built-out portrait/emotion overlay system** for v1 encounters
- both integrated into a coherent visual language following the Calm Diagnostic + Soft Storybook lane

These feed directly into ART-V1-004 (icons) and ART-V1-005 (HUD shell), which then gate DEV-V1-007 (UI integration).
