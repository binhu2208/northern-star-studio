# Joint NAC Signal Spec — John & Yoshi

**Status:** In Progress  
**Last updated:** 2026-03-25  
**Will update after DEV-V1-005 lands if `rewardChoices` expands the signal set**

---

## Known Engine Signals (stable, DEV-V1-003/004 ✅)

| Signal | Type | Description |
|--------|------|-------------|
| `phase` | string | Current turn phase: `state_refresh`, `draw_prepare`, `read_situation`, `play_response`, `resolve_effects`, `encounter_reaction`, `check_outcome`, `cleanup` |
| `runHealth` | object | Derived from tension/trust/clarity/momentum with tone labels. Shape: `{ label: string, tone: 'good'|'warn'|'bad'|'neutral' }` |
| `openWindows` | string[] | Array of currently open response window IDs, e.g. `['repair', 'protect', 'breakthrough']` |
| `breakthroughReady` | boolean | Whether the current encounter has met breakthrough conditions |
| `collapseArmed` | boolean | Whether collapse conditions are met (high tension + low trust, or failed plays) |
| `encounter.name` | string | Display name of the current encounter |
| `encounter.result` | string\|null | Current result state if encounter has resolved: `breakthrough`, `partial`, `stalemate`, `collapse`, or `null` if still active |
| `encounter.stats` | object | `{ tension, trust, clarity, momentum }` — raw stat values for meter display |

---

## NAC States (per ART-V1-002 spec)

The Next-Action Cue has 4 visual states:
1. **Active recommendation** — player has a clear best action right now
2. **Neutral** — situation is ambiguous, no strong signal
3. **No signal** — not enough information to generate a cue
4. **Locked** — action is blocked or not available in current state

---

## Pending from DEV-V1-005

- `rewardChoices` — array of card IDs the player can choose between encounters. Will add to this doc after 005 lands.

---

*Signal types are derived from `GameEngine.getPhaseInstruction()` and `GameEngine.getRunHealthLabel()` — see `engine.js` for exact logic.*
