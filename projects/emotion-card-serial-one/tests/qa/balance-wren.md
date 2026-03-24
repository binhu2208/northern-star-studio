# Balance Report: Wren Character Deck (Shadow/Grief)

**Character:** Wren  
**Theme:** Grief & Memory  
**Emotion Family:** Shadow  
**Total Cards:** 20  
**Analyst:** Sakura 🌸  
**Date:** 2026-03-17  
**Status:** Draft for Review

---

## Executive Summary

Wren's deck has significant balance issues across all 5 phases. Many cards lack concrete数值 (damage/energy values), and several mechanics don't translate well to a turn-based card game. **Estimated 70% of cards need redesign or rebalancing.**

---

## Phase Analysis

### Phase 1: Denial (Cards 1-4)

| Card | Concept | Issues |
|------|---------|--------|
| **Pretend** | Ignore damage for a turn | ⚠️ Needs cost/value - "ignore damage" is powerful, needs 2-3 energy cost |
| **Everything's Fine** | Heal, but delay the cost | ⚠️ Unclear: delayed heal is weak, delayed damage is confusing |
| **Photo Album** | Draw cards, but gain no benefit | ❌ **Major issue** - "draw but no benefit" is a dead draw. Redesign to "draw, next card costs 0" or add benefit |
| **Ghost** | Summon memory token that fades | ⚠️ Token system not defined. Needs clear: duration, effect, fade mechanic |

**Phase 1 Assessment:** Underpowered. Photo Album is actively harmful to play.

---

### Phase 2: Weight (Cards 5-10)

| Card | Concept | Issues |
|------|---------|--------|
| **Heavy Heart** | Gain defense, lose speed | ❌ **Major issue** - Speed/slow has no meaning in turn-based. Replace with HP + draw penalty |
| **Anchor** | Prevent movement, protect | ⚠️ "Movement" not defined in card system |
| **Sinking** | Take damage to remove debuffs | ⚠️ Unclear if beneficial - need specific values |
| **Gravity** | Pull everything down | ⚠️ Vague effect, needs definition |
| **Burden** | Trade HP for card advantage | ⚠️ Could work, needs: cost 1, draw 2, take 2 damage |
| **Stone** | Immovable but slow | ❌ Same issue as Heavy Heart - "slow" meaningless in turn-based |

**Phase 2 Assessment:** Mechanically confused. Speed mechanics don't fit the system.

---

### Phase 3: Haunting (Cards 11-15)

| Card | Concept | Issues |
|------|---------|--------|
| **Memory Strike** | Damage based on cards played | ⚠️ Needs formula: damage = cards_played × N (suggest 2×) |
| **Echo** | Repeat previous card effect | ⚠️ Very powerful if cheap (cost 0-1), weak if expensive (cost 2-3) |
| **Phantom Pain** | Delayed damage | ⚠️ Needs: cost 1, deal 4 damage in 2 turns OR cost 0, deal 3 next turn |
| **Reminiscence** | Look at top deck, put back | ⚠️ Weak card draw. Consider: "Look at 3, add 1 to hand" |
| **Hallucination** | Random effect | ❌ **Major issue** - RNG is anti-strategy, especially in cozy game |

**Phase 3 Assessment:** Most mechanically sound but needs values. Hallucination needs removal.

---

### Phase 4: Shadows to Wren (Cards 16-20)

| Card | Concept | Issues |
|------|---------|--------|
| **Acceptance** | Transform negative → positive | ⚠️ Needs definition: "Remove 1 debuff, gain 1 buff" with costs |
| **Flight** | Escape harm, leave weight behind | ⚠️ "Escape harm" = evasion? "Leave weight" = discard? Needs values |
| **Songbird** | Small, persistent, meaningful damage | ⚠️ "Persistent" = applies each turn? Cost 1, deal 2 each turn for 3 turns |
| **Legacy** | Cards gain power from memory tokens | ⚠️ Depends on Ghost token system - needs parallel implementation |
| **Carry Forward** | Heal based on cards played | ⚠️ Needs formula: heal = cards_played × N (suggest 1 HP per card) |

**Phase 4 Assessment:** Promising concepts but need concrete values and token system.

---

## Balance Issues Summary

### Critical Issues (Must Fix)

| Issue | Cards Affected | Recommendation |
|-------|---------------|----------------|
| **No damage/energy values** | All 20 cards | Assign costs 0-3, damage/heal values 1-10 |
| **Speed/slow mechanics don't work** | Heavy Heart, Stone | Replace with HP tradeoffs or turn skip |
| **Photo Album is a dead draw** | Photo Album | Redesign: "Draw 2, next draw costs 0" or similar |
| **Hallucination RNG** | Hallucination | Remove or replace with "Chaos" card with fixed effect |
| **Undefined mechanics** | Ghost, Anchor, Gravity | Define or remove from deck |

### Recommended Values (Based on Standard TCG Balance)

| Card Type | Energy Cost | Effect Range |
|-----------|-------------|--------------|
| Basic Attack | 1 | 3-5 damage |
| Strong Attack | 2 | 6-9 damage |
| Basic Heal | 1 | 3-5 HP |
| Strong Heal | 2 | 6-8 HP |
| Draw Card | 1 | Draw 1-2 |
| Defensive | 1-2 | Block 3-6 |
| Utility | 0-2 | Varies |

### Wren-Specific Recommendations

1. **Set energy at 3 per turn** (standard)
2. **Early cards (Phase 1-2):** Cost 0-1, weak effects, set up later cards
3. **Mid cards (Phase 3):** Cost 1-2, moderate effects, good value
4. **Late cards (Phase 4):** Cost 2-3, powerful effects, win condition

---

## Positive Notes

- **Arc theme is strong** — grief → acceptance is compelling
- **Card names are evocative** — great narrative feel
- **Legacy/Carry Forward** are excellent "finisher" concepts
- **Echo** has high skill ceiling potential

---

## Next Steps

1. **Assign concrete values** to all 20 cards (cost, damage, duration)
2. **Define or remove** speed-related mechanics
3. **Implement token system** for Ghost/Legacy cards
4. **Playtest** with actual values, iterate
5. **Consider Wren's starter deck** — which 5 cards does Wren start with?

---

## Appendix: Proposed Values (Draft)

| Card | Proposed Cost | Proposed Value | Notes |
|------|---------------|----------------|-------|
| Pretend | 2 | Block 5 | "Ignore damage" = block |
| Everything's Fine | 1 | Heal 4 (delayed 2 more next turn) | Risk/reward |
| Photo Album | 0 | Draw 2, next turn draw -1 | Setup card |
| Ghost | 1 | Create token (2 turns) | Token = block 2 each turn |
| Heavy Heart | 1 | Block 4, discard 1 | Replace speed loss |
| Anchor | 2 | Block 6, enemy can't attack next turn | Stun equivalent |
| Sinking | 1 | Remove all debuffs, take 3 | High risk/reward |
| Gravity | 2 | All take 2, draw 1 | AOE + draw |
| Burden | 1 | Draw 2, take 2 damage | Aggressive draw |
| Stone | 2 | Block 8, skip next turn | High block, costly |
| Memory Strike | 1 | Damage = cards played × 2 | Scales with deck |
| Echo | 1 | Repeat last card effect | Powerful combo |
| Phantom Pain | 1 | Deal 3 damage, 3 more next turn | Delayed burst |
| Reminiscence | 0 | Look at top 3, add 1 | Weak draw fix |
| Hallucination | 1 | Random: 2 damage OR draw 1 OR block 3 | Remove RNG later |
| Acceptance | 2 | Transform 1 debuff to buff | High utility |
| Flight | 1 | Evade next attack, draw 1 | Reactive |
| Songbird | 2 | Deal 2 each turn for 4 turns | Persistent damage |
| Legacy | 2 | +2 to all "memory" card effects | Buff card |
| Carry Forward | 2 | Heal = cards played × 1 | Scales |

---

*End of Balance Report*
