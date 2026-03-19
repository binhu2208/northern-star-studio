# DEV-006A — Emotion Cards Implementation Milestone Proposal

**Milestone:** v0.6.0  
**Branch:** release/v0.6.0  
**Date:** March 19, 2026  
**Status:** Draft for Review

---

## 1. Overview

This milestone proposes the next engineering implementation phase for the Emotion Cards system, building on the v0.5.0 hotfix scaffolding work. The focus shifts from infrastructure fixes to **core card system completeness** — ensuring each character (Ember, Maya, Wren) has playable, balanced card kits that match their design documents.

---

## 2. Prior Work Context

### Completed in v0.5.0
- Wired `GameConfig.card_overrides` into `CardManager`
- Added `apply_config()` to character effect handlers
- Propagated config through `CombatGameplayLoop`
- Created Maya card design (20 cards, 6 phases)

### Known Gaps
- Card effects are not fully implemented for any character
- No playtest-validated balance data
- Missing save/load for active card states
- QA smoke tests lack character-specific coverage

---

## 3. Proposed Scope

### 3.1 Core Card System (Required)

| Task | Description | Est. Hours |
|------|-------------|------------|
| CARD-001 | Implement Ember card effects (20 cards from `ember-phase3-4-cards.md` + `ember-phase5-6-cards.md`) | 8 |
| CARD-002 | Implement Maya card effects (20 cards from `maya-cards-redo-local.md`) | 8 |
| CARD-003 | Implement Wren card effects (from `wren-character.md`) | 8 |
| CARD-004 | Add emotion family system (Warmth, Shadow, Fire, Storm) with resonance/conflict logic | 6 |
| CARD-005 | Integrate Reflection mechanic for Maya | 4 |
| CARD-006 | Integrate Comfort/Reframe mechanics for Maya | 4 |

### 3.2 Combat Integration (Required)

| Task | Description | Est. Hours |
|------|-------------|------------|
| COMBAT-001 | Wire card effects into `CombatGameplayLoop` play resolution | 4 |
| COMBAT-002 | Add status effect system (Weak, Vulnerable, etc.) | 6 |
| COMBAT-003 | Implement Energy/Emotion Capacity system | 4 |
| COMBAT-004 | Connect turn-based card play flow with UI | 6 |

### 3.3 Save/Load (Required)

| Task | Description | Est. Hours |
|------|-------------|------------|
| SAVE-001 | Persist active card effects across encounters | 4 |
| SAVE-002 | Add deck state to run progression | 4 |

### 3.4 QA & Polish (Required)

| Task | Description | Est. Hours |
|------|-------------|------------|
| QA-001 | Create character-specific smoke tests (Ember/Maya/Wren) | 4 |
| QA-002 | Balance pass on starter decks | 8 |
| QA-003 | Add card art placeholders or placeholder colored boxes | 2 |

---

## 4. Dependencies

| Dependency | Blocks |
|------------|--------|
| v0.5.0 hotfix config wiring | CARD-001 through CARD-006 |
| Character designs in GDD | CARD-001, CARD-002, CARD-003 |
| Damage engine (v0.5.0) | COMBAT-002, COMBAT-003 |
| UI card display system | COMBAT-004 |
| Save/load scaffolding (v0.5.0) | SAVE-001, SAVE-002 |

**No external dependencies** — all required artifacts exist in the repo.

---

## 5. Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Card balance requires playtesting | High | Medium | Plan for iterative balance passes post-implementation |
| Emotion family resonance logic is complex | Medium | Medium | Implement core resonance first, add conflict/transmutation later |
| Character effect handlers diverge in architecture | Medium | High | Standardize on a base class pattern before implementing |
| Save state for active cards is tricky | Medium | Medium | Limit scope to deck-level persistence initially |

---

## 6. Effort Estimate

| Phase | Hours |
|-------|-------|
| Core Card System | 42 |
| Combat Integration | 20 |
| Save/Load | 8 |
| QA & Polish | 18 |
| **Total** | **88 hours** |

---

## 7. Release Criteria

- [ ] Ember has 20+ playable cards with functional effects
- [ ] Maya has 20+ playable cards with Reflection/Comfort/Reframe mechanics
- [ ] Wren has playable card kit
- [ ] Emotion family resonance triggers on 3+ cards from same family
- [ ] Cards can be played, resolved, and discarded in combat
- [ ] Deck persists across encounters
- [ ] Basic smoke tests pass for all three characters
- [ ] No game-breaking bugs in card play flow

---

## 8. Out of Scope (v0.6.0)

- Narrative integration (dialogue choices driven by deck)
- Complex transmutation (Anger + Time = Understanding)
- Achievement/unlock system
- Full UI polish
- Multiplayer or co-op
- End-game "breakthrough" states

---

## 9. Next Steps

1. **Review** — Share this proposal with Shig/Bin for scope approval
2. **Branch** — Create `release/v0.6.0` from `release/v0.5.0`
3. **Sprint 1** — Implement Ember card effects + basic combat integration
4. **Sprint 2** — Implement Maya + Wren card effects
5. **Sprint 3** — Emotion family logic + save/load
6. **Sprint 4** — QA pass + smoke tests + balance

---

**Prepared by:** John  
**Git identity:** John <john@northernstar.studio>
