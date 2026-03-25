# Project Plan - Emotion Cards Four

## Project Overview
- **Project:** Emotion Cards Four
- **Proposal:** `docs/proposals/emotion-cards-four-project-proposal.md`
- **Created:** 2026-03-25
- **Status:** Draft

## Planning Assumptions
- Concept direction is approved.
- Schedule / timeline lock is **not** approved yet.
- Early work is focused on flagship-mode validation, scope definition, and production-risk reduction.
- PC / Steam-first prototype path.
- Project structure created at `projects/emotion-cards-four/`.
- Market/message testing, audience-fit validation, and pitch-hook refinement are part of the planning baseline, not implied side work.

## Tasks

| ID | Task | Owner | Dependencies | Critical | Status |
|----|------|------|--------------|----------|--------|
| MKT-002 | Refine audience framing, flagship mode messaging, validation criteria, and product positioning into a short market brief | Gabe (Analyst) | None | Y | Completed |
| MKT-003 | Define audience-fit testing, message testing, and pitch/hook refinement deliverables for prototype validation | Gabe (Analyst) | MKT-002 | Y | In Progress |
| DES-001 | Define flagship mode rules, turn structure, scoring / resolution states, and sample session flow | Hideo (Designer) | None | Y | Completed |
| DES-002 | Create initial card taxonomy and first 20-30 card prototype list | Hideo (Designer) | DES-001 | Y | Completed |
| ART-001 | Create art scope sheet covering unique art count, portrait states, UI targets, VFX scope, localization constraints, and production assumptions | Yoshi (Artist) | DES-001, DES-002 | Y | In Progress |
| ART-002 | Run one style exploration pass with concrete outputs: 1-3 visual directions, frame roughs, typography pairing, icon language sample, and one sample card mockup | Yoshi (Artist) | ART-001 | N | Pending |
| ART-003 | Build UI readability prototype targets for card size, hand size, keyword density, text load, safe areas, and controller/readability constraints | Yoshi (Artist) | ART-001, DES-002 | Y | Pending |
| ART-004 | Define reusable card frame / icon / UI component system requirements after style direction is selected | Yoshi (Artist) | ART-002, ART-003 | N | Pending |
| DEV-001A | Define prototype architecture baseline: encounter/opposition behavior, state flow, save assumptions, instrumentation needs, and implementation boundaries from flagship mode rules | John (Developer) | DES-001 | Y | In Progress |
| DEV-001B | Define card schema / content integration requirements based on initial card taxonomy and prototype card list | John (Developer) | DEV-001A, DES-002 | Y | Pending |
| DEV-002 | Implement minimum playable prototype slice in `projects/emotion-cards-four/src/`: draw/play/discard loop, encounter state transitions, resolution handling, opposition behavior, and basic progression/save behavior | John (Developer) | DEV-001B | Y | Pending |
| QA-001 | Create prototype validation plan for comprehension, replay intent, audience fit, readability, and tone acceptance | Sakura (QA) | MKT-002, MKT-003, DES-001 | Y | Pending |
| QA-002 | Create state-transition, usability, and validation test cases for the prototype loop and task status readiness checks | Sakura (QA) | DEV-001B, QA-001 | Y | Pending |
| PROD-001 | Consolidate approved planning inputs into v1 planning baseline | Shig (Producer) | MKT-002, MKT-003, DES-001, ART-001, DEV-001A, QA-001 | Y | Pending |
| PROD-002 | Assign implementation tasks for prototype build | Shig (Producer) | PROD-001 | Y | Pending |
| PROD-003 | Review project critical path and update plan after first planning submissions | Shig (Producer) | PROD-001 | Y | Pending |

## Critical Path (current)
Current longest dependency chain:

**DES-001 → DES-002 → DEV-001A → DEV-001B → DEV-002 → QA-002**

Supporting critical planning chain:

**MKT-002 → MKT-003 → QA-001 → PROD-001 → PROD-002**

Additional production-risk chain:

**DES-001 → DES-002 → ART-001 → ART-003 → ART-004**

These tasks are marked critical because delay in rules definition, card taxonomy, technical architecture, validation framing, or art scope definition will delay prototype execution and schedule confidence.

## Parallelism Notes
Tasks intentionally parallelized to reduce waiting:
- **MKT-002** and **DES-001** can start immediately in parallel.
- **DEV-001A** can start as soon as flagship mode rules are defined.
- **MKT-003** can proceed after the market brief without waiting for full implementation.
- **QA-001** can begin once market/design framing is stable, before implementation.
- **ART-001** starts after flagship mode definition and initial card taxonomy exist, reducing blind estimation.

## Deliverables by Role
- **Analyst:** market brief, validation framing, audience-fit testing, message testing, pitch-hook refinement
- **Designer:** flagship mode rules, resolution states, prototype card taxonomy and card list
- **Artist:** art scope sheet, style exploration outputs, readability targets, UI/component-system requirements
- **Developer:** architecture baseline, card/content integration requirements, minimum playable prototype slice
- **QA:** prototype validation plan and concrete test cases
- **Producer:** consolidated planning baseline, task assignment, critical-path updates

## Engineering / Planning Risks
- If **DES-001** or **DES-002** are completed at a high level without enough implementation detail, engineering can stall even when tasks appear technically complete.
- If **ART-001** starts before actual card taxonomy exists, art scope estimates will be weak and schedule confidence will be fake.
- If market/message validation is treated as implied work instead of explicit deliverables, the project can drift into build-first / positioning-later mistakes.

## Status Legend
- ⚪ Ready — Task is ready to be assigned
- 🔴 Pending — Task is pending on dependencies to be cleared
- 🟡 In Progress — Confirmed, actively working
- 🟢 Completed — Done, deliverables submitted

## Notes
- This project plan is intentionally front-loaded toward validation and risk reduction.
- Milestone 1 should prove the flagship mode before broad feature expansion.
- Store/trailer preparation should not move forward until the concept-validation gate is passed.
- No final schedule commitment should be made until art scope, rules clarity, and prototype architecture are defined.
- Lead approved the project on 2026-03-25.
- Producer activated execution by assigning MKT-002 and DES-001 and marking them In Progress on 2026-03-25.
- MKT-002 completed on 2026-03-25; MKT-003 unlocked and activated immediately after market brief check-in.
- DES-001 completed on 2026-03-25; DES-002 and DEV-001A unlocked and activated immediately after rules doc check-in.
- DES-002 completed on 2026-03-25; ART-001 unlocked and activated immediately after taxonomy check-in. ART-003 remains pending on ART-001.
