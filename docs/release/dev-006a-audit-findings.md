# DEV-006A Audit Findings — Phase 5 Release / Post-Launch Support

## Summary
Current v0.5.0 release-support artifacts are mostly scaffolds. The biggest readiness gap is that the documented/implicit hotfix path for card behavior is not fully wired in code, so launch-week config tweaks are likely to be unreliable without additional engineering work.

## Key Findings

### 1. Release tracker and patch notes are not release-ready
- `docs/release/v0.5.0-release-tracker.md` is still mostly template content:
  - target build/date = `TBD`
  - go/no-go = `TBD`
  - highlights/fixes/known issues are blank placeholders
  - post-launch queue rows are empty placeholders
- `docs/release/v0.5.0-patch-notes-draft.md` is also still placeholder-only.

**Impact:** no usable source of truth for ship status, day-one messaging, or first patch scope.

### 2. Hotfix config path is inconsistent for card/deck support
- `src/platform/game_config.gd` exposes `card_overrides`.
- `src/card-system/card_manager.gd` does **not** consume `config.card_overrides`; it has a separate `draw_count_overrides` field and `apply_config()` only copies `feature_toggles`.
- Result: documented/configurable card-level overrides are not actually reaching `CardManager`.

**Impact:** deck/card draw launch-week tuning is not safely operable through shared config as implied.

### 3. Maya card hotfix hooks exist but are not wired to runtime config
- `src/characters/maya/maya_card_effects.gd` defines `feature_toggles` and `card_overrides` plus helper methods (`is_card_enabled`, scalar overrides).
- But there is no `apply_config(config: GameConfig)` on `MayaCardEffects`.
- I found no runtime path that injects `GameConfig.card_overrides` into `MayaCardEffects` during gameplay setup.

**Impact:** Maya-specific post-launch card tuning/disable switches appear present in code but are not deployable through the current support pipeline.

### 4. Support docs do not document the actual override contract
- There is no concise operator-facing doc for:
  - which feature toggle keys are supported
  - which card override keys are supported (`disabled`, `damage_delta`, `damage_scalar`, etc.)
  - where these values live and how to ship them safely

**Impact:** even if config wiring is fixed, support/engineering will still be guessing at valid patch knobs during a live issue.

### 5. Smoke coverage is too generic for Maya/post-launch risk areas
- `tests/qa/post-launch-smoke-checklist.md` covers general combat/card/save/UI flow.
- It does **not** explicitly cover Maya-specific high-risk behaviors visible in `maya_card_effects.gd`, such as:
  - resonance activation
  - conditional bonus effects
  - self-damage cards
  - shield/heal combinations
  - special effect flags that game logic may depend on

**Impact:** support could ship a targeted Maya fix without checking the most likely adjacent regressions.

## Recommended Next Deliverables
1. **Populate release tracker now** with real build/date, go/no-go owner, known issues, and actual post-launch queue entries.
2. **Convert patch notes draft from placeholders** to a short player-facing draft before code freeze.
3. **Fix config wiring** so shared `GameConfig.card_overrides` reaches the systems that claim to support hotfix overrides:
   - `CardManager`
   - `MayaCardEffects`
4. **Add one support-facing hotfix reference** documenting valid toggle/override keys and example payloads.
5. **Expand post-launch smoke coverage** with Maya-specific regression checks for resonance, self-damage, heal/shield cards, and at least one conditional bonus interaction.

## Bottom Line
Docs say there is a lightweight post-launch patch process, but the underlying engineering support path for card-level hotfixes is only partially implemented. Release comms are also still template-grade, so Phase 5 is not yet support-ready.