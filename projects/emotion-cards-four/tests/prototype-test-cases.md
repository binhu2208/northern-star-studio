# Emotion Cards Four - Prototype Test Cases

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** QA-002
- **Purpose:** Convert prototype validation goals and gameplay rules into executable QA test cases for the first playable slice
- **Status:** Draft for active production use
- **References:**
  - `projects/emotion-cards-four/tests/prototype-validation-plan.md`
  - `projects/emotion-cards-four/src/card-schema-and-content-integration.md`
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
  - `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`

---

## 1. Test Execution Notes

### Pass / Fail note format
For each case, record:
- **Pass:** Expected result happened without moderator rescue, debug intervention, or contradictory UI/state output
- **Fail:** Expected result did not happen, required explanation, produced contradictory state/result feedback, or blocked valid play
- **Notes:** Exact cards used, encounter state before/after, and whether failure was logic, UI, copy, or usability

### Default setup assumptions
Unless a case overrides them:
- build includes flagship mode `Emotion Encounter`
- a playable encounter can be launched with visible or inspectable state
- package rules follow prototype defaults:
  - exactly 1 primary card required
  - optional 1 support card
  - no breakthrough card unless surfaced or unlocked
- encounter states are inspectable through UI or QA debug view:
  - Tension
  - Trust
  - Clarity
  - Momentum
  - Open response windows
  - Encounter keywords / penalties

---

## 2. State Transition and Package Legality Cases

### QA-002-TC-01 - Valid primary-only response package
**Purpose:** Confirm a legal turn can be submitted with exactly one primary card.

**Setup:** Start any encounter with a hand containing one legal Emotion or Reaction card.

**Steps:**
1. Begin player turn at `Play Response`
2. Select one Emotion or Reaction card as primary
3. Submit without support card

**Expected Results:**
- play is accepted
- turn resolves without validation error
- state changes are applied and shown
- played card moves to discard unless retained by effect

---

### QA-002-TC-02 - Reject package with no primary card
**Purpose:** Verify package validation blocks empty or support-only submission.

**Setup:** Start turn with at least one Memory or Shift card in hand.

**Steps:**
1. Attempt to submit no card
2. Attempt to submit only a Memory card
3. Attempt to submit only a Shift card

**Expected Results:**
- each invalid submission is rejected before state mutation
- player receives readable validation message
- machine/debug reason identifies missing legal primary

---

### QA-002-TC-03 - Reject illegal double-primary package
**Purpose:** Ensure two-primary combinations are blocked.

**Setup:** Hand contains two primary-legal cards.

**Steps:**
1. Select one Emotion card as primary
2. Select one Reaction card as second card
3. Attempt to submit as one package

**Expected Results:**
- package is rejected
- error explains slot/package restriction
- no stats, tags, or windows change

---

### QA-002-TC-04 - Accept legal primary + support package
**Purpose:** Confirm standard two-card package resolves correctly.

**Setup:** Hand contains a legal pair such as `Concern` + `Old Promise`.

**Steps:**
1. Select primary card
2. Select one support card
3. Submit package

**Expected Results:**
- package is accepted
- primary and support effects resolve in correct order
- synergy is evaluated if conditions are met
- explanation identifies both cards and resulting changes

---

### QA-002-TC-05 - Reject breakthrough card before unlock
**Purpose:** Verify breakthrough cards are not playable through normal hand rules.

**Setup:** Surface a breakthrough card in a test environment without meeting unlock conditions.

**Steps:**
1. Attempt to play `B-001`, `B-002`, or `B-003` as part of a normal package

**Expected Results:**
- play is rejected
- error states card is unavailable / not unlocked / not surfaced
- no encounter state changes

---

### QA-002-TC-06 - State transition after successful trust-building play
**Purpose:** Confirm a straightforward connect line changes state predictably.

**Setup:** Encounter with low-to-medium tension, medium trust, low clarity; hand contains `Concern` + `Old Promise`.

**Steps:**
1. Submit `Concern` + `Old Promise`
2. Observe state before reaction
3. Observe state after encounter reaction

**Expected Results:**
- Trust increases
- Clarity improves when pair condition is met
- Tension does not spike from this package in a compatible encounter
- explanation reflects why trust/clarity changed

---

### QA-002-TC-07 - Risk rule escalation on poor-fit aggressive play
**Purpose:** Verify risky pressure cards punish bad context.

**Setup:** Encounter has low trust, low clarity, or `heated`; hand contains `Anger` or `Pressure Back`.

**Steps:**
1. Play aggressive pressure card in poor-fit state
2. Observe immediate effects and encounter reaction

**Expected Results:**
- tension increases or reaction worsens
- triggered penalty or escalation is explained
- outcome path becomes visibly riskier

---

### QA-002-TC-08 - Failed validation must not mutate state
**Purpose:** Confirm rejected plays are side-effect free.

**Setup:** Capture pre-submit values for all visible state axes and windows.

**Steps:**
1. Attempt an illegal package
2. Compare state after rejection

**Expected Results:**
- no stat, keyword, hand, discard, or window change caused by failed submission
- only validation feedback is emitted

---

## 3. Card Category and Synergy Comprehension Cases

### QA-002-TC-09 - Emotion + Memory synergy is readable
**Purpose:** Validate a core synergy pair both functions and reads clearly.

**Setup:** Encounter suited to connective play; hand contains `Concern` + `Old Promise`.

**Steps:**
1. Review both cards before play
2. Submit pair
3. Ask tester to explain why the pair helped

**Expected Results:**
- synergy bonus occurs if conditions match
- tester can describe effect in plain language
- summary mentions both trust-building and context support

---

### QA-002-TC-10 - Reaction + Memory opens safer repair line
**Purpose:** Confirm memory-backed honesty or repair lines are understandable.

**Setup:** Encounter contains `misread` or guarded context; hand contains `Guarded Honesty` plus a relevant Memory card.

**Steps:**
1. Play the pair
2. Observe state changes, window changes, and follow-up options

**Expected Results:**
- clarity improves
- safer dialogue / repair / open window appears when conditions are met
- player can identify that memory support made honesty safer

---

### QA-002-TC-11 - Shift card changes response availability
**Purpose:** Verify Shift cards do more than generic stat changes.

**Setup:** Encounter has `misread` or `defensive` penalty; hand contains `Change of Lens`.

**Steps:**
1. Observe current blocked or penalized state
2. Play `Change of Lens` with a legal primary
3. Inspect changed keywords/windows

**Expected Results:**
- relevant keyword penalty is reduced or removed
- response window or state readability improves
- effect is described as reframing, not hidden math only

---

### QA-002-TC-12 - Conditional card behavior respects requirements
**Purpose:** Confirm conditional effects only trigger when actual conditions are met.

**Setup:** Prepare one state where a condition is true and one where it is false.

**Steps:**
1. Play a conditional card in valid state
2. Replay in invalid state
3. Compare effects

**Expected Results:**
- bonus appears only in valid condition
- non-trigger case still resolves base effect cleanly
- explanation distinguishes base effect from conditional bonus

---

## 4. Result-State Legibility Cases

### QA-002-TC-13 - Breakthrough outcome is understandable
**Purpose:** Validate players can tell why breakthrough happened.

**Setup:** Prepare encounter near breakthrough threshold with a valid breakthrough route.

**Steps:**
1. Play the enabling package or surfaced breakthrough
2. End resolution and observe final result
3. Ask tester what caused the breakthrough

**Expected Results:**
- result state displays as `Breakthrough`
- explanation references relevant state conditions or unlock
- tester can explain the cause without guesswork

---

### QA-002-TC-14 - Partial Resolution remains distinguishable from Breakthrough
**Purpose:** Ensure near-success outcomes are legible and not confused with best result.

**Setup:** Prepare encounter that advances but leaves unresolved tension or ambiguity.

**Steps:**
1. Play a decent but not optimal package
2. Observe end state

**Expected Results:**
- result is explicitly `Partial Resolution`
- remaining unresolved factors are indicated
- feedback communicates progress without full success

---

### QA-002-TC-15 - Collapse is legible and causally traceable
**Purpose:** Verify loss state teaches the player what went wrong.

**Setup:** Low trust, high tension, or repeated misplays; hand includes poor-fit pressure option.

**Steps:**
1. Submit high-risk poor-fit package
2. Observe reaction and result
3. Ask tester what caused collapse

**Expected Results:**
- result shows `Collapse`
- immediate cause is visible in state/reaction/explanation
- player can identify at least one contributing mistake or mismatch

---

### QA-002-TC-16 - Stalemate is not confused with bug or soft lock
**Purpose:** Confirm low-progress outcomes still read as valid game states.

**Setup:** Encounter state supports neutral/no-advance path.

**Steps:**
1. Play non-advancing but legal packages
2. Resolve to stalemate

**Expected Results:**
- result displays as `Stalemate`
- player understands progress stopped rather than system failed
- next-state or carry-forward consequence is shown

---

## 5. Readability and Usability Cases

### QA-002-TC-17 - Turn-one comprehension without explanation
**Purpose:** Test first-session onboarding clarity.

**Setup:** New tester, first launch, no verbal rules explanation.

**Steps:**
1. Show starting encounter and hand
2. Ask tester to begin turn unaided
3. Observe hesitations and incorrect assumptions

**Expected Results:**
- tester can identify goal and first actionable step
- tester can distinguish playable primary cards from support cards
- tester does not require rules rescue to start the first turn

---

### QA-002-TC-18 - Card purpose is inferable from card text and layout
**Purpose:** Validate that card hierarchy supports quick reads.

**Setup:** Present a mixed hand from at least three categories.

**Steps:**
1. Ask tester to sort cards by likely role before playing
2. Ask which card seems safest, riskiest, and most supportive

**Expected Results:**
- player can roughly infer category and likely use
- card layout and wording reduce role confusion
- major misunderstandings are logged as readability defects

---

### QA-002-TC-19 - State-change feedback after play is readable
**Purpose:** Verify players can tell what changed after submitting a package.

**Setup:** Any legal turn resolution with visible before/after state.

**Steps:**
1. Submit a package
2. Ask tester what changed
3. Compare response with actual state changes

**Expected Results:**
- tester can identify key changes in trust, tension, clarity, momentum, or response windows
- system highlights the most important state shifts
- player does not need debug-only info to understand the outcome

---

### QA-002-TC-20 - Text density does not block decision-making
**Purpose:** Catch excessive wording or hierarchy problems.

**Setup:** Present a hand with dense or conditional cards.

**Steps:**
1. Ask tester to choose a play under normal pace
2. Record rereads, stalls, and misreads

**Expected Results:**
- player can compare options without repeated full rereads
- decision time remains reasonable for first-session play
- overloaded cards are easy to identify for revision

---

## 6. Validation and Audience-Fit Cases

### QA-002-TC-21 - Player can explain what makes the game different
**Purpose:** Check emotional-strategy differentiation.

**Setup:** Run a short prototype session, then debrief.

**Steps:**
1. Ask “What feels different here from other card games?”
2. Capture exact wording

**Expected Results:**
- player mentions some version of emotions, context, trust/tension, or meaning-driven choices
- player does not describe the game as generic card combat with renamed stats

---

### QA-002-TC-22 - Replay intent is concrete, not polite
**Purpose:** Separate genuine replay pull from vague approval.

**Setup:** End a short run or encounter sequence.

**Steps:**
1. Ask whether the tester would play again now
2. Ask what they would try differently next time

**Expected Results:**
- tester gives a concrete reason to replay or retry
- vague “maybe” feedback is logged separately from positive replay intent

---

### QA-002-TC-23 - Tone is accepted as game framing, not therapy framing
**Purpose:** Ensure emotional language lands correctly.

**Setup:** Complete a short session and debrief.

**Steps:**
1. Ask how the emotional framing landed
2. Ask whether any wording felt preachy, vague, or therapy-coded

**Expected Results:**
- most responses are positive or neutral
- objections can be tagged as tone, not mechanics, if that is the real problem

---

### QA-002-TC-24 - Pitch and play experience do not mismatch badly
**Purpose:** Check expectation alignment between project messaging and prototype behavior.

**Setup:** Give tester the one-line prototype pitch before play.

**Steps:**
1. Capture expectation before play
2. Run a short session
3. Ask whether the experience matched the pitch

**Expected Results:**
- tester sees a clear relationship between promise and prototype
- expectation mismatches are specific and actionable

---

## 7. Readiness Checks
These checks determine whether the build is ready for broader validation rather than just technically runnable.

### QA-002-RC-01 - Package legality readiness
Build is ready only if:
- illegal packages are blocked consistently
- valid packages resolve consistently
- no failed validation mutates state

### QA-002-RC-02 - Result legibility readiness
Build is ready only if:
- Breakthrough, Partial Resolution, Stalemate, and Collapse are visibly distinct
- players can usually explain why a result happened

### QA-002-RC-03 - Readability readiness
Build is ready only if:
- players can identify what to do on turn one
- players can tell what changed after a turn
- repeated severe text or hierarchy blockers are limited

### QA-002-RC-04 - Validation readiness
Build is ready only if:
- the prototype can support moderated test sessions without constant rescue
- evidence capture for comprehension, replay intent, tone, and audience fit is practical
- failures can be logged against a specific cause category

### QA-002-RC-05 - Regression readiness
Build is ready only if:
- debug or QA-visible state allows verification of trust, tension, clarity, momentum, and windows
- deterministic behavior is strong enough that repeated scenarios can be retested reliably

---

## 8. Exit Criteria for QA-002
QA-002 should be considered satisfied when:
- the prototype has a concrete test case set for package validation, state transitions, result states, readability, and validation goals
- test cases can be executed repeatedly without inventing ad hoc steps each round
- readiness checks clearly separate “build exists” from “build is testable”

---

**Canonical file:** `projects/emotion-cards-four/tests/prototype-test-cases.md`
