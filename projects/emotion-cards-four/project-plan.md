# Project Plan - Emotion Cards Four

## Project Overview
- **Project:** Emotion Cards Four
- **Proposal:** `docs/proposals/emotion-cards-four-project-proposal.md`
- **Created:** 2026-03-25
- **Status:** Draft

## Planning Assumptions
- Concept direction is approved.
- Schedule / timeline lock is **not** approved yet.
- Early work is focused on prototype validation, scope definition, and production-risk reduction.
- PC / Steam-first prototype path.
- Project structure created at `projects/emotion-cards-four/`.

## Tasks

| ID | Task | Owner | Dependencies | Critical | Status |
|----|------|------|--------------|----------|--------|
| MKT-002 | Refine audience framing, flagship mode messaging, and validation criteria into a short market brief | Gabe (Analyst) | None | Y | ready |
| DES-001 | Define flagship mode rules, turn structure, scoring / resolution states, and sample session flow | Hideo (Designer) | None | Y | ready |
| DES-002 | Create initial card taxonomy and first 20-30 card prototype list | Hideo (Designer) | DES-001 | Y | pending |
| ART-001 | Create art scope sheet covering unique art count, portrait states, UI targets, VFX scope, and localization constraints | Yoshi (Artist) | DES-001 | Y | pending |
| ART-002 | Run one style exploration pass for card/UI direction | Yoshi (Artist) | ART-001 | N | pending |
| ART-003 | Build UI readability prototype targets for card size, hand size, text density, and safe areas | Yoshi (Artist) | ART-001 | Y | pending |
| DEV-001 | Define prototype technical architecture: card data model, state flow, save assumptions, instrumentation needs | John (Developer) | DES-001, DES-002 | Y | pending |
| DEV-002 | Implement core prototype framework in `projects/emotion-cards-four/src/` | John (Developer) | DEV-001 | Y | pending |
| QA-001 | Create prototype validation plan for comprehension, replay intent, audience fit, and readability | Sakura (QA) | MKT-002, DES-001 | Y | pending |
| QA-002 | Create state-transition and usability test cases for prototype loop | Sakura (QA) | DEV-001, QA-001 | Y | pending |
| PROD-001 | Consolidate approved planning inputs into v1 planning baseline | Shig (Producer) | MKT-002, DES-001, ART-001, DEV-001, QA-001 | Y | pending |
| PROD-002 | Assign implementation tasks for prototype build | Shig (Producer) | PROD-001 | Y | pending |
| PROD-003 | Review project critical path and update plan after first planning submissions | Shig (Producer) | PROD-001 | Y | pending |

## Critical Path (current)
Current longest dependency chain:

**DES-001 → DES-002 → DEV-001 → DEV-002 → QA-002**

Supporting critical planning chain:

**DES-001 → ART-001 → ART-003 → PROD-001 → PROD-002**

These tasks are marked critical because delay in design definition, technical architecture, or art scope definition will delay prototype start and schedule confidence.

## Parallelism Notes
Tasks intentionally parallelized to reduce waiting:
- **MKT-002** and **DES-001** can start immediately in parallel.
- **QA-001** can begin once market/design framing is stable, before implementation.
- **ART-001** starts after flagship mode definition, without waiting for full engineering work.
- **DEV-001** starts once the rules and initial card taxonomy are defined.

## Deliverables by Role
- **Analyst:** market brief / validation framing
- **Designer:** flagship mode rules and prototype card set
- **Artist:** art scope sheet, style exploration, readability targets
- **Developer:** prototype architecture and framework
- **QA:** prototype validation and test cases
- **Producer:** consolidated planning baseline, task assignment, critical-path updates

## Status Legend
- ⚪ Ready — Task is ready to be assigned
- 🔴 Pending — Task is pending on dependencies to be clear up
- 🟡 In Progress — Confirmed, actively working
- 🟢 Completed — Done, deliverables submitted

## Notes
- This project plan is intentionally front-loaded toward definition and risk reduction.
- No final schedule commitment should be made until art scope, rules clarity, and prototype architecture are defined.
- Next producer action after plan review: assign all **Ready** tasks and update statuses to **In Progress**.
