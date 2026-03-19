# DEV-006A Dependencies & Risks — v0.6.0 Implementation Milestone

> Branch: `release/v0.6.0`  
> Context: Post-Phase 5 / v0.5.0 launch, preparing for next development cycle

## Overview

This document maps the dependency chain and risk profile for the next implementation milestone (v0.6.0). It covers upstream dependencies that must be in place before work begins, downstream systems that could be affected, technical risk areas, and timeline concerns.

---

## Upstream Dependencies

### 1. Phase 5 / v0.5.0 Launch Artifacts

| Dependency | Status | Notes |
|------------|--------|-------|
| Release tracker populated | **Pending** | `docs/release/v0.5.0-release-tracker.md` still has placeholder data |
| Patch notes finalized | **Pending** | `docs/release/v0.5.0-patch-notes-draft.md` needs confirmed shipped items |
| Post-launch fix queue pre-seeded | **Pending** | No known issues loaded yet |
| Hotfix config wiring complete | **Incomplete** | `GameConfig.card_overrides` not wired to `CardManager` or `MayaCardEffects` |

**Risk:** Starting v0.6.0 development before these are resolved may create confusion about what's "done" in v0.5.0 and what belongs in v0.6.0.

### 2. QA Sign-off

- Post-launch smoke checklist (`tests/qa/post-launch-smoke-checklist.md`) must be executed for v0.5.0
- Maya-specific regression checks (resonance, self-damage, heal/shield combos) need explicit coverage
- Acceptance that no blocking issues remain for v0.5.0

**Risk:** Unresolved v0.5.0 issues may leak into v0.6.0 scope, causing scope creep.

### 3. Engineering Owner Assignment

- Need confirmed owner for live bug intake on `release/v0.5.0`
- Need clear first-response path for live issues (reproduce → decide fix vs hold)

**Risk:** Without clear ownership, hotfixes may be delayed during launch window.

### 4. Game Config Wiring (Blocking for Card System Work)

From DEV-006A audit:
- `GameConfig.card_overrides` → not consumed by `CardManager`
- `GameConfig.card_overrides` → not consumed by `MayaCardEffects`

**Risk:** Any card-balancing work in v0.6.0 cannot use the documented config-based override path until this is fixed.

---

## Downstream Risks

### 1. Player Progression / Save System

Files: `src/progression/`, `src/progression/progression_save_hooks.gd`

- Changes to combat logic (turn system, damage engine) may affect save state
- Encounter completion tracking uses `encounter_progress_state.gd` — any new encounter types need migration path

**Risk:** New combat mechanics could invalidate existing save files or require migration logic.

### 2. UI / Platform Layer

Files: `src/platform/`, `src/gameplay/combat_gameplay_loop.gd`

- `PlatformContext`, `PlatformServices` wrap platform-specific behavior
- Input routing (`input_router.gd`) handles player actions
- New enemy AI or combat states may need UI indicators (turn warnings, damage numbers, status effects)

**Risk:** UI polish may lag behind gameplay logic if not planned alongside.

### 3. Card System Consumers

Files: `src/card-system/card_manager.gd`, `src/characters/maya/maya_card_effects.gd`

- Maya character specifically uses custom card effects
- Deck/hand management relies on `CardDeck` and `CardHand` classes
- Any changes to card draw, discard, or effect resolution may affect Maya balance

**Risk:** Card system changes have high visibility (player-facing). Balance regressions in Maya could impact v0.6.0 reception.

### 4. Encounter System

Files: `src/encounters/`

- `EncounterDefinition`, `EncounterLoader`, `EncounterDatabase` define and load content
- New enemy types (DEV-001B-2: Enemy AI framework) will need encounter definitions
- `EncounterDatabase` likely needs schema update for new enemy AI parameters

**Risk:** New encounter content requires coordination between engineering (AI logic) and design (encounter definitions).

---

## Technical Risks

### 1. Turn System & Phase Transitions (DEV-001B-1)

Files: `src/combat/turn_system.gd`, `src/characters/maya/maya_phase_system.gd`

- Maya has existing phase system (`maya_phase_system.gd`)
- Turn system must integrate with or replace existing phase logic
- State transitions need to handle: player turn → enemy turn → resolution

**Risk:** Phase/turn logic bugs can cause deadlocks (no valid actions) or incorrect win/lose states.

### 2. Enemy AI Framework (DEV-001B-2)

Files: `src/combat/enemy_ai.gd`

- No existing AI framework — starting from scratch
- Need to define: decision tree, action scoring, difficulty scaling
- AI must be testable without full encounter runs

**Risk:** AI that is too simple feels trivial; too complex is unpredictable. Difficulty tuning is time-consuming.

### 3. Combat State Machine (DEV-001B-3)

Files: `src/combat/combat_state_machine.gd`, `src/combat/win_conditions.gd`

- Must handle: ongoing, victory, defeat, draw
- State transitions need to cleanly exit all subsystems (turns, AI, cards, damage)
- Need hook points for UI to react to state changes

**Risk:** Incomplete state handling can cause "stuck" combat scenarios or silent failures.

### 4. Damage Calculation Engine (DEV-001B-4)

Files: `src/combat/damage_engine.gd`

- Must handle: base damage, modifiers, scalars, mitigation, shields, healing
- Damage types (if any) need consistent application
- Need audit path for damage values in logs/debug

**Risk:** Damage bugs are high-visibility (players notice "wrong" numbers). Floating-point edge cases may cause unexpected results.

### 5. Config Override Path

From audit: `GameConfig.card_overrides` not wired to runtime systems.

**Risk:** Even after fix, the override contract is undocumented. Operators won't know valid keys (`disabled`, `damage_delta`, `damage_scalar`, etc.).

---

## Timeline Risks

### 1. v0.5.0 Launch Window

- Phase 5 release timing not yet locked (Shig to confirm)
- Go / no-go decision pending
- First patch scope undefined

**Risk:** v0.6.0 planning cannot finalize until v0.5.0 ships. Delayed launch = delayed start.

### 2. Scope Creep from v0.5.0 Leakage

- Audit found: release tracker not populated, patch notes empty, hotfix path incomplete
- Post-launch queue currently empty — any discovered issues become v0.6.0 candidates

**Risk:** v0.6.0 may inherit v0.5.0 technical debt if launch reveals problems.

### 3. QA Bottleneck

- Post-launch smoke requires Maya-specific checks
- Each new combat system (turns, AI, state machine, damage) needs focused verification
- QA resources may be stretched thin if v0.5.0 support continues

**Risk:** Testing bottleneck delays v0.6.0 sign-off.

### 4. Dependencies Between DEV-001B Subtasks

- DEV-001B-1 (turn system) blocks DEV-001B-3 (state machine) — state machine needs to know what "turns" are
- DEV-001B-4 (damage engine) is foundational — AI (B-2) and state machine (B-3) both depend on damage values

**Risk:** Linear dependency chain means delays compound. If damage engine slips, everything downstream is blocked.

### 5. Documentation Burden

- Support reference docs for hotfix keys need writing
- New systems (AI, damage) need operator-facing documentation
- Patch workflow already has templates but needs population

**Risk:** Engineering time spent on docs reduces time on code.

---

## Risk Summary Table

| Category | High Risk | Medium Risk | Low Risk |
|----------|-----------|-------------|----------|
| **Upstream** | Hotfix config wiring incomplete | QA sign-off pending | Owner assignment |
| **Downstream** | Card system consumers | Progression/save system | UI/encounter |
| **Technical** | Turn system integration | Enemy AI framework | Damage engine (foundational) |
| **Timeline** | v0.5.0 launch timing | QA bottleneck | Scope creep (managed) |

---

## Recommended Mitigations

1. **Lock v0.5.0 release date** before finalizing v0.6.0 scope
2. **Complete hotfix config wiring** before card-balancing work begins in v0.6.0
3. **Write operator docs** for config overrides alongside the wiring fix
4. **Parallel-track QA**: start Maya-specific smoke while engineering plans v0.6.0
5. **Sequence DEV-001B**: complete damage engine first (foundational), then build turn system, then AI, then state machine
6. **Pre-seed post-launch queue** with any known non-blocking v0.5.0 issues to prevent leakage

---

## Next Steps

- [ ] Confirm v0.5.0 go/no-go with Shig
- [ ] Populate release tracker with actual launch data
- [ ] Wire `GameConfig.card_overrides` to `CardManager` and `MayaCardEffects`
- [ ] Document valid hotfix override keys
- [ ] Execute Maya-specific post-launch smoke
- [ ] Finalize v0.6.0 scope and assign DEV-001B owners

---

*Document created for DEV-006A release planning. Update as v0.5.0 launches and v0.6.0 scope solidifies.*