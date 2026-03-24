# QA-004 — Phase 3 Polish / Usability Review

**Project:** Emotion Cards  
**Branch Reviewed:** `release/v0.4.0`  
**Reviewer:** Sakura 🌸  
**Date:** 2026-03-17  
**Scope:** UI/style-guide/art integration docs, Phase 3 polish planning, and recent Phase 3 gameplay/content outputs.

---

## Summary

Phase 3 made useful progress on production planning, encounter authoring, and combat scaffolding, but the player-facing experience still has several clarity risks.

The biggest problem is not missing decoration. It is **system drift**:
- visual language is still split across multiple specs
- gameplay terminology in docs does not cleanly match runtime data structures
- Phase 3 Ember design docs and implemented Ember content now describe **different cards, different pacing, and different expectations**
- several mechanics that are central to the fantasy (hybrid cards, ally support, richer card types, status clarity) are not yet communicated or supported clearly enough for players

If this branch were shown to playtesters now, I would expect confusion around:
- what card categories actually exist
- what the Fire/Heat journey is supposed to feel like in Phase 3
- when turns/rounds advance
- whether the game is single-target combat, multi-enemy combat, or ally-support combat
- which UI spec is authoritative when visuals conflict

---

## Overall Assessment

**Release readiness for polish review:** Not ready for sign-off  
**Primary risk:** Player clarity and implementation ambiguity  
**Recommendation:** Resolve naming/system alignment before any broad UI export or tutorialization pass.

---

## Findings

### 1. Canonical UI language is still not actually canonical
**Severity:** High  
**Evidence:**
- `docs/style-guide.md`
- `assets/ui/card-template-spec.md`
- `assets/ui/elements/button-spec.md`
- `assets/ui/hud/hud-template-spec.md`
- `docs/art/ui-polish-pass.md`

**Issue:**
The Phase 3 polish pass correctly calls out that the repo contains competing UI languages, but the conflict is still live in the branch. The style guide says it is the source of truth, yet the card, button, and HUD specs still use older palettes, typography, and component rules.

**Player / UX risk:**
A mixed UI language makes the game feel unfinished even when individual assets are attractive. It also weakens readability because players cannot build trust in what shape/color/spacing patterns mean.

**Recommendation:**
Treat `docs/style-guide.md` as final authority and update or clearly deprecate the older specs immediately. Until that happens, art/dev/QA can all be “correct” in different ways.

---

### 2. Card size/spec mismatch will cause layout and readability churn
**Severity:** High  
**Evidence:**
- `docs/style-guide.md` → standard card `240 × 336`, ratio 5:7
- `assets/ui/card-template-spec.md` → `750 × 1050`, standard poker card
- `assets/ui/hud/hud-template-spec.md` → hand cards `120 × 168`, ratio 5:7

**Issue:**
There are at least three card-size contexts documented, but no clean statement of which one is the gameplay source of truth vs print/mockup/export size. The card art area is also defined separately in the card template spec.

**Player / UX risk:**
This usually turns into cropped art, inconsistent text density, unreadable rules text at gameplay distance, and repeated “minor” adjustments that destabilize UI polish late.

**Recommendation:**
Add one explicit sizing matrix:
- source/mockup size
- in-game rendered size
- hand size
- hover/zoom size
- art safe zone
- minimum readable rules-text size

---

### 3. Card taxonomy is inconsistent between design docs and actual runtime model
**Severity:** Critical  
**Evidence:**
- `docs/gdd/emotion-cards-core-mechanics.md` lists: Primary Emotions, Complex Emotions, Memories, Reactions
- `docs/gdd/ember-phase3-4-cards.md` uses: Attack, Defense, Heal, Control, Reaction, Buff, Primary Emotion
- `src/card-system/card.gd` only supports `ATTACK`, `DEFENSE`, `EMOTION`

**Issue:**
The game design now communicates a richer set of card identities than the runtime card model can express. In the current implementation, multiple distinct player-facing concepts collapse into the same underlying buckets.

**Player / UX risk:**
If UI labels/tooltips/tutorials promise distinctions the system cannot represent, players will not understand deck building or card synergies. This is especially dangerous for “Reaction,” “Memory,” and “Complex Emotion,” which imply unique timing or build rules.

**Recommendation:**
Before more content is authored, define the canonical model:
- either expand runtime card categories/status tags
- or intentionally simplify the docs to match implementation

Right now the project is teaching one game and scaffolding another.

---

### 4. Ember Phase 3 design doc and implemented Ember content are materially out of sync
**Severity:** Critical  
**Evidence:**
- `docs/gdd/ember-phase3-4-cards.md`
- `src/characters/ember/ember_card_data.gd`

**Issue:**
The Phase 3-4 Ember design doc presents a recovery/guilt/control arc with cards like `Ash Fall`, `Scars`, `Regret`, and `Cooling Embers`. The implemented Ember data instead uses a much more straightforward damage-heavy package (`Immolate`, `Thermal Strike`, `Rain of Fire`, `Combustion`) and only 2 cards for Phase 4.

This is not a naming polish problem. It is a design-to-runtime identity split.

**Player / UX risk:**
- Fire’s emotional arc will feel wrong compared with narrative docs
- tutorial or content copy built from the design docs will mislead players
- QA cannot verify intended Phase 3 pacing if “intended” and “implemented” are different products

**Recommendation:**
Pick one truth urgently:
- update code/data to match the intended Scorched Earth / Smoldering arc
- or rewrite the Phase 3-4 design doc to reflect the actual build

Do not continue balancing Ember until this is reconciled.

---

### 5. Phase 3 Fire pacing currently fights the stated emotional arc
**Severity:** High  
**Evidence:**
- `docs/gdd/ember-phase3-4-cards.md` says Phase 3 should slow down and introduce defense/recovery
- `src/characters/ember/ember_card_data.gd` Phase 3 is four aggressive attack cards
- `src/characters/ember/ember_character.gd` adds Heat at turn start and mostly only sheds Heat slowly

**Issue:**
The design docs frame Phase 3 as consequence, defense, and heat management. The implemented data pushes the opposite direction: high damage, more fire escalation, very little player-facing emotional de-escalation.

**Player / UX risk:**
The character arc loses legibility. Players are less likely to feel a meaningful phase shift and more likely to read Ember as “always red DPS with slightly different numbers.”

**Recommendation:**
Ensure at least one of the following is true in the build:
- visible defensive cards enter in Phase 3
- heat reduction becomes a readable decision
- low-heat play is rewarded by UI and card text
- Phase 4 contains enough content to feel like a real stance change, not a stub

---

### 6. Ally-support and hybrid-card language appears before the combat surface clearly supports it
**Severity:** High  
**Evidence:**
- `docs/gdd/ember-phase3-4-cards.md` includes ally-facing effects (`Wanting to Change`, `Cautious Flame` synergy)
- `src/gameplay/combat_gameplay_loop.gd` is effectively one player vs one enemy in current flow
- `data/encounters/studio_intro_encounters.json` authors a single enemy and no ally-facing encounter communication

**Issue:**
The docs introduce support/hybrid behavior as meaningful player-facing strategy, but the reviewed gameplay scaffolding still reads as a mostly single-target duel surface.

**Player / UX risk:**
Players will see cards that imply ally healing/setup play before the combat presentation teaches what “ally” means, where allies are shown, or why support timing matters.

**Recommendation:**
Gate ally-facing card content until one of these exists:
- visible ally slots
- tooltip language clarifying self vs ally vs target
- encounter/UI affordances showing multiple friendly combatants

Otherwise hybrid cards risk reading as vague instead of exciting.

---

### 7. Turn/round flow naming is likely to confuse both implementation and player messaging
**Severity:** Medium-High  
**Evidence:**
- `src/combat/turn_system.gd`
- `src/combat/combat_state_machine.gd`
- `assets/ui/hud/hud-template-spec.md`

**Issue:**
The branch has both a `TurnSystem` and a `CombatStateMachine`, each owning slightly different ideas of turns, states, and transitions. `TurnSystem.max_turns_per_round` is effectively acting as a combat timer, while HUD copy talks in natural player language like “YOUR TURN” / “Turn 3”.

**Player / UX risk:**
If the underlying state model is muddy, UI copy usually becomes muddy too: “turn,” “round,” “phase,” and “end turn” stop meaning one thing. That confusion shows up fast in tutorials and status effect timing.

**Recommendation:**
Define one glossary for player-facing timing:
- turn
- round
- phase
- start of turn / end of turn
- when statuses tick

Then align code comments, HUD labels, and combat log text to that glossary.

---

### 8. Status effects are mechanically rich, but their UI communication rules are still underspecified
**Severity:** High  
**Evidence:**
- `assets/ui/hud/hud-template-spec.md`
- `docs/art/ui-polish-pass.md`
- `docs/style-guide.md`
- encounter/card docs introduce status-style concepts like Heat, Soot, Vulnerable, Wanting, burn

**Issue:**
The project already relies on temporary and persistent states, but the HUD spec only gives general icon placement and overflow guidance. There is no fully reconciled rule for how players distinguish:
- stack count vs duration
- buff vs debuff
- self state vs enemy state
- family mechanic vs standard combat status

**Player / UX risk:**
This is a classic “the system exists, but players never really learn it” failure point. Heat/Soot/Wanting/Vulnerable are all meaningful, but without distinct display logic, players will miss why outcomes changed.

**Recommendation:**
Create one status-display spec that defines:
- icon container shape
- duration number position
- stack count position
- semantic color + non-color cue
- tooltip format
- overflow behavior
- priority order for always-visible statuses

---

### 9. Encounter content authoring is cleaner, but objective text still needs player-language QA
**Severity:** Medium  
**Evidence:**
- `data/encounters/studio_intro_encounters.json`
- `src/encounters/encounter_definition.gd`

**Issue:**
The encounter JSON is structured well for authoring, but current objectives and rewards still use a mix of system language and flavor language. Example: `calm` as currency is flavorful, but it will need stronger UI labeling to avoid reading like a status effect or resource pool.

**Player / UX risk:**
Early encounters set the grammar for the whole game. If reward/objective labels are not clearly categorized, players may not understand what is permanent, spendable, or just flavor text.

**Recommendation:**
Standardize reward presentation into player-readable categories:
- resource
- card/deck reward
- memory unlock
- progression unlock
- optional objective bonus

Then ensure the HUD/reward panel mirrors those categories clearly.

---

### 10. Accessibility intent is strong in docs, but implementation-facing acceptance criteria are still missing
**Severity:** Medium  
**Evidence:**
- `docs/style-guide.md` accessibility section
- `docs/art/ui-polish-pass.md` accessibility pass appears later in sequence

**Issue:**
The docs say the right things about contrast, reduced motion, focus states, and non-color indicators, but they remain mostly principle-level. There are not enough concrete acceptance checks tied to actual assets/flows yet.

**Player / UX risk:**
Accessibility becomes “we meant to do that later,” especially once polish pressure ramps up. That tends to produce a pretty UI that is harder to read than the prototype.

**Recommendation:**
Add build-verifiable QA checks for:
- minimum readable card text at gameplay scale
- controller/keyboard focus visibility
- reduced-motion behavior for hover/play/turn transitions
- non-color status distinction
- low-health and low-energy readability

---

## Naming / Consistency Problems Worth Fixing First

These are the highest-value cleanup targets before further UI/content expansion:

1. **Card category naming**
   - Docs: Primary Emotion / Complex Emotion / Memory / Reaction / Buff / Control / Heal
   - Runtime: Attack / Defense / Emotion
   - This must be unified.

2. **Ember phase content naming**
   - Design doc names and implemented names do not match.
   - This blocks meaningful QA for Fire progression.

3. **UI state vocabulary**
   - Use one shared set: `idle`, `hover`, `pressed`, `selected`, `disabled`, `focus-visible`.

4. **Combat timing vocabulary**
   - Clarify `turn`, `round`, `phase`, `combat resolution`, and status timing windows.

5. **Reward/resource vocabulary**
   - Terms like `Calm`, `Memory Fragment`, `objective`, `reward`, and `unlock` need a stable presentation model.

---

## Recommended Next Actions

### Blockers before wider polish sign-off
- Reconcile Phase 3 Ember docs with implemented Ember card data.
- Finalize one canonical card taxonomy and reflect it in both docs and runtime structures.
- Deprecate or rewrite outdated UI specs so the style guide is genuinely authoritative.

### High-value follow-up QA pass
- Review actual in-engine card readability at gameplay distance.
- Verify status icon readability with real stack/duration examples.
- Run a terminology pass on tutorial/help text once taxonomy is locked.
- Review first encounter reward presentation for permanence/category clarity.

---

## Final Verdict

Phase 3 has strong planning momentum, but the current player experience is still at risk from **clarity drift**, not lack of polish assets.

My blunt read: the branch needs **system reconciliation before cosmetic refinement**. If the team polishes on top of today’s mismatches, the result will look better while remaining harder to understand.
