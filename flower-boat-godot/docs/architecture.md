# Flower Boat — Godot Project Structure

## Overview
Flower Boat built in Godot 4.x. Web export target for browser playability.

## Directory Structure

```
flower-boat-godot/
├── autoloads/           # Global singletons (always loaded)
│   ├── game_state.gd    # Master game state, weather, route, session data
│   ├── inventory.gd      # Flower stock management
│   └── dialogue_bus.gd  # Event bus for UI/scene communication
├── scenes/
│   ├── main.tscn        # Main game scene (boot)
│   ├── ui/
│   │   ├── title_screen.tscn
│   │   ├── weather_select.tscn
│   │   ├── stock_select.tscn
│   │   ├── route_map.tscn
│   │   ├── planning_phase.tscn
│   │   ├── encounter.tscn
│   │   └── summary.tscn
│   └── world/
│       ├── canal.tscn           # Water/environment layer
│       ├── boat.tscn            # Player boat
│       └── customer.tscn         # Customer character
├── scripts/
│   ├── state_machine.gd          # Reusable state machine
│   ├── encounter_system.gd      # Encounter logic
│   ├── flower_data.gd           # Flower definitions
│   └── customer_data.gd          # Customer definitions
├── resources/
│   ├── flowers.tres              # Flower resource definitions
│   ├── customers.tres            # Customer definitions
│   └── routes.tres              # Route definitions
├── sprites/
│   ├── characters/              # Customer silhouettes
│   ├── flowers/                  # Flower illustrations
│   ├── boat/                    # Boat sprites
│   ├── environment/             # Canal, sky, weather
│   └── ui/                     # Card frames, buttons
├── audio/
│   ├── music/                   # Ambient canal sounds
│   └── sfx/                    # UI feedback sounds
└── docs/
    └── architecture.md          # This file
```

## Scene Hierarchy

```
main (autoload: game_state, inventory, dialogue_bus)
├── canal_background
├── boat
├── customer_spawn_point
└── ui_layer
    └── [current_screen] (swap based on game_state.phase)
```

## Game Phases (state machine)

```
TITLE → WEATHER_SELECT → ROUTE_MAP → STOCK_SELECT → PLANNING → ENCOUNTER → SUMMARY → (loop)
```

## Key Systems

1. **State Machine** — declarative state transitions driven by `game_state.phase`
2. **Inventory** — 3-slot flower stock, weather affinity lookups
3. **Encounter System** — customer spawn, flower suggestion, outcome resolution
4. **Weather System** — sunshine/rain affects customer pool and flower fit
5. **Dialogue Bus** — decouples UI from game logic via signals

## Asset Specs (for Yoshi)

- **Resolution:** 1280×720 export, 2x sprites for retina
- **Tile size:** 32×32 for environment, 64×64 for characters
- **Character sprites:** Color silhouette style (no faces), 4 directions
- **Flower sprites:** 64×64 portrait cards with flower illustration
- **Weather backgrounds:** Full-screen panels, 3 weather states + fog/golden hour

## Godot Export Targets

- Web (HTML5) — primary delivery
- PC (Windows/Linux) — secondary
- Mobile — downstream

## Notes

- Godot 4.x uses GDScript 2.0 (recommended over Godot 3.x)
- Web export requires Godot export templates installed
- Scene files (.tscn) are text-based and git-friendly
