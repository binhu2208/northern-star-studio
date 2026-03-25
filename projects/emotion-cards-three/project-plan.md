# Project Plan - Emotion Cards Three

## Project Overview
- **Project:** Emotion Cards Three
- **Proposal:** https://github.com/NorthernStar-Studio/northern-star-studio/blob/main/docs/proposals/emotion-cards-three-proposal.md
- **Created:** 2026-03-24
- **Status:** Draft

## Tasks

| ID | Task | Owner | Dependencies | Critical | Status |
|----|------|------|--------------|----------|--------|
| MKT-004 | Create concept-validation / prototype brief with success criteria | Gabe | None | Y | 🟢 Completed |
| DES-001 | Define core emotional-state model with one concrete gameplay loop and screenshot-form emotion-state examples | Hideo | MKT-004 | Y | 🟢 Completed |
| ART-001 | Create early visual readability guide: card rules, icon draft, state color/shape system, screenshot legibility checklist | Yoshi | DES-001 | Y | 🟢 Completed |
| DEV-001 | Prototype one playable combat scenario with emotional state system | John | DES-001 | Y | 🟢 Completed |
| DEV-002 | Implement placeholder state UI and readability support for the prototype scenario | John | DEV-001, ART-001 | Y | 🟢 Completed |
| DES-002 | Define minimum vertical-slice scope and one polished archetype path | Hideo | DES-001, DEV-001 | Y | 🟢 Completed |
| QA-001 | Define first-session usability goals and readability test checks | Sakura | MKT-004 | Y | 🟢 Completed |
| QA-002 | Validate prototype against tactical clarity, fast state recognition, likely gameplay impact recognition, readability, and onboarding criteria | Sakura | DEV-002, QA-001, ART-001 | Y | 🟢 Completed |
| FIX-001 | Address prototype validation findings and tighten scope/handoff gaps before greenlight review | John | QA-002, DES-002 | Y | 🟢 Completed |
| MKT-005 | Prepare one-line pitch, screenshot hook target, and short combat clip criteria using readability outputs | Gabe | MKT-004, ART-001, DES-002 | N | 🟢 Completed |
| PROD-001 | Consolidate prototype findings, critical path, and greenlight recommendation | Shig | FIX-001, MKT-005 | Y | ⚪ Ready |

## Critical Path Notes
Current longest dependency chain:
MKT-004 → DES-001 → ART-001 → DEV-002 → QA-002 → FIX-001 → PROD-001

Supporting critical chain:
MKT-004 → DES-001 → DEV-001 → DEV-002 → QA-002 → FIX-001 → PROD-001

Critical tasks are marked **Y** because delay in those tasks delays prototype validation and greenlight readiness. ART-001 and QA-001 are now treated as critical because readability and first-session validation directly affect whether the prototype can be evaluated credibly.

### Status Legend
- ⚪ Ready — Task is ready to be assigned
- 🔴 Pending — Task is pending on dependencies to be clear up
- 🟡 In Progress — Confirmed, actively working
- 🟢 Completed — Done, deliverables submitted

## Notes
- Plan is intentionally scoped around concept validation and a vertical-slice decision, not full production.
- Greenlight gates should prove: one tactically meaningful emotional mechanic, one readable screenshot, one short readable combat clip, and strong first-session comprehension.
- Readability/UI is treated as core gameplay work, not polish.
- Readability exploration starts earlier so art guidance can influence prototype presentation before validation.
- A small fix/iteration loop is included before final greenlight review so findings can be addressed instead of only reported.
