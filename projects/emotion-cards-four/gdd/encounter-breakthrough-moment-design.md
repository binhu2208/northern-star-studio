# Encounter Template: Breakthrough Moment

## Metadata

| Field | Value |
|-------|-------|
| id | `breakthrough_moment` |
| name | Breakthrough Moment |
| category | climax |
| version | 1.0.0 |
| status | implemented |

## Prompt

Everything has been leading here. The real question is finally on the table, and how you got here matters.

## Keywords

- `repairable` — Initial. The situation is not beyond saving; repair is possible.
- `open_window` — Initial. A window to breakthrough has been opened.

## Run Position

**Last.** This encounter only appears as the final encounter in a run. There is no next encounter.

## Starting State

### Base Stats (Modified by Run Carry-Forward)

| Stat | Base Value |
|------|------------|
| tension | 5 |
| trust | 5 |
| clarity | 4 |
| momentum | 0 |

### Run Carry-Forward Initialization

At encounter creation, starting stats are modified based on run-level carry-forward state:

| Run State | Stat Modifications | Keyword Effect |
|-----------|-------------------|----------------|
| **Net positive** (breakthroughs > collapses) | +1 trust, +1 clarity | — |
| **Net negative** (collapses > breakthroughs) | -1 trust | gains `guarded` keyword |

### Active Windows

- `connect`
- `recover`
- `reframe`

### Visible Cues

> This is the encounter where it all comes together.

> Previous run history affects how this one plays out.

> A breakthrough is possible if you've built trust and clarity across the run.

## Thresholds

### Breakthrough (Lowest in v1)

| Stat | Threshold |
|------|-----------|
| trust | 6 |
| clarity | 6 |
| momentum | 0 |

### Collapse Conditions

Encounter collapses when **any** of the following are true:

1. `tension` reaches **10** and `trust` ≤ **2**
2. **Three failed plays** are recorded and `tension` ≥ **7**

## Carry-Forward Rules

> **Note:** This is the last encounter. Breakthrough carry-forward does not apply to a subsequent encounter but is recorded for run summary and post-run analysis.

| Outcome | Carry Forward |
|---------|---------------|
| Breakthrough | +2 trust, +1 clarity |
| Collapse | -2 trust, +2 tension |

---

## Reaction Rules

Rules are evaluated top-to-bottom (highest priority first). Rules marked **positive run only** or **negative run only** only evaluate if the run carry-forward state matches.

| Priority | Condition | Trigger | Effects | Notes |
|----------|-----------|---------|---------|-------|
| **85** | positive run | Card played | +1 trust, open **breakthrough window** immediately | Positive runs get a head start |
| **80** | negative run | Card played | +1 tension, -1 trust | Negative runs start harder |
| **70** | positive run | Card played | +1 clarity, +1 momentum | Momentum bonus for earned runs |
| **65** | any | Card has `connect` tag **and** memory category present | +1 trust, **breakthrough armed** | Core breakthrough trigger |
| **60** | any | Card has `recover` tag | +1 momentum, open **breakthrough window** | Recovery is rewarded here |
| **55** | any | Card has `stabilize` tag | -1 tension, +1 clarity | Tension relief and clarity gain |
| **50** | negative run | Card has `pressure` tag | -1 trust, +1 tension | Aggression is punished when run is already negative |
| **45** | positive run | Breakthrough is armed | Open **breakthrough window** | Confirms breakthrough for well-played runs |
| **30** | any | Card has `reframe` tag | +1 clarity, +1 momentum | Reframing advances both tracks |
| **10** | any | Default (no other rule matched) | -1 momentum | Progress stalls |

---

## Design Notes

This is the **climax encounter**. Its difficulty is dynamically adjusted by run history. Positive runs get easier (better starting stats, more reward rules fire). Negative runs get harder (worse starting state, more punishment rules).

### Run State Impact Summary

| Aspect | Positive Run | Negative Run |
|--------|-------------|--------------|
| Starting trust | base +1 | base -1 |
| Starting clarity | base +1 | base |
| Keywords | — | gains `guarded` |
| Priority 85 rule | Fires (+1 trust, breakthrough window) | Does not fire |
| Priority 80 rule | Does not fire | Fires (+1 tension, -1 trust) |
| Priority 70 rule | Fires (+1 clarity, +1 momentum) | Does not fire |
| Priority 50 rule | Does not fire | Fires on pressure (-1 trust, +1 tension) |
| Priority 45 rule | Fires if breakthrough armed | Does not fire |

### Expected Player Journey

1. Player arrives here having either built a positive run (breakthroughs > collapses) or struggled through a negative one.
2. **Positive run players** get immediate rewards: +1 trust and breakthrough window on first card (Priority 85), plus +1 clarity/+1 momentum (Priority 70). The run "climaxes" into breakthrough.
3. **Negative run players** face harder odds: -1 trust and +1 tension from the start (Priority 80). Breakthrough thresholds remain achievable but the path is narrower.
4. Both paths converge on the `connect` + memory combo (Priority 65) as the core breakthrough trigger — memory integration is the key unlock regardless of run state.
5. The breakthrough thresholds (trust 6, clarity 6, momentum 0) are intentionally the **lowest in v1**. The design intent is that a well-played run should reach breakthrough here. Negative runs may need to stabilize before pressing for it.

### Balancing Notes

- Base starting state (tension 5, trust 5, clarity 4, momentum 0) is balanced for a neutral run. Adjustments shift the challenge significantly.
- Three failed plays only collapse the encounter if tension ≥ 7, meaning early mistakes don't immediately doom a run.
- The `recover` tag (Priority 60) opens the breakthrough window, making recovery plays viable climax actions rather than "wasted" turns.

---

## Implementation Reference

```yaml
id: breakthrough_moment
keywords: [repairable, open_window]
runPosition: last
startingStats:
  tension: 5
  trust: 5
  clarity: 4
  momentum: 0
runCarryForwardInitialization:
  positiveRun:
    trust: +1
    clarity: +1
  negativeRun:
    trust: -1
    addKeyword: guarded
startingWindows: [connect, recover, reframe]
breakthroughThresholds:
  trust: 6
  clarity: 6
  momentum: 0
collapseConditions:
  - tension >= 10 and trust <= 2
  - failedPlays >= 3 and tension >= 7
carryForward:
  breakthrough: +2 trust, +1 clarity
  collapse: -2 trust, +2 tension
reactionRules:
  - priority: 85
    condition: positiveRun
    trigger: any
    effects:
      - trust: +1
      - openBreakthroughWindow: true
  - priority: 80
    condition: negativeRun
    trigger: any
    effects:
      - tension: +1
      - trust: -1
  - priority: 70
    condition: positiveRun
    trigger: any
    effects:
      - clarity: +1
      - momentum: +1
  - priority: 65
    condition: any
    trigger: connect and memory
    effects:
      - trust: +1
      - breakthroughArmed: true
  - priority: 60
    condition: any
    trigger: recover
    effects:
      - momentum: +1
      - openBreakthroughWindow: true
  - priority: 55
    condition: any
    trigger: stabilize
    effects:
      - tension: -1
      - clarity: +1
  - priority: 50
    condition: negativeRun
    trigger: pressure
    effects:
      - trust: -1
      - tension: +1
  - priority: 45
    condition: positiveRun
    trigger: breakthroughArmed
    effects:
      - openBreakthroughWindow: true
  - priority: 30
    condition: any
    trigger: reframe
    effects:
      - clarity: +1
      - momentum: +1
  - priority: 10
    condition: any
    trigger: default
    effects:
      - momentum: -1
```
