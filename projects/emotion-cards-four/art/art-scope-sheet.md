# Emotion Cards Four — Art Scope Sheet

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-001
- **Purpose:** Define a prototype-focused art scope basis for planning, estimation, and downstream UI/readability work
- **Status:** Draft for active production use
- **Related docs:**
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
  - `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
  - `projects/emotion-cards-four/src/prototype-architecture-baseline.md`
  - `projects/emotion-cards-four/project-plan.md`

---

## 1. Scope Intent

This prototype should prove **readability, emotional legibility, and spectator clarity** before it proves premium illustration value or large-scale content production.

Art scope should therefore prioritize:
- clear card category recognition,
- readable state feedback,
- strong UI hierarchy,
- lightweight encounter presentation,
- reusable systems over bespoke one-off assets.

Working assumption: the first playable slice is a **3-encounter, 24-card core prototype + 3 breakthrough cards** with deterministic systems and restrained VFX.

---

## 2. Art Pillars

### A. Readable in one turn
A new player should understand:
- what card category they are looking at,
- what is currently happening in the encounter,
- what changed after a play,
- whether the situation is improving or worsening.

### B. Emotionally legible, not over-rendered
Prototype visuals should communicate tone and function quickly. This phase does **not** need final collectible-card illustration density.

### C. Template-first production
The first art pass should be built from reusable systems:
- shared card frames,
- shared icon sets,
- shared state meters,
- shared UI panels,
- limited effect overlays,
- minimal encounter scene dressing.

### D. Safe for tuning
Because card wording, thresholds, and encounter logic are still moving, art should avoid expensive bespoke work that becomes invalid when design shifts.

---

## 3. Card Scope Assumptions

### Prototype card volume
Scope assumes **27 total card definitions** for the first playable slice:
- **24 core cards** across active hand/deck play
  - 7 Emotion
  - 6 Memory
  - 7 Reaction
  - 4 Shift
- **3 Breakthrough cards** used as earned/unlocked outcome moments rather than normal hand fillers

Prototype run size is intentionally narrow — **3 encounters** and a starter deck around **12 cards** — but art planning should still assume the **full 27-card content set** exists in data and UI.

### Unique art count assumption
Do **not** scope 27 bespoke illustrations for prototype planning.

Baseline assumption is a **template-driven card system** with:
- one shared layout system,
- category-led color coding,
- iconography,
- typography hierarchy,
- one focal illustration slot per card face.

Working art assumption:
- **27 designed card fronts** need finalized names, text styling, category treatment, and state-aware presentation.
- **Bespoke illustration need** should stay selective rather than universal.

Use shared motifs, abstract/emotive spot art, and reused visual language wherever possible.

### Template vs bespoke split
Prototype documents strongly point toward **template-first production**.

Recommended assumption:
- template-driven for the majority of the set,
- bespoke treatment only where it materially improves readability or showcase value.

Most likely bespoke priorities:
- key exemplar cards used in demos/playtest capture,
- breakthrough cards,
- maybe 1–2 anchor cards per major category if needed for visual variety.

### Frame families
Assume **5 frame families**, one per card category:
1. Emotion
2. Memory
3. Reaction
4. Shift
5. Breakthrough

Each family should share a common system but read as distinct through:
- frame styling,
- category color banding,
- icon placement,
- label treatment,
- support-slot/readability cues.

Prototype art should prioritize **instant category recognition** over decorative complexity.

### Icon / graphic asset needs
At minimum, prototype card/UI support will need a reusable icon set for:
- **5 card categories**
- **4 encounter stats**
  - Tension
  - Trust
  - Clarity
  - Momentum
- support icons for:
  - response windows / open-closed state
  - keyword or tag markers
  - risk / warning cues
  - breakthrough unlock / conditional state
  - result-state signaling

Because the system is rules-readable and debug-heavy, icon language should be treated as a **core UX asset dependency**, not polish.

### Card variant strategy
Prototype should assume **no rarity variants, foil variants, or alternate-art branches**.

Variants should be limited to **functional state/UI variants** such as:
- normal card face,
- disabled / illegal play state,
- selected / hovered state,
- unlocked breakthrough presentation,
- compact in-hand vs enlarged read state.

If scope pressure hits, preserve in this order:
1. category readability,
2. frame consistency,
3. icon clarity,
4. gameplay-state variants,
5. bespoke hero treatment.

### Bottom-line card assumption
Plan the prototype as a **27-card visual system**, not a 27-illustration art set.

Scope around:
- **5 category frame families**,
- **1 cohesive template system**,
- **core icon library**,
- **game-state presentation variants**,
- **limited bespoke hero treatment only where needed**.

---

## 4. Portrait Scope Assumptions

### Encounter portrait count
Assume **3 encounter portraits for the first playable slice**, matching the prototype run structure of **3 sequential encounters**.

For ART-001 planning, treat this as **3 core encounter-facing portrait assets**, not a broad cast roster.

### Emotional state count
For prototype-safe art scope, **do not assume bespoke full redraws for every card, keyword, or logic state**.

Safe planning assumption:
- **1 base portrait per encounter**
- **3–4 emotional presentation states per portrait** max:
  - neutral / baseline
  - guarded / tense
  - vulnerable / open
  - collapse or breakthrough extreme

### Recommended approach: overlay vs redraw
Use a **base portrait + modular overlays/swaps** rather than full bespoke redraw sets.

Best-fit implementation approach:
- one stable base portrait per encounter,
- emotion change conveyed through:
  - facial overlay variants,
  - eye/mouth swaps,
  - tint/lighting shifts,
  - simple pose-crop changes,
  - UI framing and state FX.

Full redraws should be reserved only if testing proves overlays are not emotionally legible enough.

### Explicitly out of scope
ART-001 should **not** assume:
- a unique portrait for every card in the 24-card prototype set,
- bespoke portrait art for every hidden numeric state combination,
- campaign-scale cast coverage,
- multiplayer-facing portrait variants,
- procedural/generated portrait variations,
- heavy animation pipelines,
- cinematic reaction sequences,
- broad narrative branching portrait continuity.

### Bottom-line portrait assumption
For this phase, the safest scope is:
- **3 encounter portraits**,
- **limited expression coverage**,
- **overlay-first implementation**,
- **no full redraw matrix for all emotional/game states**.

---

## 5. UI / Readability Targets

### Card layout hierarchy
Use a template-driven card frame system with **strong category recognition first**: Emotion, Memory, Reaction, Shift, and Breakthrough should read instantly through layout, color grouping, and icon language before players parse full text.

Each card should prioritize one main intent visually:
1. Name
2. Category / icon
3. Primary effect
4. Conditional / risk
5. Illustration slot

Prototype cards should avoid overloaded layouts. Docs consistently support **one primary state effect plus at most one conditional bonus**.

Breakthrough cards should feel visually distinct as **earned payoff states**, not normal hand cards.

### Encounter HUD requirements
The encounter HUD needs to make the loop readable for both players and observers. At minimum it should expose:
- current encounter prompt,
- readable labels for **Tension / Trust / Clarity / Momentum**,
- current response windows (open / closed / blocked),
- a clear **what changed this turn** readout after play resolution,
- plain-language reaction/explanation text for why the encounter pushed back,
- a visible hint for whether **Breakthrough is possible, opening, or blocked**.

Hidden numeric logic can exist underneath, but the prototype must not feel like invisible math.

### Safe-area / screen composition guidance
- Keep all critical HUD data inside a conservative **safe title area**.
- Assume the prototype may be watched on streams, recordings, or smaller displays.
- Avoid placing essential text at extreme screen edges.
- Reserve a stable center/read zone for:
  - active encounter prompt,
  - current card play area,
  - immediate result feedback.
- Peripheral zones can support secondary context, but **no critical state explanation should live only in corners**.

### Text density targets
- Card copy should stay short enough that players can identify purpose **at a glance** on first session.
- Keywords must be limited, repeated consistently, and reused across cards.
- Outcome states should stay in plain language: **Breakthrough, Partial Resolution, Stalemate, Collapse**.
- Avoid dense rules text blocks.

Cards need to communicate:
- what the card is trying to do,
- what state it affects,
- what can go wrong if misplayed.

### Spectator readability targets
The mode is explicitly intended to be socially watchable, so UI must support observers being able to tell:
- what the situation is,
- what the player attempted,
- how the encounter reacted,
- why the result happened.

To support that:
- state changes need immediate visual before/after feedback,
- support cards must visibly show that they mattered,
- opposition reactions cannot happen off-screen or without explanation,
- result-state transitions should be announced with clear readable labels.

### Reusable UI component needs
For prototype efficiency, ART should scope reusable components rather than bespoke screens:
- shared card frame system with category variants,
- state meter / label components for Tension, Trust, Clarity, Momentum,
- response-window badge/chip system,
- turn change summary panel,
- reaction/explanation callout,
- result-state banner set,
- keyword/tag treatment reusable across cards and encounter UI,
- single illustration slot pattern per card.

---

## 6. Shared VFX / Feedback Kit Scope

### VFX scope constraints
Keep VFX **minimal and state-explanatory**, not spectacle-driven. The prototype explicitly keeps **heavy animation/VFX pipelines out of scope**.

Prioritize readability feedback for:
- card play confirmation,
- stat/state change feedback,
- response-window open/close states,
- breakthrough / collapse readiness,
- encounter reaction cause/effect.

### Reusable effect library
Use a **small reusable effect library** instead of bespoke card VFX:
- positive state pulse,
- negative state pulse,
- clarity/reveal accent,
- tension spike,
- trust gain/loss accent,
- breakthrough unlock flash,
- collapse warning,
- final result cue set.

Any motion should support **why that happened** readability for players and observers, not cinematic polish.

### Explicitly out of scope
Do **not** budget for:
- per-card authored VFX,
- full-screen cinematic transitions,
- particle-rich emotion spells,
- animated backgrounds,
- character-performance VFX systems,
- heavy post-processing pipelines.

### VFX recommendation
Budget VFX as a **shared feedback kit**, not as content-per-card work.

If schedule tightens, cut bespoke effect polish before cutting readability signals.

---

## 7. Localization / Data-Driven Layout Constraints

### Localization assumptions
Prototype should assume **content-safe string boundaries only**, matching the current architecture direction.

Art/UI should avoid embedding key gameplay text in raster graphics where possible:
- card category labels,
- keywords,
- outcome states,
- state labels,
- reaction/explanation text.

### Layout constraints for localization safety
- keep text separate from art,
- use flexible text containers,
- leave room for text expansion,
- avoid tightly cropped text boxes on card frames,
- keep result-state visual identity supported by icon/color, not only wording,
- avoid text-dependent VFX or timing-sensitive animated typography.

### Card-specific rule
Because cards contain design text that may be revised often, treat card faces as **data-populated layouts**, not flattened final composites.

That means:
- frame art separate from text,
- scalable title area,
- forgiving body-text area,
- reusable language-independent icons where possible.

### Bottom-line localization recommendation
Localization readiness here means **structure readiness**:
- text separated from art,
- flexible containers,
- icon-supported meaning,
- no language-locked motion graphics.

---

## 8. Production Assumptions and Reusable Systems

### Production assumptions
This is a prototype validation phase, so production should assume:
- card balance/content will change,
- encounter UI wording will change,
- state labels and thresholds may change,
- some categories may gain or lose cards,
- breakthrough presentation may still move between hidden / earned / visible states.

Art production must therefore be resilient to iteration.

### Reusable systems to build first
#### System 1: Card frame family
A modular frame system for all five card categories with shared structure and category-specific identity.

#### System 2: Icon library
A compact icon set for:
- categories,
- state stats,
- keywords/response windows,
- positive/negative deltas,
- breakthrough/collapse/result states.

#### System 3: Encounter HUD
One reusable encounter-state presentation module for:
- prompt,
- stat displays,
- response windows,
- change summaries,
- reaction explanation panel.

#### System 4: Portrait/emotion overlay kit
A lightweight portrait treatment system with reusable mood states rather than bespoke portrait redraws.

#### System 5: Feedback motion kit
A small shared animation/VFX package for card confirmation and state changes.

### Recommended production order
1. visual direction board for prototype readability,
2. wireframe + hierarchy pass for encounter HUD and card face,
3. card frame system,
4. iconography/state language,
5. encounter presentation shell,
6. portrait/overlay treatment if needed,
7. lightweight motion/VFX feedback pass,
8. polish pass after live prototype testing.

### Reuse strategy recommendation
If there is any temptation to commission 20+ unique card illustrations before the loop is proven, push back. This phase supports **systemic readability**, not collectible-art scale.

---

## 9. Estimated Prototype Asset Breakdown

This is an estimate-oriented planning table, not a final lock.

| Asset Group | Estimated Unique Count | Notes |
|---|---:|---|
| Card frame templates | 5 | One per category |
| Card face variants | 27 | Mostly layout/data variants |
| Bespoke illustration motifs | 4–6 | Reusable emotional/key-art motifs |
| Category icons | 5–8 | Category + support symbols |
| State/status icons | 10–16 | Tension/Trust/Clarity/Momentum + response/result indicators |
| Encounter portraits | 3 | One base portrait per encounter |
| Portrait state variants | 9–12 | 3–4 states each if done as outputs; fewer if overlay-driven |
| Encounter backdrop/panel treatments | 3 | One per sample encounter, can be lightweight |
| Result-state banners | 4 | Breakthrough / Partial / Stalemate / Collapse |
| Shared VFX feedback motifs | 6–8 | Reusable cues only |

These numbers should be treated as **prototype planning assumptions**, not production promises.

---

## 10. Risks

Main art risks:
1. **Overscoping bespoke polish** before readability is proven
2. **UI clutter** caused by too many visible systems with weak hierarchy
3. **Text baked into art**, slowing iteration and localization
4. **Overly subtle feedback**, making outcomes feel arbitrary
5. **Per-card visual uniqueness pressure**, which conflicts with the template-driven prototype strategy
6. **Overdramatic VFX**, making the tone feel awkward or melodramatic

---

## 11. Recommendations

### Core recommendation
Estimate ART-001 using a **UI/readability-first prototype package**, not a collectible-card final-art package.

### Downstream recommendation for ART-003
ART-003 should assume this document as the scope baseline and focus on:
- card size and hierarchy,
- text density,
- hand readability,
- state feedback legibility,
- safe areas,
- spectator readability under real prototype conditions.

### Final production read
Best prototype art target:
- **clean**,
- **emotionally legible**,
- **stream-readable**,
- **easy to iterate**.

If the prototype proves fun and understandable, production can expand from there. If it does not, keeping scope disciplined here prevents expensive art waste.

---

## 12. Bottom Line

For ART-001, the right estimate basis is:
- a **27-card visual system**,
- **3 encounter portraits** with limited state variation,
- **UI-first readability work**,
- a **small shared VFX/feedback kit**,
- **data-driven, localization-safe layouts**,
- and a strong bias toward **reusable systems over bespoke art volume**.

That is enough to support prototype planning, unblock ART-003, and keep the project honest about where the real art load actually lives.
