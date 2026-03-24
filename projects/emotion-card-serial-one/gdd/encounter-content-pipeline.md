# Encounter Content Pipeline

Added lightweight scaffolding so encounter content can be authored as data instead of hard-coded combat setup.

## Current combat/character fit

The existing combat stack already exposes the hooks an encounter layer needs:

- `Character` provides `get_hp()`, `take_damage()`, stats, turn reset, and card manager integration.
- `CombatStateMachine` only needs `player_entity` and `enemy_entity` with HP methods.
- `TurnSystem`, `EnemyAI`, `DamageEngine`, and `WinConditions` are modular and can consume encounter metadata later.

The main gap was content loading: there was no shared structure for encounter ids, enemy stats, rewards, or authored objectives.

## New scripts

### `src/encounters/encounter_definition.gd`
Authorable data model for:
- encounter id/title/summary/biome/difficulty
- enemy setups
- reward definitions
- objective payloads
- freeform metadata

### `src/encounters/encounter_loader.gd`
Handles:
- loading encounter JSON files
- validating required fields
- creating simple runtime payloads
- instantiating a basic enemy `Character` from authored stats
- translating authored objective payloads into `WinConditions` entries

### `src/encounters/encounter_database.gd`
Tiny registry/cache for loading a whole encounter directory and fetching by id.

## Authoring format

Encounters live in `data/encounters/*.json`.

Example fields:

```json
{
  "id": "studio-foyer-shadow-001",
  "title": "Echo in the Foyer",
  "enemies": [
    {
      "id": "dustbound-memory",
      "stats": {
        "max_health": 24,
        "attack_power": 6,
        "defense_power": 3,
        "speed": 5
      }
    }
  ],
  "rewards": [
    { "type": "currency", "id": "calm", "amount": 15 }
  ],
  "objectives": [
    {
      "type": "defeat_all_enemies",
      "description": "Defeat the Dustbound Memory."
    }
  ]
}
```

## Runtime shape

`EncounterLoader.build_runtime_payload()` returns:

- `definition`
- `primary_enemy`
- `enemies`
- `rewards`
- `objectives`
- `metadata`

That is enough to wire the first enemy into the current 1v1 combat state machine now, while preserving room for multi-enemy encounters later.

## Notes

- The authored `deck`, `ai_profile`, and metadata values are stored even if not fully consumed yet.
- Objectives are kept as data payloads for later translation into `WinConditions` rules/UI.
- The loader intentionally instantiates generic `Character` enemies so content work can proceed before specialized enemy classes exist.
