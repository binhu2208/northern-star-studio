# Platform Portability Prep

This is groundwork for future platform work on Emotion Cards. It is not a port.

## Added scaffolding

- `src/platform/game_config.gd`
  - Centralizes gameplay-tunable values and semantic input action names.
  - Keeps raw action strings and platform-sensitive knobs out of scene logic.

- `src/platform/input_router.gd`
  - Converts raw Godot input events into semantic commands (`CONFIRM`, `CANCEL`, `PAUSE`).
  - Includes a small default binding bootstrap so local test scenes do not depend on project-level input setup.

- `src/platform/platform_services.gd`
  - Thin service boundary for platform/capability checks.
  - Intended future home for device-profile checks, save-path differences, haptics support, etc.

- `src/platform/platform_context.gd`
  - Aggregates config, input routing, and platform services behind one scene dependency.

## Integrated touch points

- `src/card-system/test_scene.gd`
  - Uses `PlatformContext` instead of reading raw input actions directly.
  - Pulls starting hand size from shared config.

- `src/card-system/card_manager.gd`
  - Can now accept shared config via `apply_config()`.

- `src/combat/turn_system.gd`
  - Can now accept shared config via `apply_config()`.

## Why this helps

This reduces future churn when adding controller-first layouts, handheld UI tuning, or platform-specific services. Instead of editing gameplay scripts everywhere, future work can hang off the platform layer and feed consistent semantic commands/config into the game.
