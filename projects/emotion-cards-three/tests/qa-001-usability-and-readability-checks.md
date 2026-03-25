# QA-001 — First-Session Usability Goals and Readability Test Checks

## Purpose
Define how QA will evaluate whether the Emotion Cards Three prototype is understandable, tactically legible, and marketable in a first session.

This checklist supports the concept-validation brief and focuses on one question:

**Can a new player quickly understand what the emotional mechanic is doing, why it matters, and what they should do next?**

## Test Scope
This QA pass is for the prototype only.

In scope:
- first-session comprehension
- emotional-state readability
- card and combat readability
- onboarding clarity
- screenshot/clip legibility checks

Out of scope:
- long-term progression balance
- content volume
- polish-level bug sweeps
- platform compatibility beyond prototype needs

## First-Session Usability Goals
A first-session test is considered healthy if most testers can do all of the following without coaching:

1. Identify the current emotional state
2. Explain what that state is changing in gameplay
3. Read a card and predict its likely effect
4. Understand what action to take on their turn
5. Finish the first combat scenario without confusion dominating the session
6. Describe the game hook in simple language after play

## Success Targets
Use these targets for prototype review:

- **State recognition:** most testers can identify the current emotional state within 5 seconds
- **State meaning:** most testers can explain the gameplay impact of the current emotional state after 1-2 turns
- **Turn clarity:** most testers know what to do on their turn without facilitator explanation
- **Card readability:** most testers can read core card text and understand outcome expectations on first view
- **Onboarding clarity:** most testers can describe the game as “emotion affects strategy” after the first combat
- **Screenshot legibility:** at least one screenshot clearly shows emotional state, player intent, and combat context
- **Clip legibility:** a short combat clip communicates the emotional mechanic without voiceover-heavy explanation

## First-Session Test Checks

### A. Onboarding and Comprehension
- Is the player told what the current emotional state is?
- Is it obvious where emotional state is displayed?
- Is the first objective clear?
- Does the prototype explain why emotional state matters before or during first use?
- Can the player understand the first meaningful decision without outside help?
- Are tutorial prompts short enough to read quickly?
- Do tutorial prompts appear at the right moment?
- Is there any point where the player asks “What am I supposed to do?”

### B. Emotional-State Readability
- Is the current emotional state visible at a glance?
- Is the emotional state distinguishable by more than color alone?
- Can the player tell when the emotional state changes?
- Is the change in emotional state tied to a visible gameplay consequence?
- Can the player tell whether a card will stabilize, escalate, or redirect emotion?
- Are stacked emotion effects still understandable during combat?
- Are state names/icons/shapes memorable enough to support quick recognition?

### C. Card and Combat Readability
- Is card text readable at gameplay size?
- Are key values and keywords visually prioritized?
- Can a tester predict likely card outcome before playing it?
- Is the relationship between emotional state and card effect understandable?
- Are enemy intentions or likely outcomes readable enough to make strategy possible?
- Is combat state too busy once multiple modifiers are active?
- Do animations or transitions help clarity rather than hide it?

### D. Tactical Clarity
- Can testers explain why they chose one card over another?
- Can testers explain whether they are trying to build, suppress, or exploit an emotional state?
- Does the emotional system produce decisions that feel different from a generic buff/debuff layer?
- Can testers notice when an emotional choice creates a better or worse outcome?
- Is the prototype making the hook feel systemic rather than cosmetic?

### E. Screenshot and Clip Legibility
For at least one screenshot candidate:
- Can a viewer tell this is a card-based strategy game immediately?
- Can a viewer notice the emotional mechanic from the screen alone?
- Is the UI too cluttered for store-page use?
- Is focal hierarchy clear: state, cards, targets, result?

For at least one short clip candidate:
- Can a viewer understand what changed in the emotional state?
- Can they see how that change affected a decision or outcome?
- Does the clip communicate the hook in under 10 seconds?

## Failure Signals / Red Flags
Flag the prototype as at risk if any of the following appear repeatedly:

- Testers cannot find or identify the emotional state quickly
- Testers describe the emotional system as cosmetic or confusing
- Players need repeated explanation to understand core actions
- Card/state interactions become unreadable once multiple effects are active
- The prototype is only understandable when someone explains it live
- Screenshot candidates look generic or visually noisy
- Clip candidates require too much context to make sense

## Observation Template
Use the following notes during first-session testing:

- Tester:
- Session date:
- Build/version:
- Time to identify emotional state:
- Time to first meaningful decision:
- Points of confusion:
- Could tester explain emotional-state gameplay impact? Yes/No
- Could tester describe the hook after play? Yes/No
- Best screenshot candidate captured? Yes/No
- Best clip candidate captured? Yes/No
- QA verdict: Pass / Needs revision / Fails concept-validation gate

## QA Recommendation Gate
QA should recommend prototype success only if the build proves all of the following:

- emotional state is easy to see
- emotional state materially changes decisions
- first-session players understand the loop quickly
- combat/card readability stays intact during play
- at least one screenshot and one clip communicate the hook clearly

If any of those fail, the team should revise systems, UI, onboarding, or scope before advancing to the next milestone.
