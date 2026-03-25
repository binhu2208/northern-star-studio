# Emotion Cards Four - Prototype Validation Plan

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** QA-001
- **Purpose:** Define how the first playable prototype will be validated for comprehension, replay intent, audience fit, readability, and tone acceptance
- **Status:** Draft for active production use
- **Dependencies satisfied by:**
  - `projects/emotion-cards-four/production/market-brief.md`
  - `projects/emotion-cards-four/production/prototype-validation-messaging-plan.md`
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
- **Canonical proposal reference:** `docs/proposals/emotion-cards-four-project-proposal.md`

---

## 1. Validation Goal
This plan exists to answer one practical question:

**Does the first prototype communicate and deliver the intended experience clearly enough to justify broader implementation and deeper playtesting?**

The first validation round is not meant to prove long-term balance, content breadth, or retention. It is meant to catch whether the prototype is understandable, readable, tonally acceptable, and interesting enough to replay.

---

## 2. Core Validation Questions
The first playable slice should let QA, design, product, and marketing answer these five questions:

### 2.1 Comprehension
Can a new player explain:
- what this game is,
- what they do each turn,
- and what makes it different from a generic card battler?

### 2.2 Replay Intent
After one short run, do players want to:
- try another run,
- explore a different emotional approach,
- or see another encounter outcome?

### 2.3 Audience Fit
Does the prototype land with the intended overlap of:
- strategy / deckbuilder-curious players,
- narrative / reflective players,
- and mixed casual groups?

### 2.4 Readability
Can players quickly parse:
- card roles,
- card text,
- encounter state,
- result-state feedback,
- and what changed after a play?

### 2.5 Tone Acceptance
Does the game feel emotionally intelligent and intentional rather than:
- vague,
- preachy,
- awkward,
- too soft,
- or accidentally therapy-coded?

---

## 3. What This Validation Round Covers

### In scope
- first-session understanding
- flagship mode readability
- emotional-strategy differentiation
- replay curiosity
- message / expectation alignment
- player reaction to tone and framing
- major usability blockers that prevent valid feedback

### Out of scope
- final balance
- long-run progression depth
- content quantity validation
- final art polish sign-off
- economy tuning
- completion-rate metrics for a full production build

---

## 4. Prototype Assumptions Under Test
This plan assumes the first playable slice is trying to prove the promise defined in the design docs:

> a readable encounter-based emotional card game where player choices shape tension, trust, clarity, momentum, and outcome quality.

Validation should specifically test whether players can recognize that:
- emotions are gameplay, not just flavor,
- encounters react to the player’s tone and context,
- the prototype supports multiple valid emotional approaches,
- outcome states are legible enough to learn from.

---

## 5. Target Test Segments

### Segment A - Strategy / Card-Game Familiar
Players who regularly play deckbuilders, tactical card games, roguelikes, or systems-heavy strategy games.

**Why include them**
- they will expose whether the mechanics are legible,
- they will quickly detect shallow or muddy state logic,
- they are useful for testing differentiation versus familiar genre expectations.

**Target count:** 4-6 participants

### Segment B - Narrative / Reflective Players
Players who respond strongly to story, character, emotional framing, or cozy / meaning-driven games.

**Why include them**
- they test whether the tone feels appealing rather than performative,
- they reveal whether the prototype feels emotionally readable,
- they help test whether the game sounds interesting outside genre-native strategy spaces.

**Target count:** 4-6 participants

### Segment C - Mixed Casual / Group-Friendly Players
Players with uneven strategy depth who are closer to a broader social audience.

**Why include them**
- they reveal onboarding friction fast,
- they expose where wording is too designer-facing,
- they are a useful reality check for accessibility and audience-fit claims.

**Target count:** 2-4 participants

### Minimum useful sample
- **10 total sessions minimum**
- with at least:
  - **4 strategy-familiar players**
  - **4 narrative / reflective players**

---

## 6. Test Method

### Preferred format
- **Moderated sessions** for the first validation round
- **30-45 minutes per participant**

### Session structure
1. **Intro / context** - 2 minutes
2. **Pre-play expectation check** - 3 minutes
3. **Unassisted first look** - 2-3 minutes
4. **Prototype play** - 15-20 minutes
5. **Immediate debrief** - 8-10 minutes
6. **Short survey / score capture** - 3-5 minutes

### Moderator rules
- let the player think aloud
- do not explain intended meaning unless they are fully blocked
- capture exact player wording where possible
- separate confusion caused by wording from confusion caused by mechanics
- treat “interesting idea” and “I want another run” as different signals

---

## 7. Test Scenarios

### Scenario 1 - First Impression and Game Read
**Purpose:** Test whether the prototype communicates what kind of game it is before explanation.

**Prompt**
- “What do you think this game is?”
- “What do you think you’re supposed to do first?”

**Observe**
- whether players identify it as a card / encounter / strategy game
- whether they mention emotion as mechanic, theme, or both
- where they hesitate in the first minute

**Pass signal**
- player can describe the game in one or two sentences without major correction

---

### Scenario 2 - Turn and Encounter Comprehension
**Purpose:** Confirm that the turn loop is understandable.

**Prompt**
- “Start a run and play until you feel you understand the basic loop.”

**Observe**
- whether players understand what to do on a turn
- whether they can identify the role of card categories
- whether they can explain what changed after a card play
- whether outcome states feel earned instead of arbitrary

**Pass signal**
- player can explain a turn / encounter flow in plain language

---

### Scenario 3 - Emotional Strategy Differentiation
**Purpose:** Test whether the intended hook actually lands.

**Prompt**
- “What feels different here from other card or strategy games you’ve seen?”

**Observe**
- whether players mention trust / tension / clarity style dynamics
- whether they notice that memory, emotion, and reaction play different roles
- whether they read the system as strategy plus emotional context instead of flavor pasted onto cards

**Pass signal**
- player independently identifies some version of “emotions and context change strategy”

---

### Scenario 4 - Readability and Decision Clarity
**Purpose:** Surface card, text, and UI friction.

**Prompt**
- “Keep playing and say out loud anything that feels hard to read, compare, or understand.”

**Observe**
- repeated rereads
- confusion over card purpose
- inability to tell what changed after a turn
- failure to read outcome-state feedback
- text density or hierarchy problems

**Pass signal**
- most decisions can be made without repeated rereading or moderator rescue

---

### Scenario 5 - Replay Intent and Audience Fit
**Purpose:** Measure desire for another run and who the prototype seems to be for.

**Prompt**
- “Would you play another run?”
- “Who is this game for?”
- “What would make you want to keep playing?”

**Observe**
- whether replay intent is concrete or vague
- whether players can identify an audience segment
- whether either primary segment strongly rejects the framing

**Pass signal**
- player can name at least one specific reason to continue, retry, or explore another path

---

## 8. Core Questions to Ask

### Comprehension
- What kind of game is this?
- What do you do on a turn?
- What tells you whether a play helped or hurt?
- What do the outcome states seem to mean?

### Replay Intent
- Would you play another run now? Why or why not?
- What would you want to try differently next time?
- What would make you stop after one session?

### Audience Fit
- Who would enjoy this most?
- Does it feel more strategy-first, narrative-first, or balanced?
- Does the concept feel too niche, too broad, or about right?

### Readability
- Which card or screen took the most effort to understand?
- What part of the UI or wording made decisions slower?
- Did you know what changed after each play?

### Tone Acceptance
- How did the emotional framing land for you?
- Did anything feel preachy, vague, or awkward?
- Did the tone feel sincere and playable, or mostly conceptual?

### Messaging Recall
- How would you describe this game to a friend in one sentence?
- What would you expect from a store page or prototype invite based on this build?
- Did the prototype match the pitch in your head?

---

## 9. Success Criteria

### Must-pass criteria

#### Comprehension
- **80%+** can identify the prototype as a card-driven encounter / strategy experience
- **70%+** can explain the basic turn / encounter loop in plain language
- **70%+** recognize that emotions and context influence outcomes

#### Replay Intent
- **60%+** say they would try another run or another encounter sequence
- **75%+** can name at least one concrete thing they want to explore next

#### Audience Fit
- both primary segments produce at least **moderately positive** response overall
- no target segment shows a dominant pattern of “the idea sounds unclear”

#### Readability
- no more than **2 recurring severe readability blockers** across sessions
- **80%+** can identify the purpose of core cards without moderator explanation
- **75%+** can tell what changed after a card play or encounter reaction

#### Tone Acceptance
- **70%+** react positively or neutrally to the emotional framing
- fewer than **30%** describe the tone as preachy, confusing, or mismatched with the play

### Red flags / fail conditions
Any of these should trigger iteration before broader testing:
- players think the game is mostly flavor with unclear mechanics
- players cannot explain what emotions change in play
- result states feel arbitrary or invisible
- repeated comments that text is too dense or too vague
- players like the concept but do not want another run
- the tone is read primarily as therapy, education, or self-help instead of game framing

---

## 10. Evidence Capture

### Required capture per session
- participant segment
- session date / build version
- first-sentence description of the game
- top confusion points
- readability problems by card / screen / state display
- replay-intent rating
- tone-reaction summary
- whether the pitch matched the prototype
- top recommendation for next prototype revision

### Recommended scorecard
Rate 1-5 for each participant:
- understood what the game is
- understood what makes it different
- wanted another run
- found text readable
- accepted the tone
- understood what changed after each play

### Quotes to save verbatim
- “I think this game is…”
- “What confused me was…”
- “What makes this different is…”
- “I would / would not replay because…”
- “The tone feels…”

### Required output after test round
Produce a short synthesis memo with:
- top 5 validated strengths
- top 5 friction points
- blocked assumptions
- recommended fixes for onboarding, wording, readability, and prototype behavior

---

## 11. Risk Tags for Analysis
When logging issues, QA should tag each finding so follow-up work goes to the right owner.

### Suggested issue tags
- `comprehension`
- `readability`
- `tone`
- `audience-fit`
- `replay-intent`
- `onboarding`
- `card-wording`
- `state-feedback`
- `result-legibility`
- `expectation-mismatch`

This matters because not all negative feedback means the same thing.
For example:
- a wording issue should not be logged as concept rejection
- a UI hierarchy issue should not be logged as weak game design
- a tone objection should be separated from a mechanics comprehension failure

---

## 12. Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Prototype is too rough to judge message quality fairly | High | Brief participants that visuals are early, but still test clarity and reaction |
| Moderator explains too much | High | Use fixed prompts and only intervene on hard stalls |
| Readability issues get mistaken for concept rejection | High | Tag findings as wording, layout, logic, or premise |
| Audience sample skews too heavily toward one segment | Medium | Recruit balanced strategy and narrative participants |
| Players say the idea is interesting but do not want to replay | High | Track replay intent separately from concept approval |
| Emotional framing is interpreted as therapy/self-help | High | Probe language expectations and identify phrases causing the read |
| Outcome logic is too hidden to learn from | High | Capture whether players can explain why a result happened |

---

## 13. Handoff Notes for QA-002 and Downstream Work
If QA-001 succeeds, QA-002 should convert the findings into executable test cases for:
- turn-state transitions
- card-category comprehension
- result-state legibility
- readability and usability checks
- expectation-match checks between pitch and prototype

If QA-001 fails in a major area, the next action should not be “test more.”
It should be targeted revision in the relevant area:
- onboarding / wording
- UI hierarchy
- state-change feedback
- tone / copy framing
- encounter logic explanation

---

## 14. Recommendation
The first validation round should be treated as a gate for prototype usefulness, not just prototype existence.

A build that runs but fails comprehension, readability, tone acceptance, or replay intent is not validation-ready.
This plan exists to catch that early and give design, product, art, and engineering actionable evidence instead of vague reactions.

---

**Canonical file:** `projects/emotion-cards-four/tests/prototype-validation-plan.md`
