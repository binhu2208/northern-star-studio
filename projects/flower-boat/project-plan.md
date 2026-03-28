# Project Plan - Flower Boat

## Project Overview
- **Project:** Flower Boat
- **Status:** Pre-production — core loop validated, moving to polish phase
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
| FB-P005 | Digital prototype dev (shell + state machine) | John (Dev) | FB-P004 (parallel) | Y | Completed — `513e7e`, port 8766 |
| FB-P006 | Design review (spec + shell merge) | Hideo + John | FB-P004, FB-P005 | Y | Completed — data bugs fixed |
| FB-P007 | Bin playtest | Bin | FB-P006 | Y | Completed — clean run, no P0 bugs |
| FB-P008 | Weather-affinity mechanic: spec + implement | Hideo (Design) + John (Dev) | FB-P007 | Y | Completed — `a6f732b`, port 8766 |
| FB-P009 | Expand flower pool (4 → 7) | Hideo (Design) + John (Dev) | FB-P007 | Y | Completed — `d808efb`, 7 flowers live |
| FB-P010 | Fix weather mechanic legibility + add planning step | John (Dev) | FB-P009 | Y | Completed — `6025aec` |
| FB-D001 | Internal QA recheck (navigation + weather + planning) | Sakura (QA) | FB-P010 | Y | Completed — `360b868` |
| FB-P011 | Visual direction doc | Yoshi (Art) | None | Y | Completed — `2a81dd6`, visual-direction.md |
| FB-P012 | UI polish against visual direction | John (Dev) | FB-P011 | Y | In Progress |
| FB-P013 | React architecture proposal | Abec | None | Y | Pending |
| FB-P014 | Player testing (1-3 informal sessions) | Sakura + Bin | FB-P011, FB-P012 | Y | Pending — Bin must recruit players |
| FB-P015 | Content expansion roadmap | Hideo (Design) | None | Y | Completed — `265c1c0`, content-expansion-roadmap.md |

## Notes

- Bin approved proceeding 2026-03-26
- Core loop confirmed working — Bin's playtest: clean run, no P0 bugs
- Bin feedback: flowers need weather associations, more variety needed
- Weather mechanic promoted from deferred → core feature
- Visual direction locked: flat illustration, Unpacking meets A Short Hike, warm natural palette — `2a81dd6`
- Sequence: Visual direction → UI polish → player testing → content expansion
- Player testing blocked: only Bin can recruit external players
- Abec joining as React consultant — proposal pending

## Validation Approach (Gabe)

- **Week 1-2:** Concept test — 3-5 screenshots + GIF, post to r/cozygaming and indie dev Discord
- **Month 1:** Paper prototype — spreadsheet inventory × customer matrix, 5-8 target players
- **Month 2-3:** Vertical slice — one canal district, 3 weather states, one customer type, 8-10 flowers

## Risk Profile

- Genre needs TikTok/IG momentum to breakout — moderate risk
- "Influencing customers" drifts into complex economics — low risk
- Base loop feels thin without seasonal content — low-moderate risk
- Overall: Low-to-moderate risk
