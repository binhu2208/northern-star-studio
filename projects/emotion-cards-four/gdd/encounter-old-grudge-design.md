# Encounter Template: Old Grudge

## Metadata

| Field | Value |
|-------|-------|
| id | `old_grudge` |
| name | Old Grudge |
| category | core |
| version | 1.0.0 |
| status | implemented |

## Prompt

Something from the past is being used against you in the present, and the old wound is still open.

## Keywords

- `misread` — Initial. Player has misread the situation; signals were crossed in the past.
- `guarded` — Initial. The other party is not open; trust is low.
- `defensive` — Modifier (applied dynamically). Triggered by pressure plays; hardens the encounter.

## Starting State

### Stats

| Stat | Value |
|------|-------|
| tension | 6 |
| trust | 3 |
| clarity | 3 |
| momentum | -1 |

### Active Windows

- `reveal`
- `protect`

### Visible Cues

> History is in the room. Be careful what you dig up.

> Direct confrontation will likely make things worse. Repair requires trust first.

## Thresholds

### Breakthrough

| Stat | Threshold |
|------|-----------|
| trust | 7 |
| clarity | 7 |
| momentum | 1 |

### Collapse Conditions

Encounter collapses when **any** of the following are true:

1. `tension` reaches **10** and `trust` ≤ **2**
2. **Three failed plays** are recorded
3. A **pressure play** is made while `trust` < **4** and the `guarded` keyword is present

## Turn Pressure Rules

Standard v1 turn pressure applies. The `misread` keyword makes failed plays especially costly — treat any failed play as if it were two steps backward on the trust track when `misread` is present.

## Carry-Forward Rules

| Outcome | Carry Forward |
|---------|---------------|
| Breakthrough | +1 trust |
| Collapse | -1 trust, +1 tension |

---

## Reaction Rules

Rules are evaluated top-to-bottom (highest priority first). The first matching rule fires; subsequent rules are skipped.

| Priority | Trigger | Effects | Notes |
|----------|---------|---------|-------|
| **90** | Card has `pressure` tag | -2 trust, +1 tension, encounter gains `defensive` modifier | Guarded + defensive state amplifies aggression |
| **80** | Card has `reveal` tag **and** no memory category present | -1 clarity, -1 momentum | Reveal without support is costly here |
| **75** | Card has `reveal` tag **and** memory category present | +2 clarity, +1 trust, **breakthrough armed** | Core breakthrough path; safe route |
| **65** | Card has `protect` tag | +1 trust, open `recover` window | Repair-oriented play rewarded |
| **55** | Card has `stabilize` tag | +1 momentum | Breathing room |
| **45** | Card has `shift` tag **and** `misread` keyword is present | Remove `misread` keyword, +1 clarity | Correcting misread clears the penalty |
| **30** | Card has `recover` tag **and** breakthrough is armed | Open **breakthrough window** | Player earned the moment |
| **10** | Default (no other rule matched) | -1 momentum | Progress stalls |

---

## Design Notes

This encounter is about the danger of digging up history without support. The **reveal + memory** synergy is the only safe path to breakthrough. Pressure is heavily punished because the `guarded` + `defensive` state amplifies it into near-collapse territory.

### Expected Player Journey

1. Player starts with tension elevated (6) and trust low (3). The `misread` and `guarded` keywords signal that straightforward approaches will fail.
2. Early plays should build trust via `protect` before attempting `reveal`. `Reveal` without memory is punished (-1 clarity, -1 momentum).
3. Once memory is available, the reveal+memory combo (Priority 75) is the intended breakthrough engine: +2 clarity, +1 trust, breakthrough armed.
4. The `shift` + `misread` interaction (Priority 45) provides a secondary relief valve — correcting the misread clears the failed-play penalty.
5. Pressure is the worst option at any stage. Even with trust near 4, pressure risks triggering the collapse condition if `guarded` is still present.

### Balancing Notes

- Starting tension is intentionally high (6) to create urgency without immediate collapse risk.
- Breakthrough thresholds (trust 7, clarity 7, momentum 1) require multiple successful plays — no single card wins this.
- The collapse condition "pressure when trust < 4 and guarded" means players cannot shortcut with aggression; they must invest in repair first.

---

## Implementation Reference

```yaml
id: old_grudge
keywords: [misread, guarded]
startingStats:
  tension: 6
  trust: 3
  clarity: 3
  momentum: -1
startingWindows: [reveal, protect]
breakthroughThresholds:
  trust: 7
  clarity: 7
  momentum: 1
collapseConditions:
  - tension >= 10 and trust <= 2
  - failedPlays >= 3
  - pressurePlayed and trust < 4 and guarded present
carryForward:
  breakthrough: +1 trust
  collapse: -1 trust, +1 tension
reactionRules:
  - priority: 90
    trigger: pressure
    effects:
      - trust: -2
      - tension: +1
      - addKeyword: defensive
  - priority: 80
    trigger: reveal and not memory
    effects:
      - clarity: -1
      - momentum: -1
  - priority: 75
    trigger: reveal and memory
    effects:
      - clarity: +2
      - trust: +1
      - breakthroughArmed: true
  - priority: 65
    trigger: protect
    effects:
      - trust: +1
      - openWindow: recover
  - priority: 55
    trigger: stabilize
    effects:
      - momentum: +1
  - priority: 45
    trigger: shift and misread
    effects:
      - removeKeyword: misread
      - clarity: +1
  - priority: 30
    trigger: recover and breakthroughArmed
    effects:
      - openBreakthroughWindow: true
  - priority: 10
    trigger: default
    effects:
      - momentum: -1
```
