# DES-V1-002b — Breakthrough Moment Encounter Template Design

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DES-V1-002b
- **Purpose:** Author the complete implementation-ready encounter template for Breakthrough Moment
- **Status:** Draft — ready for implementation
- **Encounters reference:** `v1-card-taxonomy-and-encounter-templates.md` (DES-V1-002)
- **Design gap identified by:** `des-v1-003-encounter-template-verification.md` (DES-V1-003) — GAP 1

---

## Encounter 5 — Breakthrough Moment

**v1 position:** Last encounter only (`runPosition: last`)
**Design intent:** A high-stakes encounter designed to feel like the climax of a run. It is the payoff encounter — if the run has gone well, the encounter is calibrated to be easier to breakthrough. If the run has negative carry-forward state, the encounter is harder and the keywords can shift to reflect that burden. The encounter reads run history and modifies its starting state accordingly.

---

### Template

```yaml
id: breakthrough_moment
name: Breakthrough Moment
prompt: >
  Everything has been leading here.
  The real question is finally on the table, and how you got here matters.
keywords: [repairable, open_window]
startingStats:
  tension: 5
  trust: 5
  clarity: 4
  momentum: 0
startingWindows: [connect, recover, reframe]
visibleCues:
  - "This is the encounter where it all comes together."
  - "The entire run's history affects how this plays out."
  - "A breakthrough is possible — but only if you've built the foundation."
  - "Net-positive run: trust and clarity carry forward."
  - "Net-negative run: tension is higher and trust is lower."
breakthroughThresholds:
  trust: 6
  clarity: 6
  momentum: 0
collapseConditions:
  - "Tension reaches 10 and trust is 2 or below"
  - "Three failed plays with tension at 7 or above"
  - "Pressure play when trust is 3 or below and encounter is guarded"
turnPressureRules:
  description: >
    Standard v1 turn pressure applies (tension +1 after turn 4, per DES-V1-001).
    This encounter additionally reads run-level carry-forward state at encounter
    start and modifies starting stats accordingly. Net-positive carry-forward
    grants +1 trust and +1 clarity bonus. Net-negative carry-forward applies
    -1 trust and adds the 'guarded' keyword. These are one-time modifiers applied
    at encounter initialization before the first player turn.
reactionRules:
  # ─── Priority 85 — Positive carry-forward run: momentum reward ────────────
  - id: bm_positive_run_connect
    priority: 85
    if: { runHasPositiveCarryForward: true, packageHasTag: connect }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: modify_stat, stat: momentum, amount: 1 }
      - { type: open_response_window, windowId: breakthrough }
      - { type: set_breakthrough_ready, value: true }
    cue: "Drawing on the good history of the run, the connection lands with weight."

  # ─── Priority 85 — Positive carry-forward: recover is amplified ───────────
  - id: bm_positive_run_recover
    priority: 85
    if: { runHasPositiveCarryForward: true, packageHasTag: recover }
    effects:
      - { type: modify_stat, stat: momentum, amount: 2 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "Recovery comes easier when there's a foundation to build on."

  # ─── Priority 80 — Negative carry-forward: guarded walls are up ───────────
  - id: bm_negative_run_guard
    priority: 80
    if: { runHasNegativeCarryForward: true }
    effects:
      - { type: modify_stat, stat: tension, amount: 1 }
      - { type: modify_stat, stat: trust, amount: -1 }
    cue: "The weight of earlier collapses makes reaching out feel dangerous."

  # ─── Priority 75 — Connect with memory: the arc-completing play ───────────
  - id: bm_connect_memory_reward
    priority: 75
    if:
      packageHasTag: connect
      packageHasCategory: memory
    effects:
      - { type: modify_stat, stat: trust, amount: 2 }
      - { type: modify_stat, stat: clarity, amount: 1 }
      - { type: set_breakthrough_ready, value: true }
      - { type: open_response_window, windowId: breakthrough }
    cue: "Drawing on real shared context seals the arc. Everything fits."

  # ─── Priority 70 — Positive run: reveal reframes ──────────────────────────
  - id: bm_positive_run_reframe
    priority: 70
    if: { runHasPositiveCarryForward: true, packageHasTag: reframe }
    effects:
      - { type: modify_stat, stat: clarity, amount: 2 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "In a positive run, reframing unlocks the full picture."

  # ─── Priority 65 — Negative run: pressure collapses ─────────────────────
  - id: bm_negative_run_pressure_collapse
    priority: 65
    if: { runHasNegativeCarryForward: true, packageHasTag: pressure }
    effects:
      - { type: modify_stat, stat: trust, amount: -2 }
      - { type: modify_stat, stat: tension, amount: 2 }
    cue: "Forcing it now, after everything that's gone wrong, shatters what's left."

  # ─── Priority 60 — Neutral run: connect earns momentum ───────────────────
  - id: bm_neutral_connect
    priority: 60
    if:
      runHasPositiveCarryForward: false
      runHasNegativeCarryForward: false
      packageHasTag: connect
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "A genuine connection opens the door to resolution."

  # ─── Priority 55 — Recover earns a chance even on neutral run ─────────────
  - id: bm_neutral_recover
    priority: 55
    if:
      runHasPositiveCarryForward: false
      runHasNegativeCarryForward: false
      packageHasTag: recover
    effects:
      - { type: modify_stat, stat: momentum, amount: 1 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "Steady recovery earns a real shot at resolution."

  # ─── Priority 50 — Breakthrough card surfacing condition ──────────────────
  - id: bm_breakthrough_window
    priority: 50
    if:
      breakthroughReady: true
      statGte: { stat: trust, value: 6 }
      statGte: { stat: clarity, value: 6 }
    effects:
      - { type: open_response_window, windowId: breakthrough }
    cue: "The moment is ready. A breakthrough card can be played this turn."

  # ─── Priority 10 — Default catchall ──────────────────────────────────────
  - id: bm_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: momentum, amount: -1 }
    cue: "The moment passes without full resolution. The run ends, for better or worse."
carryForwardRules:
  default:
    trustModifier: 0
    clarityModifier: 0
    tensionModifier: 0
  on_breakthrough:
    trustModifier: +2
    clarityModifier: +1
    note: >
      A breakthrough in the climactic encounter is the best possible run outcome.
      Both trust and clarity carry forward strongly, reflecting a changed relationship.
  on_partial:
    trustModifier: +1
    note: >
      A partial resolution at the climax still builds some foundation, but less
      than a full breakthrough.
  on_collapse:
    trustModifier: -2
    tensionModifier: +2
    note: >
      Collapsing the climactic encounter is the worst possible outcome.
      The damage carries forward strongly.
  on_stalemate:
    trustModifier: -1
    tensionModifier: +1
    note: >
      Stalemate at the climax feels like the relationship is permanently stuck.
      Negative carry-forward is mild but present.
breakthroughDefault: B-001
runPosition: last
```

---

## Design Notes

### What makes Breakthrough Moment mechanically distinct

1. **runPosition: last only.** This encounter is only surfaced as the final encounter of a run. It cannot appear in first or middle position. This enforces the narrative climax structure.

2. **Carry-forward state modifies starting stats at initialization.** Before the first player turn, the engine evaluates `runHasPositiveCarryForward` and `runHasNegativeCarryForward` and applies one-time stat modifications. This is the only encounter in v1 with this property. The positive/negative modifiers are:
   - **Net positive run:** `trust +1`, `clarity +1` (starting 5/4 → 6/5 effectively)
   - **Net negative run:** `trust −1`, `tension +1`, `guarded` keyword added (starting 5/3 → 4/6 effectively, plus keyword)
   - **Net neutral run:** no modifiers, base stats apply

3. **Breakthrough thresholds are the lowest in v1.** Trust 6, clarity 6, momentum 0 — deliberately easier than all other encounters because this is the payoff moment. If a player has reached this encounter with decent carry-forward state and reasonable stat levels, they should feel close to breakthrough.

4. **Three separate reaction rule sections by run state.** The reaction rules are split into positive-run, negative-run, and neutral-run branches. This means the same card package can produce dramatically different outcomes depending on run history. A `connect` play in a positive run (priority 85, +trust +1, +momentum, breakthrough armed) vs. a positive-run `recover` play (priority 85, +momentum +2) vs. a neutral-run `connect` play (priority 60, +trust +1 only) vs. a negative-run `pressure` play (priority 65, −trust −2, +tension +2 — collapse territory).

5. **Shared Victory (M-008) has maximum synergy here.** M-008 checks run result history for more breakthroughs than collapses and grants +1 clarity. In Breakthrough Moment, this synergy is most likely to activate, making M-008 an especially valuable card in the starter deck for runs that have gone well.

6. **The encounter's own carry-forward rules are more generous than other encounters.** On breakthrough: trust +2, clarity +1 (vs. +1/0 for most other encounters). On collapse: trust −2, tension +2 (worse than most other encounters). This amplifies the run-ending emotional stakes.

7. **Open_window and repairable keywords are present at start.** These keywords signal to the player that this encounter is designed to be solvable — the windows are open, the keywords are favorable. This contrasts with Old Grudge's misread/guarded/defensive starting keywords which signal difficulty.

8. **Breakthrough card is B-001 (Mutual Recognition) by default.** B-001 requires trust ≥ 7 and clarity ≥ 6 and a breakthrough window. Given the lower thresholds of the encounter (trust 6, clarity 6), the player may need one more connect + memory play to reach trust 7 before playing the breakthrough card — or the encounter may produce enough trust through positive-run connect rules to hit trust 7 naturally.

### Run state detection rules

The engine must compute run-level carry-forward state at the start of Breakthrough Moment:

```javascript
// Pseudocode for carry-forward detection
function computeRunCarryForward(runHistory) {
  let netTrust = 0;
  let netClarity = 0;
  let netTension = 0;

  for (const encounterResult of runHistory.encounterResults) {
    netTrust += encounterResult.carryForwardTrust || 0;
    netClarity += encounterResult.carryForwardClarity || 0;
    netTension += encounterResult.carryForwardTension || 0;
  }

  if (netTrust + netClarity - netTension > 0) return 'positive';
  if (netTrust + netClarity - netTension < 0) return 'negative';
  return 'neutral';
}
```

This computation runs once at encounter initialization and sets the encounter's `runCarryForwardState` field, which the reaction rules query.

### Encounter ordering and run configuration

For v1 flagship mode, runs should be configured to always end with Breakthrough Moment when the run reaches 5 encounters. The run position mapping should be:

| Encounter # | Encounter Type |
|---|---|
| 1 | Missed Signal |
| 2 | Public Embarrassment |
| 3 | Quiet Repair |
| 4 | Old Grudge |
| 5 | Breakthrough Moment |

If a run is configured for fewer encounters (e.g., 3-encounter short run), Breakthrough Moment should not appear. Only runs that reach the final slot get the climax encounter.

### Comparison with other v1 encounters

| Dimension | Quiet Repair | Old Grudge | Breakthrough Moment |
|---|---|---|---|
| Starting trust | 4 | 3 | 5 (±1 from carry-forward) |
| Starting clarity | 4 | 3 | 4 (±1 from carry-forward) |
| Starting tension | 4 | 6 | 5 (±1 from carry-forward) |
| Breakthrough trust | 7 | 7 | 6 |
| Breakthrough clarity | 6 | 7 | 6 |
| Breakthrough momentum | 1 | 1 | 0 |
| Carry-forward affects start | No | No | Yes |
| runPosition | middle | middle | last |
| Keywords | private, repairable, guarded | misread, guarded, defensive | repairable, open_window |
| Default breakthrough card | B-002 | B-003 | B-001 |

### What needs to be true for a breakthrough attempt

1. `breakthroughReady` must be set (typically by connect+memory or positive-run connect)
2. Trust must be at least 6 (encounter threshold) — but B-001 requires trust ≥ 7
3. Clarity must be at least 6
4. Momentum must be at least 0
5. The breakthrough response window must be open

The player who reaches Breakthrough Moment on a positive run with trust 6+ and clarity 6+ is genuinely close to breakthrough. The encounter is designed to reward that approach.

---

## Canonical file
`projects/emotion-cards-four/gdd/encounter-breakthrough-moment-design.md`
