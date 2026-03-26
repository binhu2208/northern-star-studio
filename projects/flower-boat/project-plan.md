# Project Plan - Flower Boat

## Project Overview
- **Project:** Flower Boat
- **Status:** Pre-production — concept approved, prototype pending
- **Concept brief:** Gabe (Market) + Hideo (Design) approved by Bin 2026-03-26

## Project Overview
- **Concept:** A meditative canal-cruising flower delivery game. Stock the boat, choose routes, read customers, suggest flowers, see consequences.
- **Core hook:** "I play this when I'm stressed." — personal resonance confirmed by Bin
- **Core mechanic:** Stock constraint (3 slots, 4 flower types) + reading customers + influence. Does the player feel like they're helping people find something they actually needed?

## Tasks

| ID | Task | Owner | Dependencies | Critical | Status |
|----|------|-------|--------------|----------|--------|
| FB-P001 | Paper prototype: 1 route, 4 customers, 3-slot stock, 1 weather state | Hideo (Design) | None | Y | Completed |
| FB-P002 | Paper prototype test with target players | Sakura (QA) | FB-P001 | Y | Superseded — moving to next phase without formal player test. Bin confirmed 2026-03-26. |
| FB-P003 | Prototype brief writeup (merged design + market) | Shig (Producer) | FB-P001, FB-P002 | Y | Completed |
| FB-P004 | Digital prototype UX spec | Hideo (Design) | None | Y | Completed — `16b6e83` |
| FB-P005 | Digital prototype dev (shell + state machine) | John (Dev) | FB-P004 (parallel) | Y | In Progress — shell started |
| FB-P006 | Design review (spec + shell merge) | Hideo + John | FB-P004, FB-P005 | Y | Pending |
| FB-P007 | Bin playtest | Bin | FB-P006 | Y | Pending |

## Notes

- Bin approved proceeding 2026-03-26
- Design brief: `projects/flower-boat/flower-boat-design-brief.md`
- Market brief: `projects/flower-boat/market-brief.md`
- Success criterion: Player feels like they were helping people find something they actually needed

## Validation Approach (Gabe)

- **Week 1-2:** Concept test — 3-5 screenshots + GIF, post to r/cozygaming and indie dev Discord
- **Month 1:** Paper prototype — spreadsheet inventory × customer matrix, 5-8 target players
- **Month 2-3:** Vertical slice — one canal district, 3 weather states, one customer type, 8-10 flowers

## Risk Profile

- Genre needs TikTok/IG momentum to breakout — moderate risk
- "Influencing customers" drifts into complex economics — low risk
- Base loop feels thin without seasonal content — low-moderate risk
- Overall: Low-to-moderate risk
