# DES-V1-002b — Old Grudge Encounter Template Design

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DES-V1-002b
- **Purpose:** Author the complete implementation-ready encounter template for Old Grudge
- **Status:** Draft — ready for implementation
- **Encounters reference:** `v1-card-taxonomy-and-encounter-templates.md` (DES-V1-002)
- **Design gap identified by:** `des-v1-003-encounter-template-verification.md` (DES-V1-003) — GAP 1

---

## Encounter 4 — Old Grudge

**v1 position:** Middle or last encounter
**Design intent:** History-heavy encounter where unresolved baggage makes the current situation harder to navigate. The player must navigate past old pain without triggering defensive collapse. Reveal plays are powerful but risky — they require memory support and trust scaffolding to land safely. Pressure plays are aggressively punished because the other party has deep walls up.

---

### Template

```yaml
id: old_grudge
name: Old Grudge
prompt: >
  Something from the past is being used against you in the present.
  The old wound is still open, and every move risks making it worse.
keywords: [misread, guarded, defensive]
startingStats:
  tension: 6
  trust: 3
  clarity: 3
  momentum: -1
startingWindows: [reveal, protect]
visibleCues:
  - "History is in the room. Be careful what you dig up."
  - "The other person is defensive — they've been hurt before by this."
  - "Direct confrontation will likely confirm their worst fears."
  - "Reveal requires trust scaffolding to land safely."
breakthroughThresholds:
  trust: 7
  clarity: 7
  momentum: 1
collapseConditions:
  - "Tension reaches 10 and trust is 2 or below"
  - "Three failed plays (encounter reaction was negative or momentum-negative)"
  - "Pressure play when trust is below 4 and encounter has guarded keyword"
turnPressureRules:
  description: >
    Standard v1 turn pressure applies (tension +1 after turn 4, per DES-V1-001).
    The misread keyword makes clarity failures especially costly — failed reveals
    without memory support drain both clarity and momentum simultaneously.
    The guarded keyword makes pressure plays catastrophic at trust < 4.
reactionRules:
  # ─── Priority 90 — Pressure hardens the wall ───────────────────────────────
  - id: og_pressure_punish
    priority: 90
    if: { packageHasTag: pressure }
    effects:
      - { type: modify_stat, stat: trust, amount: -2 }
      - { type: modify_stat, stat: tension, amount: 1 }
      - { type: add_modifier, modifierId: defensive_escalation, duration: encounter }
    cue: "Using old pain as leverage makes the wall higher. They were right not to trust you."

  # ─── Priority 80 — Reveal without scaffolding is dangerous ───────────────
  - id: og_reveal_unsupported_punish
    priority: 80
    if:
      packageHasTag: reveal
      not: { packageHasCategory: memory }
    effects:
      - { type: modify_stat, stat: clarity, amount: -1 }
      - { type: modify_stat, stat: momentum, amount: -1 }
    cue: "Raising the issue without context makes it feel like an accusation."

  # ─── Priority 75 — Reveal with memory support is the breakthrough path ─────
  - id: og_reveal_memory_reward
    priority: 75
    if:
      packageHasTag: reveal
      packageHasCategory: memory
    effects:
      - { type: modify_stat, stat: clarity, amount: 2 }
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: open_response_window, windowId: recover }
      - { type: set_breakthrough_ready, value: true }
    cue: "The shared context reframes the old wound. A real repair opening appears."

  # ─── Priority 70 — Protected honesty earns ground ─────────────────────────
  - id: og_protect_reward
    priority: 70
    if: { packageHasTag: protect }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: modify_stat, stat: tension, amount: -1 }
      - { type: open_response_window, windowId: reveal }
    cue: "Holding a boundary without attacking shows the walls aren't necessary."

  # ─── Priority 65 — Stabilize slowly earns back ground ─────────────────────
  - id: og_stabilize_reward
    priority: 65
    if: { packageHasTag: stabilize }
    effects:
      - { type: modify_stat, stat: tension, amount: -1 }
      - { type: open_response_window, windowId: recover }
    cue: "Slowing down signals that this time will be different."

  # ─── Priority 60 — Reframe gently can unlock misread ──────────────────────
  - id: og_reframe_unlock_misread
    priority: 60
    if: { packageHasTag: reframe }
    effects:
      - { type: modify_stat, stat: clarity, amount: 1 }
      - { type: remove_keyword, keyword: misread }
    cue: "The reinterpretation shifts the frame. The old story isn't the only one."

  # ─── Priority 55 — Shift card keyword removal is especially valuable ───────
  - id: og_shift_keyword_removal
    priority: 55
    if: { primaryToneTagIn: [guarded, defensive] }
    effects:
      - { type: modify_stat, stat: clarity, amount: 1 }
      - { type: modify_stat, stat: trust, amount: 1 }
    cue: "Shifting the emotional register lets something new land."

  # ─── Priority 10 — Default catchall ───────────────────────────────────────
  - id: og_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: momentum, amount: -1 }
      - { type: modify_stat, stat: clarity, amount: -1 }
    cue: "Without a clear approach, the old pattern repeats and the moment slips away."
carryForwardRules:
  default:
    trustModifier: 0
    clarityModifier: 0
    tensionModifier: 0
  on_breakthrough:
    trustModifier: +1
    note: "Breaking through old pain builds trust that carries forward."
  on_partial:
    trustModifier: 0
    note: "Partial resolution doesn't establish reliable forward momentum."
  on_collapse:
    trustModifier: -1
    tensionModifier: +1
    note: "Collapsing a grudge encounter leaves negative residue."
  on_stalemate:
    trustModifier: 0
    clarityModifier: -1
    note: "Stalemate in an old grudge feels like the problem is permanent."
breakthroughDefault: B-003
runPosition: middle
```

---

## Design Notes

### What makes Old Grudge mechanically distinct

1. **Three-keyword starting state:** `misread` + `guarded` + `defensive` means the player is operating in the worst combined configuration for clarity-building and trust-building simultaneously. Every play choice is high-stakes.

2. **Guarded keyword is a pressure trap:** Unlike Quiet Repair (which only activates guarded penalty on pressure plays), Old Grudge's guarded keyword creates a standing penalty — pressure plays at trust < 4 trigger collapse directly. This makes reading the stat line before any pressure play mandatory.

3. **Reveal has two distinct outcomes:** Without memory support, reveal is actively harmful (clarity −1, momentum −1). With memory support, it is the strongest play available (clarity +2, trust +1, breakthrough armed). The player must build toward a memory-supported reveal rather than trying to brute-force honesty.

4. **misread keyword interacts with reframe:** Since Old Grudge starts with `misread`, a well-timed reframe play removes it, which is mechanically distinct from other encounters where keyword removal is a nice-to-have rather than a core strategy.

5. **Defensive escalation modifier:** The pressure-punish rule adds a `defensive_escalation` modifier to the encounter for the remainder. This makes repeat pressure plays increasingly dangerous and creates an explicit "you made it worse" feedback loop.

6. **Highest breakthrough thresholds in v1:** Old Grudge requires trust 7, clarity 7, momentum 1 — matching Public Embarrassment on trust/clarity but requiring positive momentum. This makes it the hardest encounter to breakthrough unless the player has carefully built toward it.

7. **collapseConditions is unambiguous:** The pressure-play collapse when trust < 4 and guarded is present is an explicit trigger, not a soft danger. Players learn quickly that Old Grudge requires reading stat thresholds before committing to any play type.

### How this differs from Quiet Repair (Encounter 3)

| Dimension | Quiet Repair | Old Grudge |
|---|---|---|
| Starting trust | 4 | 3 |
| Starting clarity | 4 | 3 |
| Starting tension | 4 | 6 |
| Starting momentum | 0 | −1 |
| Keywords | private, repairable, guarded | misread, guarded, defensive |
| Best path | recover → reframe | reveal + memory → breakthrough |
| Pressure risk | trust < 5 collapses | trust < 4 collapses (harder to trigger) |
| misread keyword | absent | present (can be reframed away) |
| Clarity requirement | 6 | 7 |

### What needs to be true for a breakthrough attempt

1. Trust must be at least 7 (requires at least +4 net from starting 3)
2. Clarity must be at least 7 (requires at least +4 net from starting 3)
3. Momentum must be at least 1 (requires at least +2 net from starting −1)
4. `breakthroughReady` must be set (achieved by reveal+memory play, priority 75)

The player needs at least 3 successful substantial plays before breakthrough becomes achievable. This makes Old Grudge a late-blooming encounter — early plays should focus on stabilizing (protect, stabilize, reframe) before attempting the reveal+memory sequence.

---

## Canonical file
`projects/emotion-cards-four/gdd/encounter-old-grudge-design.md`
