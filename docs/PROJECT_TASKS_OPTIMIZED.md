# Project Task Tracker: Emotion Cards (Optimized)
**Project:** Emotion Cards (Roguelike Deckbuilder)  
**Status:** Active — Optimized for Parallelism  
**Start Date:** March 14, 2026  
**Target Launch:** August 2026 (5 months)  
**Maintained by:** Shig (Producer)

---

## Phase 1 Complete ✅ (Mar 17, 2026)

| Task ID | Description | Assigned To | Status | Delivered |
|---------|-------------|-------------|--------|-----------|
| DES-001A | Core mechanics | Hideo | ✅ | docs/gdd/emotion-cards-core-mechanics.md |
| DES-001B | Character arc | Hideo | ✅ | docs/gdd/character-arc.md |
| DES-001C | Enemy types | Hideo | ✅ | docs/gdd/des-001c-enemy-types.md |
| DEV-001A | Card system | John | ✅ | src/card-system/ |
| DEV-001B | Combat/AI/Damage | John | ✅ | src/combat/ |
| DEV-001C | Win/lose conditions | John | ✅ | src/combat/ |
| ART-001A | Card frames | Yoshi | ✅ | assets/ui/ |
| ART-001B | Ember cards 1-6 | Yoshi | ✅ | docs/gdd/ember-*.md |
| QA-001 | Playtest plan | Sakura | ✅ | docs/qa/playtest-plan.md |
| QA-002 | Test scenarios | Sakura | ✅ | tests/qa/ |
| MKT-000 | Market research | Gabe | ✅ | research/ |
| MKT-001A | Steam prep | Gabe | ✅ | docs/marketing/ |
| MKT-003 | Discord/Social/Press | Gabe | ✅ | docs/marketing/ |

---

## Phase 2 Complete ✅ (Mar 17, 2026)

| Task ID | Description | Assigned To | Status | Delivered |
|---------|-------------|-------------|--------|-----------|
| DES-002 | 3 characters, 60 cards | Hideo | ✅ | docs/gdd/tide-character.md, wren-character.md, frost-character.md |
| DEV-002 | 3 characters playable | John | ✅ | src/characters/maya/, ember/, wren/ |
| ART-002 | 60 emotion cards | Yoshi | ✅ | assets/characters/, docs/gdd/ember-*.md |
| QA-003 | Balance testing | Sakura | ✅ | tests/qa/balance-*.md |
| MKT-001B | Steam page live | Gabe | ✅ | docs/marketing/steam-*.md |

---

## Phase 3: Production (Weeks 6-14)

### Status Legend
- 🔴 Blocked — Needs escalation
- 🟢 Completed — Done, deliverables submitted
- 🟡 In Progress — Confirmed, actively working
- ⚪ Ready — Task created, waiting for dependencies

---

## Phase 1: Foundation (Weeks 1-2) — Maximize Parallelism

### Week 1 (Mar 14-21) — 3 Parallel Tracks

**Track A: Design (Hideo)**
| Task ID | Description | Duration | Dependencies |
|---------|-------------|----------|--------------|
| DES-001A | Core mechanics: Emotion card system, basic rules | 4 days | None |
| DES-001B | Character arc: 1 full emotional journey | 3 days | DES-001A |
| DES-001C | Card list: 20 cards for prototype | 2 days | DES-001A |

**Track B: Code (John)**
| Task ID | Description | Duration | Dependencies |
|---------|-------------|----------|--------------|
| DEV-000 | Project setup: Godot 4 scaffolding | 2 days | None |
| DEV-001A | Card system: Draw, play, discard mechanics | 3 days | DEV-000 + DES-001A |
| DEV-001B | Emotion effects: Joy, Grief, Memory, Regret | 3 days | DEV-001A |
| DEV-001C | Win/lose conditions: Core loop complete | 2 days | DEV-001B |

**Track C: Art (Yoshi)**
| Task ID | Description | Duration | Dependencies |
|---------|-------------|----------|--------------|
| ART-000 | Art direction: Mood board, style guide | 3 days | None |
| ART-001A | Card frames: UI template, layout | 2 days | ART-000 + DES-001A |
| ART-001B | 5 sample cards: Joy, Grief, Memory, Regret, Hope | 3 days | ART-001A |

**Track D: QA (Sakura)**
| Task ID | Description | Duration | Dependencies |
|---------|-------------|----------|--------------|
| QA-001 | Playtest plan: Metrics, recruitment strategy | 7 days | None |
| QA-002 | Test cases: Scenarios for prototype validation | 3 days | DES-001A |

**Track E: Marketing (Gabe)**
| Task ID | Description | Duration | Dependencies |
|---------|-------------|----------|--------------|
| MKT-000 | Market research: Comp analysis, positioning | 5 days | None |
| MKT-001A | Steam prep: Store page draft, description | 3 days | MKT-000 + ART-001B |

---

## Phase 2: Vertical Slice (Weeks 3-5)

**Goal:** 3 characters, 60 cards, full emotional arc

| Task ID | Description | Assigned | Duration | Dependencies |
|---------|-------------|----------|----------|--------------|
| DES-002 | Expand GDD: 3 characters, 60 cards | Hideo | 10 days | Phase 1 complete |
| DEV-002 | Vertical slice: 3 characters playable | John | 15 days | DES-002 |
| ART-002 | Full card set: 60 emotion cards | Yoshi | 15 days | DES-002 |
| QA-003 | Balance testing: Difficulty, card power | Sakura | 10 days | DEV-002 |
| MKT-001B | Steam page: Live with art, trailer script | Gabe | 7 days | ART-002 |

---

## Phase 3 Complete ✅ (Mar 17, 2026)

| Task ID | Description | Assigned To | Status | Delivered |
|---------|-------------|-------------|--------|-----------|
| DES-003 | 6 characters, 150 cards | Hideo | ✅ | docs/gdd/des-003-wrapup.md |
| DEV-003 | Full game implementation | John | ✅ | src/gameplay/, src/characters/, src/encounters/ |
| ART-003 | Production art, UI polish | Yoshi | ✅ | assets/, docs/art/ |
| QA-004 | Bug fixing, balance, polish | Sakura | ✅ | tests/qa/qa-004-*.md |
| MKT-002 | Creator outreach | Gabe | ✅ | docs/marketing/creator-outreach-list.md |
| DEV-004 | Portability prep | John | ✅ | src/platform/ |

---

## Phase 4: Launch (Month 5)

**Goal:** 6 characters, 150+ cards, full narrative

| Task ID | Description | Assigned | Duration | Dependencies |
|---------|-------------|----------|----------|--------------|
| DES-003 | Final GDD: 6 characters, 150 cards | Hideo | 20 days | Phase 2 complete |
| DEV-003 | Production: Full game implementation | John | 60 days | DES-003 |
| ART-003 | Production art: 150 cards, UI polish | Yoshi | 60 days | DES-003 |
| QA-004 | Full QA: Bug fixing, balance, polish | Sakura | 60 days | DEV-003 |
| MKT-002 | Creator outreach: Influencers, press | Gabe | 30 days | MKT-001B |
| DEV-004 | Switch porting | John | 30 days | QA-004 |

---

## Phase 4: Launch (Month 5)

| Task ID | Description | Assigned | Duration | Dependencies |
|---------|-------------|----------|----------|--------------|
| MKT-003 | Launch campaign: Trailers, press, community | Gabe | 30 days | QA-004 |
| QA-005 | Launch day support | Sakura | 14 days | Launch |
| DEV-005 | Post-launch patches | John | 30 days | Launch |

**Launch Day:** August 18, 2026

---

## Parallelism Analysis

### Phase 1 (Week 1)
**Before Optimization:** 2 parallel tasks (Hideo + Sakura)  
**After Optimization:** 5 parallel tracks (Hideo, John, Yoshi, Sakura, Gabe)

**Key Improvements:**
- John starts immediately (project setup) — no wait for GDD
- Yoshi starts art direction immediately — no wait for full GDD
- Gabe starts market research — no wait for art
- Hideo delivers core mechanics first (4 days) — unblocks others faster

### Dependency Graph (Optimized)
```
Week 1:
[Hideo: DES-001A] ──┬──→ [John: DEV-001A] ──→ [John: DEV-001B]
                    ├──→ [Yoshi: ART-001A] ──→ [Yoshi: ART-001B]
                    └──→ [Sakura: QA-002]

[John: DEV-000] ────┘ (parallel, no dependency)
[Yoshi: ART-000] ───┘ (parallel, no dependency)
[Gabe: MKT-000] ────┘ (parallel, no dependency)
[Sakura: QA-001] ───┘ (parallel, no dependency)
```

---

## Team Review Request

**@Hideo @John @Yoshi @Sakura @Gabe — Please review this optimized plan:**

1. **Are the task breakdowns realistic?** Can you complete your sub-tasks in the time allocated?
2. **Are there more parallel opportunities?** Can any of your tasks overlap more?
3. **Are dependencies correct?** Do you actually need [X] before starting [Y]?
4. **Any missing tasks?** What did we forget?

**Reply with:**
- ✅ Looks good — no changes needed
- 🟡 Concerns — [specific issues]
- 🔴 Blockers — [what prevents this plan from working]

Let's maximize our velocity! 🚀

---

## GitHub Webhook Workflow

**When team pushes empty commit with status:**
```bash
git commit --allow-empty -m "@Shig [DES-001A] Complete - core mechanics doc in /docs/gdd/"
git push
```

**Shig's automatic response:**
1. Webhook arrives in #build-feedback
2. Parse commit message for `[TASK-ID]` and status
3. Update PROJECT_TASKS.md
4. Check if dependent tasks can now be assigned
5. Assign ready tasks via sessions_send

---

## Notes

- All tasks use 5-minute timeout (300 seconds) per Bin's instruction
- Critical path tasks flagged 🔴 in Priority column
- Float calculated: LS - ES (Late Start - Early Start)
- Float = 0 → Task is on critical path
- GitHub webhooks handle routine updates — heartbeat for exceptions only

---

*Optimized for maximum parallelism. Team review in progress.* 📋
