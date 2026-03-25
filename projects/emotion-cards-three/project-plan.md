# Project Plan - Emotion Cards Three

## Project Overview
- **Project:** Emotion Cards Three
- **Proposal:** https://github.com/NorthernStar-Studio/northern-star-studio/blob/main/docs/proposals/emotion-cards-three-proposal.md
- **Created:** 2026-03-24
- **Status:** Draft

## Tasks

| ID | Task | Owner | Dependencies | Critical | Status |
|----|------|------|--------------|----------|--------|
| MKT-004 | Create concept-validation / prototype brief with success criteria | Gabe | None | Y | ⚪ Ready |
| DES-001 | Define core emotional-state model with one concrete gameplay loop | Hideo | MKT-004 | Y | 🔴 Pending |
| DEV-001 | Prototype combat loop with emotional state system | John | DES-001 | Y | 🔴 Pending |
| DEV-002 | Implement placeholder UI for emotional states, card frames, and state readability | John | DEV-001 | Y | 🔴 Pending |
| DES-002 | Define minimum vertical-slice scope and one polished archetype path | Hideo | DES-001 | Y | 🔴 Pending |
| ART-001 | Create visual readability guide for cards, icons, and state UI | Yoshi | DES-002 | N | 🔴 Pending |
| QA-001 | Define first-session usability goals and readability test checks | Sakura | MKT-004 | N | 🔴 Pending |
| QA-002 | Validate prototype against tactical clarity, readability, and onboarding criteria | Sakura | DEV-002, QA-001 | Y | 🔴 Pending |
| MKT-005 | Prepare one-line pitch, screenshot hook target, and short combat clip criteria | Gabe | MKT-004, DES-002 | N | 🔴 Pending |
| PROD-001 | Consolidate prototype findings, critical path, and greenlight recommendation | Shig | QA-002, MKT-005 | Y | 🔴 Pending |

## Critical Path Notes
Current longest dependency chain:
MKT-004 → DES-001 → DEV-001 → DEV-002 → QA-002 → PROD-001

Critical tasks are marked **Y** because delay in those tasks delays prototype validation and greenlight readiness.

### Status Legend
- ⚪ Ready — Task is ready to be assigned
- 🔴 Pending — Task is pending on dependencies to be clear up
- 🟡 In Progress — Confirmed, actively working
- 🟢 Completed — Done, deliverables submitted

## Notes
- Plan is intentionally scoped around concept validation and a vertical-slice decision, not full production.
- Greenlight gates should prove: one tactically meaningful emotional mechanic, one readable screenshot, one short readable combat clip, and strong first-session comprehension.
- Readability/UI is treated as core gameplay work, not polish.
