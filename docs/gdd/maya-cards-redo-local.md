# Maya Cards Redo (Local Draft — Do Not Push)

Goal: rework Maya into a clearer, more cohesive character with a strong emotional arc, cleaner mechanics, and tighter card identity.

## Maya Core Identity

**Emotion Family:** Warmth  
**Theme:** Reconciliation without erasing hurt  
**Playstyle:** Sustain, reflection, conversion, emotional balance  
**Mechanical Identity:** Maya does not overpower through raw damage. She stabilizes, transforms negative states, and gains bonuses when she bridges emotion families instead of committing to just one.

## Signature Mechanics

### 1. Reflection
Some Maya cards gain bonus effects if you played a card from a different emotion family this turn.
- Purpose: makes Maya feel like the emotional center of the cast
- Encourages thoughtful sequencing rather than brute-force comboing

### 2. Comfort
A soft sustain mechanic.
- Comfort is a temporary resource that can become shield, healing, or card draw
- Unlike Ember's Heat, Comfort reduces volatility and rewards patience

### 3. Reframe
Convert a negative status or drawback into a smaller positive effect.
- Example: remove Vulnerable, gain 2 Comfort
- Lets Maya play into healing/transformation instead of denial

## Maya Emotional Arc

1. **Resentment** — carrying the wound
2. **Doubt** — questioning the story she told herself
3. **Remembering** — reconnecting with what was real, not just what hurt
4. **Vulnerability** — risking openness
5. **Understanding** — seeing complexity instead of blame
6. **Reconciliation** — connection without pretending nothing happened

---

## Card Set (20 Cards)

## Phase 1 — Resentment

### 1. Unfair Burden
- Cost: 1
- Effect: Deal 5 damage. If you have no Comfort, gain 1 Comfort.
- Role: basic opener, establishes “hurt but still human.”

### 2. Closed Door
- Cost: 1
- Effect: Gain 6 shield.
- If Reflection triggers, draw 1.
- Role: defensive baseline.

### 3. Bitter Rehearsal
- Cost: 1
- Effect: Deal 3 damage. The next card from a different family costs 1 less.
- Role: bridges Maya into mixed-emotion play.

### 4. Tight Chest
- Cost: 0
- Effect: Gain 2 Comfort.
- Role: cheap setup and stabilization.

## Phase 2 — Doubt

### 5. Maybe I Missed Something
- Cost: 1
- Effect: Draw 2, discard 1. If you discarded a Shadow or Fire card, gain 1 Comfort.
- Role: deck smoothing and introspection.

### 6. Unsteady Ground
- Cost: 2
- Effect: Apply Weak to an enemy. Gain 4 shield.
- Role: slows combat, creates breathing room.

### 7. What If It Wasn't That Simple
- Cost: 2
- Effect: Reframe 1 negative status on yourself. Draw 1.
- Role: introduces Maya’s conversion identity.

## Phase 3 — Remembering

### 8. Grandmother's Hands
- Cost: 2
- Effect: Heal 5. Gain 1 Comfort.
- If Reflection triggers, heal 3 more.
- Role: core sustain anchor.

### 9. Shared Silence
- Cost: 1
- Effect: Gain 5 shield. Next turn, gain 1 card draw.
- Role: delayed, calm value.

### 10. Old Studio Light
- Cost: 2
- Effect: Gain 2 Comfort. Your next attack deals +4 damage.
- Role: memory as direction, not just nostalgia.

### 11. Clay Memory
- Cost: 1
- Effect: Return a discarded card to hand. It costs 1 less this turn.
- Role: recursion and emotional continuity.

## Phase 4 — Vulnerability

### 12. Say It Anyway
- Cost: 1
- Effect: Lose 2 HP. Draw 2. Gain 2 Comfort.
- Role: vulnerability has a cost, but opens play.

### 13. Open Hands
- Cost: 2
- Effect: Remove one negative status from yourself. Gain 8 shield.
- If Reflection triggers, also gain 1 energy.
- Role: safe reset tool.

### 14. Tender Truth
- Cost: 2
- Effect: Deal 6 damage. Heal 4.
- Role: balanced offense/repair.

## Phase 5 — Understanding

### 15. Hold Two Things At Once
- Cost: 2
- Effect: Choose one:
  - Deal 8 damage
  - Heal 6 and gain 4 shield
- If Reflection triggers, gain both at half value.
- Role: encapsulates emotional complexity.

### 16. Reframe the Story
- Cost: 2
- Effect: Reframe all minor negative statuses. Gain 1 Comfort for each converted.
- Role: payoff for Maya’s identity.

### 17. Warm Table
- Cost: 1
- Effect: Gain 3 Comfort. Draw 1.
- Role: efficient setup and recovery.

## Phase 6 — Reconciliation

### 18. Make Space
- Cost: 2
- Effect: Gain 10 shield. The next enemy attack deals 50% less damage.
- Role: secure late-game stabilization.

### 19. Bittersweet Memory
- Cost: 2
- Effect: Draw 2. Heal 3. Deal 5 damage.
- Role: mixed value, emotionally accurate payoff.

### 20. Leave the Door Open
- Cost: 3
- Effect: Heal 8. Gain 8 shield. Your next 2 cards gain Reflection automatically.
- Role: signature finisher that invites connection instead of forcing it.

---

## Design Notes

### What changed from the earlier version
- Stronger **single character identity** instead of loosely grouped emotion-family bundles
- Cleaner **phase progression** tied to Maya’s internal arc
- Less generic damage/heal split; more cards now support a distinct **Reframe / Comfort / Reflection** engine
- Better separation from Ember:
  - Ember escalates through Heat and risk
  - Maya stabilizes and transforms
- Better separation from Wren:
  - Wren dwells in memory and grief accumulation
  - Maya moves toward integration and coexistence

### Why this version is stronger
- Maya now feels like the emotional “glue” character
- Her kit naturally rewards mixed-family play, which supports the broader game fantasy
- Her mechanics are understandable but still expressive
- The card names and effects tell a coherent story without reading like placeholders

## Implementation Suggestions
- Keep **Comfort** as a simple integer buff on character state
- Implement **Reflection** as a turn-level boolean check against the previously played card’s family
- Implement **Reframe** as a small utility function that converts one known debuff into shield/heal/Comfort

## Recommendation
If you want to compare model quality, compare this draft against the current Maya implementation for:
- thematic consistency
- card naming quality
- mechanic clarity
- uniqueness versus Ember/Wren

This draft is local-only and has not been pushed to GitHub.