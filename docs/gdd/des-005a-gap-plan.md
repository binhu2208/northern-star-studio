# DES-005A — GDD Gap-to-Deliverable Plan

## Current state snapshot

The current `docs/gdd/` set contains strong exploratory design material, but it is not yet a shippable final GDD package.

What exists now:
- **Core foundation exists**
  - `emotion-cards-core-mechanics.md` defines concept, card families, run loop, and high-level pillars.
  - `character-arc.md` provides Maya's full run/endings structure.
- **Roster design exists, but unevenly**
  - Wren, Tide, and Frost each have standalone character design docs.
  - Ember is split across `des-002-character-expansion.md`, `ember-phase3-4-cards.md`, and `ember-phase5-6-cards.md`.
  - Bloom is selected as Character 06 in `des-003-wrapup.md`, but only has concept-level treatment in `character-06-concept-a.md`.
- **Combat/content support exists at scaffolding level**
  - `des-001c-enemy-types.md` covers only 2 enemy concepts.
  - `encounter-content-pipeline.md` documents content-loading scaffolding, not a final encounter design spec.
- **Related but non-final-GDD support docs exist**
  - `platform-portability-prep.md` is engineering prep, not core GDD material.

Main issue:
- The folder is currently a **set of phase outputs and partial specs**, not a **single coherent, release-ready GDD package**.
- Important release-facing design information is still **fragmented, inconsistent, or missing final consolidation**.

## Missing deliverables

Smallest practical set needed to make this shippable:

### 1. Final GDD master document
A single source-of-truth package that consolidates:
- game pillar summary
- core loop
- card/emotion systems
- run structure
- progression/meta-progression
- encounter structure
- release scope
- open production assumptions

Why needed:
- Current design knowledge is spread across many phase docs.
- A ship-ready GDD needs one document producers, design, engineering, art, and QA can all reference.

### 2. Final roster bible
A single roster package covering the **release 6-character cast**:
- Maya
- Ember
- Wren
- Tide
- Frost
- Bloom

Minimum content per character:
- fantasy/theme
- emotional arc summary
- signature mechanics
- role/playstyle
- release card-set target or card package summary
- roster differentiation notes

Why needed:
- Current roster coverage is inconsistent.
- Bloom is not yet expanded beyond concept selection.
- Ember is fragmented across multiple docs.

### 3. Release content spec
A concise playable-content spec defining the minimum release design content:
- encounter types
- enemy families / encounter roles
- run length / node targets
- content quantity targets
- reward structure
- progression beats
- replay/end-state structure

Why needed:
- Existing encounter/enemy docs are exploratory and incomplete.
- A final GDD needs explicit release scope, not just system ideas.

### 4. Design closure / appendix pass
A short final appendix or closeout section that resolves documentation debt:
- terminology/glossary
- unresolved assumptions to carry as tracked risks
- doc map / source-of-truth note
- version/status marker for final package

Why needed:
- Current docs still contain draft/open-question energy.
- The final package needs explicit closure and handoff readiness.

## Recommended verb-first task breakdown

### Deliverable 1 — Final GDD master document
- **Consolidate** core mechanics, run loop, emotional systems, and narrative structure into one master doc.
- **Define** the release vision, player promise, and success criteria in final language.
- **Normalize** terminology across emotion families, resources, encounters, and progression.
- **Summarize** only the implementation-relevant rules and cut exploratory repetition.
- **Mark** clear release scope versus future expansion.

### Deliverable 2 — Final roster bible
- **Unify** all six characters into one consistent template.
- **Expand** Bloom from selected concept into release-ready roster documentation.
- **Merge** Ember's split materials into one coherent character package.
- **Align** card-count expectations and phase terminology across all characters.
- **Differentiate** each character's gameplay niche and emotional role.

### Deliverable 3 — Release content spec
- **Specify** the minimum shippable encounter set and enemy coverage.
- **Define** run structure targets: acts/nodes/encounters/reward cadence.
- **Translate** exploratory enemy and encounter ideas into production-ready content buckets.
- **Set** quantity targets for cards, encounters, enemies, and endings at release.
- **Flag** any intentional placeholders that remain outside Phase 5 scope.

### Deliverable 4 — Design closure / appendix pass
- **Resolve** duplicated or superseded docs into a clear final-reference map.
- **Capture** remaining open questions as production risks, not loose brainstorming.
- **Add** glossary/version/status metadata for handoff.
- **Label** which older docs are source material versus final package artifacts.

## Suggested execution order

1. **Build the final roster bible first**
   - Biggest current inconsistency is character coverage.
   - Bloom and Ember consolidation are the most obvious blockers to a final package.

2. **Build the final GDD master document second**
   - Once roster scope is stable, the full game document can reference the final cast cleanly.

3. **Build the release content spec third**
   - Content scope should be derived from the now-stable core systems and roster.

4. **Do the design closure / appendix pass last**
   - Final cleanup only works after the actual package structure is locked.

## Recommended minimum final package shape

If the goal is the smallest credible final package, ship these four final docs:
- `emotion-cards-final-gdd.md`
- `emotion-cards-roster-bible.md`
- `emotion-cards-release-content-spec.md`
- `emotion-cards-gdd-appendix.md`

Everything else in `docs/gdd/` can remain as working/reference history unless explicitly promoted into the final package.