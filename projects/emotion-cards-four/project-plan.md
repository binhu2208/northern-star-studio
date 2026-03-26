# Project Plan - Emotion Cards Four

## Project Overview
- **Project:** Emotion Cards Four
- **Proposal:** `docs/proposals/emotion-cards-four-project-proposal.md`
- **Created:** 2026-03-25
- **Status:** v1 implementation phase active — scope approved, tasks assigned

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
| MKT-003 | Define audience-fit testing, message testing, and pitch/hook refinement deliverables for prototype validation | Gabe (Analyst) | MKT-002 | Y | Completed |
| DES-001 | Define flagship mode rules, turn structure, scoring / resolution states, and sample session flow | Hideo (Designer) | None | Y | Completed |
| DES-002 | Create initial card taxonomy and first 20-30 card prototype list | Hideo (Designer) | DES-001 | Y | Completed |
| ART-001 | Create art scope sheet covering unique art count, portrait states, UI targets, VFX scope, localization constraints, and production assumptions | Yoshi (Artist) | DES-001, DES-002 | Y | Completed |
| ART-002 | Run one style exploration pass with concrete outputs: 1-3 visual directions, frame roughs, typography pairing, icon language sample, and one sample card mockup | Yoshi (Artist) | ART-001 | N | Completed |
| ART-003 | Build UI readability prototype targets for card size, hand size, keyword density, text load, safe areas, and controller/readability constraints | Yoshi (Artist) | ART-001, DES-002 | Y | Completed |
| ART-004 | Define reusable card frame / icon / UI component system requirements after style direction is selected | Yoshi (Artist) | ART-002, ART-003 | N | Completed |
| DEV-001A | Define prototype architecture baseline: encounter/opposition behavior, state flow, save assumptions, instrumentation needs, and implementation boundaries from flagship mode rules | John (Developer) | DES-001 | Y | Completed |
| DEV-001B | Define card schema / content integration requirements based on initial card taxonomy and prototype card list | John (Developer) | DEV-001A, DES-002 | Y | Completed |
| DEV-002 | Implement minimum playable prototype slice in `projects/emotion-cards-four/src/`: draw/play/discard loop, encounter state transitions, resolution handling, opposition behavior, and basic progression/save behavior | John (Developer) | DEV-001B | Y | Completed |
| QA-001 | Create prototype validation plan for comprehension, replay intent, audience fit, readability, and tone acceptance | Sakura (QA) | MKT-002, MKT-003, DES-001 | Y | Completed |
| QA-002 | Create state-transition, usability, and validation test cases for the prototype loop and task status readiness checks | Sakura (QA) | DEV-001B, QA-001 | Y | Completed |
| QA-003 | Execute prototype validation against the playable slice, record pass/fail results, log issues, and report findings | Sakura (QA) | DEV-002, QA-002 | Y | In Progress |
| PROD-001 | Consolidate approved planning inputs into v1 planning baseline | Shig (Producer) | MKT-002, MKT-003, DES-001, ART-001, DEV-001A, QA-001 | Y | Completed |
| PROD-002 | Assign implementation tasks for prototype build | Shig (Producer) | PROD-001 | Y | Completed |
| PROD-003 | Review project critical path and update plan after first planning submissions | Shig (Producer) | PROD-001 | Y | Completed |
| DEV-V1-003 | Implement BreakthroughManager: real condition evaluation against live encounter state, unlock conditions checked during resolution not at draw | John (Developer) | DEV-V1-002 | Y | Completed | |
| DEV-V1-004 | Create vocabulary.ts with all canonical constants + startup validation pass | John (Developer) | DEV-V1-002 | Y | Completed | |
| DEV-V1-005 | Implement encounter carry-forward with per-encounter rules, carry_forward effect type with encounter context, narrative flag hooks, reward choice UI support | John (Developer) | DEV-V1-003, DEV-V1-004 | Y | Pending |
| DEV-V1-006 | Build RunSummaryGenerator: structured report from event log | John (Developer) | DEV-V1-003 | Y | Completed | |
| DEV-V1-007 | Full UI integration: wire breakthrough/NAC/carry-forward to production UI, HUD refresh with NAC slot, save/resume stability pass | John (Developer) | DEV-V1-003, DEV-V1-004, DEV-V1-006, ART-V1-002 | Y | Pending |
| DES-V1-003 | Encounter template review: verify 5 templates from DES-V1-002 translate correctly to implementation, outcome evaluation logic verification | Hideo (Designer) | DEV-V1-005 | Y | Pending |
| DES-V1-003a | v1 card pool review: verify 16-card starter deck covers all 5 encounters adequately | Hideo (Designer) | DES-V1-002 | N | Completed | |
| DES-V1-004a | Card balance pass (design doc): 35-card review against DES-V1-002 taxonomy, runs parallel to DEV implementation | Hideo (Designer) | DES-V1-003, DES-V1-003a | N | Pending |
| DES-V1-004b | Card balance pass (post-implementation): confirm balance holds against actual engine behavior, only if needed after DES-V1-004a findings | Hideo (Designer) | DEV-V1-005 | N | Pending |
| ART-V1-002 | NAC component: 4 states (active rec, neutral, no signal, locked), signal-to-text mapping, run-state surface integration | Yoshi (Artist) | DEV-V1-007, Joint NAC Signal Spec | Y | Completed | | |
| ART-V1-003 | Card frame variant expansion: v1 frame families beyond prototype, portrait/emotion overlay system rollout | Yoshi (Artist) | ART-V1-002 | N | Pending |
| ART-V1-004 | Icon library expansion: new keyword/encounter state icons, consistent shape-first system | Yoshi (Artist) | ART-V1-003 | N | Pending |
| ART-V1-005 | HUD shell + tutorial UI: v1 HUD shell with NAC slot accommodation, first-session intro/tutorial on-ramp | Yoshi (Artist) | ART-V1-002 | Y | Pending |
| QA-V1-003 | v1 Gate 0-5 execution: browser-level validation mandatory, Issue #12 as named Gate 2 + Gate 4 pre-req, headless engine tests via GameEngine, evidence-based closure | Sakura (QA) | DEV-V1-007, ART-V1-005 | Y | Pending |
| MKT-V1-002 | v1 audience-fit validation: execute per market-brief.md path, shape report for store-page/pitch downstream use, track success/fail signals | Gabe (Analyst) | DEV-V1-007, QA-V1-003 | Y | Pending |

## Critical Path (v1 implementation)
v1 implementation critical path:

**DEV-V1-003 → DEV-V1-004 → DEV-V1-005 → DEV-V1-007 → QA-V1-003 → MKT-V1-002**

Supporting (can run in parallel):
- **DEV-V1-006** (gated on DEV-V1-003, gates MKT data pipeline)
- **DES-V1-003** (gated on DEV-V1-005)
- **DES-V1-004a** (gated on DES-V1-003, no DEV dependency — runs early)
- **ART-V1-002** (gated on DEV-V1-007 + Joint NAC Signal Spec)
- **ART-V1-005** (gated on ART-V1-002)

Art slip risk: ART-V1-002 and ART-V1-005 are explicit QA-V1-003 dependencies. If art slips, QA slips.

---

## Original Prototype Critical Path (completed)
Initial planning/prototype critical path has now been completed:

**DES-001 → DES-002 → DEV-001A → DEV-001B → DEV-002 → QA-002**

Supporting planning chain completed:

**MKT-002 → MKT-003 → QA-001 → PROD-001 → PROD-002**

Art/UX planning chain completed:

**DES-001 → DES-002 → ART-001 → ART-003 → ART-004**

Current active producer focus is no longer unlocking the first slice, but managing review, next assignments, and preventing stale-task drift on follow-on implementation work.

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
- MKT-003 completed on 2026-03-25; QA-001 unlocked and activated immediately after messaging-plan check-in.
- QA-001 completed on 2026-03-25; QA-002 remains pending on DEV-001B, and PROD-001 remains gated by ART-001 and DEV-001A completion.
- ART-001 completed on 2026-03-25; ART-002 and ART-003 unlocked and activated immediately after art scope check-in. PROD-001 is now gated only by DEV-001A completion.
- ART-003 completed on 2026-03-25; ART-004 remains gated only by ART-002 completion.
- ART-002 completed on 2026-03-25; ART-004 unlocked and activated immediately after style-pass check-in.
- DEV-001A completed on 2026-03-25; DEV-001B unlocked and activated immediately after architecture-baseline check-in. PROD-001 is now active because all required planning inputs are complete.
- ART-004 completed on 2026-03-25; the art planning lane is fully complete for the current planning baseline.
- DEV-001B completed on 2026-03-25; DEV-002 and QA-002 unlocked and activated immediately after schema/integration check-in.
- QA-002 completed on 2026-03-25; executable prototype test cases are now in place for implementation follow-up and readiness checks.
- DEV-002 completed on 2026-03-25; the minimum playable prototype slice is now checked into the repo and ready for producer consolidation and next-step review.
- QA-003 added on 2026-03-25 to execute the actual prototype validation against the landed slice and report findings.
- PROD-001 completed on 2026-03-25 with `projects/emotion-cards-four/production/v1-planning-baseline.md` as the consolidated producer baseline.
- PROD-002 completed on 2026-03-25 by assigning the next implementation/build tasks off the baseline as dependencies cleared.
- PROD-003 completed on 2026-03-25 by updating the project plan and critical-path status after first prototype submissions.
- Producer follow-up rule strengthened: when work has enough material to land, expected owner response is either completed with path + commit or blocked with exact blocker.
- v1 implementation scope approved by Lead on 2026-03-25.
- DEV-V1-003 and DEV-V1-004 noted as running in parallel on 2026-03-25.
- John flagged DEV-V1-006 (RunSummaryGenerator) gates MKT-V1-002 data pipeline — added to critical path as supporting task between DEV-V1-003 and DEV-V1-007.
- Yoshi flagged ART-V1-002 depends on Joint NAC Signal Spec with John before full execution — added as inline dependency.
- DES-V1-004 split into early doc pass (DES-V1-004a, no DEV dep) and post-impl confirmation (DES-V1-004b) to keep design unblocked.
- MKT-V1-002 output format: validation report shaped for store-page/pitch downstream use per Gabe.
- QA-V1-003 scope: browser-level + headless engine tests via GameEngine; tooling needs to confirm with John before execution.
- ART slip risk: ART-V1-002/ART-V1-005 on QA critical path — monitor closely.
