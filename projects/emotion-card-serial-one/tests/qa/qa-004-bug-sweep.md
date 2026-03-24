# QA-004 Bug Sweep — Emotion Cards Phase 3

**Date:** 2026-03-17  
**Tester:** Sakura 🌸  
**Branch:** `release/v0.4.0`

## Scope

Reviewed the current gameplay/combat/card integration around the Phase 3 Ember work, with focus on:
- `docs/gdd/ember-phase3-4-cards.md`
- `docs/gdd/emotion-cards-core-mechanics.md`
- `src/characters/ember/ember_card_data.gd`
- `src/characters/ember/ember_card_effects.gd`
- `src/characters/ember/ember_card_factory.gd`
- `src/card-system/card_manager.gd`
- `src/combat/combat_state_machine.gd`
- `src/gameplay/combat_gameplay_loop.gd`
- `tests/qa/test-scenarios-card-system.md`

---

## Executive Summary

Phase 3 is **not implementation-aligned** right now. The main risk is not a subtle combat tuning issue — it is that the shipped Ember data/effects do **not match the Phase 3-4 design doc at all**. If design, QA, and engineering all think they are testing the same cards, they are not.

Secondary risks:
- one obvious broken asset path for Ember card art
- turn counter/state flow edge case in combat state handling
- test coverage is behind the current gameplay loop and Ember integration

---

## Findings

### 1) Critical — Phase 3/4 design doc and implemented Ember cards are completely out of sync

**Files:**
- `docs/gdd/ember-phase3-4-cards.md`
- `src/characters/ember/ember_card_data.gd`
- `src/characters/ember/ember_card_effects.gd`

**What’s wrong:**
The design doc defines these cards for Phase 3/4:
- Phase 3: **Ash Fall, Scars, Regret, Cooling Embers**
- Phase 4: **Trembling Spark, What Have I Done, Wanting to Change, Cautious Flame**

But the implemented Phase 3/4 card data is:
- Phase 3: **Immolate, Thermal Strike, Rain of Fire, Combustion**
- Phase 4: **Smolder, Coals**

The described mechanics are also missing from implementation:
- `Soot` debuff
- `Wanting` buff
- low-heat bonus behavior from `Trembling Spark`
- self-damage mitigation behavior from `What Have I Done`
- ally-heal transmutation from `Wanting to Change`
- `Vulnerable` application from `Cautious Flame`
- `Cooling Embers` heat reduction / defensive transition

**Why this matters:**
- QA cannot validate the intended Phase 3 experience against live code.
- Balance notes in the design doc are currently meaningless for the shipped implementation.
- Any content references, milestone checks, or review comments based on the doc will be misleading.

**Recommended fix:**
Decide which source of truth wins:
1. update code/effects to match the doc, or
2. rewrite the Phase 3-4 doc to match the implemented Ember card set.

Until that happens, this area should be treated as **design/implementation divergence**, not “done.”

---

### 2) High — Phase 4 card count is inconsistent across design and code

**Files:**
- `docs/gdd/ember-phase3-4-cards.md`
- `src/characters/ember/ember_card_data.gd`
- `src/characters/ember/ember_card_factory.gd`

**What’s wrong:**
The doc says Phase 4 has cards 13-16 (four cards). The code only defines two Phase 4 cards (`ember_smolder`, `ember_coals`).

`EmberCardFactory.get_deck_configuration()` also bakes that mismatch into deck construction:
- Phase 4 contributes only **4 cards total** because there are only **2 unique cards x2 copies**.

**Why this matters:**
- Deck size/composition is materially different from the intended progression.
- Phase pacing and unlock structure will be off.
- Any progression UI or balancing that assumes 20 cards split per doc will drift.

**Recommended fix:**
Either add the missing Phase 4 cards to code or update docs/progression assumptions to reflect the real set.

---

### 3) High — Ember card art paths point to assets that do not exist

**File:** `src/characters/ember/ember_card_factory.gd`

**What’s wrong:**
Every Ember card gets:
`res://assets/cards/ember/<card_id>.png`

But the repo does not contain an `assets/cards/ember/` card art directory or matching files. Current Ember assets live under `assets/characters/ember/`.

**Why this matters:**
- Card rendering will fail or fall back to missing textures once UI starts reading `card.art_path`.
- This is a classic “looks fine in data, breaks in scene/UI” integration bug.

**Recommended fix:**
- point `art_path` at real files, or
- leave it empty/null until card art assets exist, or
- create the expected directory/files.

---

### 4) Medium — Combat turn counter never increments for the opening player turn

**Files:**
- `src/combat/combat_state_machine.gd`
- `src/gameplay/combat_gameplay_loop.gd`

**What’s wrong:**
`CombatStateMachine.reset_combat()` sets state to `PLAYER_TURN` immediately. Then `CombatGameplayLoop._start_player_turn()` calls `combat_state_machine.start_player_turn()`, but `start_player_turn()` returns early if already in `PLAYER_TURN`.

`turn_count += 1` only happens after the state change branch, so the first player turn starts with `turn_count == 0`.

**Why this matters:**
- Enemy AI receives `combat_state_machine.turn_count` in `_decide_enemy_action()`.
- Any first-turn behavior keyed off turn count will be off by one.
- Debug output / analytics / future win conditions may read the wrong turn number.

**Recommended fix:**
Increment turn count from a more reliable place, or ensure the first player turn is entered through the same path as later turns.

---

### 5) Medium — Ember effect handler contains two execution models with different rules

**File:** `src/characters/ember/ember_card_effects.gd`

**What’s wrong:**
The file exposes both:
- `execute_card_effect(card, target, source)`
- `execute_card(card_info, target, all_targets)`

These paths do not behave the same:
- one operates on `Card`
- the other operates on raw `Dictionary`
- one assumes energy was already spent elsewhere
- the other spends energy internally via `ember_character.use_energy(cost)`
- one creates real shields through `DamageEngine.create_shield()`
- the other only toggles `set_defending(true)` and leaves a “future” comment

`CombatGameplayLoop` currently uses `execute_card_effect`, so `execute_card` looks like stale/parallel logic.

**Why this matters:**
- Future callers can easily use the wrong method and get different gameplay.
- It increases the odds of double energy spending or inconsistent defenses.

**Recommended fix:**
Collapse to one authoritative execution path, or clearly mark the unused one as deprecated and remove it.

---

### 6) Medium — Card system QA doc is stale relative to current gameplay integration

**File:** `tests/qa/test-scenarios-card-system.md`

**What’s wrong:**
The test doc still focuses on the original low-level card container behavior, but it misses current integration risks introduced by gameplay loop wiring:
- no Ember-specific card/effect tests
- no deck progression state serialization/deserialization tests
- no `CombatGameplayLoop` turn/energy/play integration tests
- no verification for missing art paths / content asset references
- no checks for Phase 3/4 content parity against design docs

**Why this matters:**
The current highest-risk failures are integration/content parity issues, and the test plan would not catch them.

**Recommended fix:**
Add focused cases for:
- Ember Phase 3/4 card roster parity
- effect execution through `CombatGameplayLoop`
- first-turn state/turn counter validation
- asset path existence checks
- serialization round-trip for card piles/hand

---

### 7) Low — Core mechanics doc still describes Fire + Warmth as conflict while Phase 4 Ember doc treats it as intended hybrid progression

**Files:**
- `docs/gdd/emotion-cards-core-mechanics.md`
- `docs/gdd/ember-phase3-4-cards.md`

**What’s wrong:**
Core mechanics says:
- `Fire + Warmth` causes emotional turbulence / discard

But the Ember Phase 4 doc explicitly frames Fire/Warmth hybridization as the intended next-step path via `Wanting to Change`.

**Why this matters:**
Not a hard code bug today, but it is a rules-definition conflict that will create implementation churn later.

**Recommended fix:**
Clarify whether Ember is a specific exception to the global conflict rule or whether the global rule has evolved.

---

## Suggested Priority Order

1. **Resolve Phase 3/4 doc vs code mismatch**
2. **Fix Ember art paths before UI integration spreads the bad reference**
3. **Fix first-turn turn_count behavior**
4. **Clean up duplicated Ember effect execution paths**
5. **Update QA coverage to match current integration risks**

---

## QA Verdict

**Status:** Needs follow-up before Phase 3 can be considered safely testable.

Right now the biggest bug is conceptual but very real: the Phase 3/4 feature that design describes is not the Phase 3/4 feature the code actually implements.
