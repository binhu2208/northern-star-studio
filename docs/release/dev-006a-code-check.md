# DEV-006A — Hotfix Code Path Check

Scope reviewed:
- `src/platform/game_config.gd`
- `src/card-system/card_manager.gd`
- `src/combat/damage_engine.gd`
- `src/gameplay/combat_gameplay_loop.gd`
- `src/progression/*.gd`
- character effect handlers under `src/characters/**`

## Verdict

The repo already had decent low-risk post-launch scaffolding:
- centralized `GameConfig` feature toggles and override dictionaries
- damage hotfix scalars in `DamageEngine`
- per-card override helpers in character effect handlers
- card/deck serialization hooks in `CardManager`
- run/profile capture/apply hooks in `ProgressionSaveHooks`

That said, one practical gap showed up: the hotfix config was not fully wired into the live combat path. The knobs existed, but central `GameConfig.card_overrides` did not reliably flow into the card manager or character effect handlers used by `CombatGameplayLoop`.

## Safe changes made

### 1) Wired central card overrides into `CardManager`
File: `src/card-system/card_manager.gd`

- `apply_config()` now copies `config.card_overrides` into the manager's override dictionary.
- This makes existing draw-time controls like `skip_draw` actually reachable from the shared config.

### 2) Added `apply_config()` to character effect handlers
Files:
- `src/characters/ember/ember_card_effects.gd`
- `src/characters/wren/wren_card_effects.gd`
- `src/characters/maya/maya_card_effects.gd`

- Each handler now accepts `GameConfig` and copies `feature_toggles` + `card_overrides`.
- This keeps their existing per-card disable/scalar logic usable through one common config source.

### 3) Added config propagation to the live combat loop
File: `src/gameplay/combat_gameplay_loop.gd`

- Added `apply_config(config: GameConfig)`.
- It now propagates config into:
  - both `CardManager` instances
  - `DamageEngine`
  - `TurnSystem`
  - both character effect handlers
- It also syncs `opening_hand_size` from `config.starting_hand_size`.
- The loop stores the applied config and reapplies it to freshly initialized handlers when combat starts.

## Why this was worth fixing

This is the smallest change set that turns the existing hotfix scaffolding into something actually usable for launch-week tuning without deeper code edits.

Before this pass:
- override dictionaries existed
- but combat/runtime code did not consistently consume them from one place

After this pass:
- a single `GameConfig` can drive draw toggles, damage scalars, turn limits, opening hand size, and card effect overrides across the core combat path

## Remaining limits / follow-up notes

These are worth knowing, but I did **not** change them because they are not tiny hotfix-safe edits:

1. `Character.apply_run_progression_state()` restores health/energy/statuses, but does not rebuild `_active_cards` from serialized `active_card_ids`.
   - For current launch support, this is acceptable if persistent active-card effects are not relied on across save/load.
   - If mid-combat or mid-run active card persistence becomes important, this needs a focused follow-up.

2. `RunProgressionState.unlocked_run_card_ids` exists, but the reviewed save/apply path does not currently consume it into deck/runtime restoration.
   - Fine as scaffolding.
   - Not yet a full dynamic unlock migration path.

3. The generic `DamageEngine._apply_card_effects()` hook is still a placeholder.
   - That is okay for now because character-specific handlers are doing the real work.
   - It is not yet a universal late-bound card modifier system.

## Bottom line

Current scaffolding is now **sufficient for low-risk post-launch fixes** in the areas reviewed, provided the team keeps fixes small and config-driven where possible.

The most important missing connection was the end-to-end config wiring, and that has now been patched with minimal code changes.
