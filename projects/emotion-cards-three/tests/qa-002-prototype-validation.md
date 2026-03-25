# QA-002 — Prototype Validation: Clarity, Readability, and Onboarding

## Purpose
Validate whether the current Emotion Cards Three prototype definition is strong enough to support a readable first-session experience.

This QA pass evaluates the referenced prototype documents against five gates:
- tactical clarity
- fast state recognition
- likely gameplay impact recognition
- readability
- onboarding clarity

This is a **design-and-spec validation pass**, not a playtest result report.
The verdict below answers a narrower question:

**If the team implements the prototype as currently specified, is the prototype likely to be understandable and testable without heavy live explanation?**

Reference files:
- `projects/emotion-cards-three/tests/qa-001-usability-and-readability-checks.md`
- `projects/emotion-cards-three/src/prototype-state-ui-readability.md`
- `projects/emotion-cards-three/art/readability-guide.md`

---

## QA Summary Verdict
**Overall verdict: Pass with focused risk notes**

The current prototype definition is in healthy shape for a first implementation/validation pass.
The strongest part of the package is that it treats emotional state as a visible gameplay system instead of a hidden modifier layer.

The documents do a good job of making these things explicit:
- where the current emotional state is shown
- how state changes are signaled
- how cards declare emotional shifts
- how enemy intent and vulnerable moments should read
- what QA should measure in a first session

That said, the package is **not yet “confusion-proof.”**
The main remaining risk is that the prototype could still feel readable on paper but cognitively busy in actual play if too many small cues fire at once.

Recommended status:
- **Good to implement / continue validating**
- **Do not treat as final UX solved**
- **Prioritize first-session observation on state/card/intent overload**

---

## 1. Tactical Clarity
**Verdict: Pass**

### What is working
The prototype currently supports tactical clarity better than many early card battler concepts because it gives players three readable decision anchors:
1. current emotional state
2. current enemy intent
3. visible card role / state-shift language

This matters because the player is not being asked to guess where strategy lives.
The documents repeatedly point them to the intended decision loop:
- identify current state
- understand what that state changes
- read enemy intent
- choose a card based on whether to stabilize, sequence, pressure, or exploit

### Evidence from references
- QA-001 explicitly asks whether testers can explain why they chose one card over another.
- DEV-002 requires enemy intent to be visible before action.
- DEV-002 requires active-state synergy cues and explicit state-shift wording on cards.
- ART-001 separates card role readability from state readability, which reduces category confusion.

### Remaining risk
Tactical clarity will drop fast if the prototype overuses subtle mini-cues instead of one or two dominant ones.
The biggest tactical failure mode would be:
- visible state badge exists,
- visible intent exists,
- but card modifiers, tags, warnings, and transitions all compete equally,
- so the player sees “many facts” but not a clear best read.

### QA call
The current spec is strong enough to test tactical clarity.
Implementation should keep the hierarchy brutal and obvious:
- state
- intent
- card outcome
- everything else after that

---

## 2. Fast State Recognition
**Verdict: Pass**

### What is working
Fast state recognition is one of the clearest strengths of the current package.
The system does not rely on flavor-only naming or color-only communication.
Instead, it stacks:
- state name text
- state badge icon
- color treatment
- shape treatment
- one-line gameplay summary

That is the right call.
If a prototype cannot make players identify the emotional state quickly, the whole game hook starts collapsing into “buff/debuff soup.”
Right now the documents are correctly designed to avoid that.

### Evidence from references
- QA-001 sets a target that most testers can identify state within 5 seconds.
- ART-001 defines a paired color + shape system for Calm, Focused, Agitated, and Overwhelmed.
- DEV-002 requires a dedicated state widget near the player panel, not buried in card text.
- DEV-002 requires state summaries to be visible without hover.
- DEV-002 includes transition feedback so state changes do not go unnoticed.

### Remaining risk
The biggest recognition risk is not the static state HUD — it is state transition overload.
If transitions become flashy but unclear, players may notice that “something happened” without understanding what changed.

A second risk is that Calm and Focused could still blur together if the implementation undersells shape contrast and over-relies on blue-ish palette differences.

### QA call
The spec supports fast recognition well.
Implementation must specifically protect these two checks:
- Calm vs Focused must be distinct instantly
- Agitated vs Overwhelmed must not collapse into one generic danger read

---

## 3. Likely Gameplay Impact Recognition
**Verdict: Pass with moderate risk**

### What is working
The prototype mostly succeeds at telling the player not just **what state they are in**, but **why that state matters right now**.
That is the harder problem, and the docs address it directly.

Strong choices include:
- one-line state effect summaries in the HUD
- explicit card shift language
- synergy cues on cards when state modifies output
- visible enemy intent and exposed windows
- specific emphasis on the Overwhelmed downside reminder

This gives players a fair shot at predicting consequence instead of memorizing a hidden system.

### Evidence from references
- QA-001 asks whether most testers can explain gameplay impact after 1–2 turns.
- DEV-002 requires current-state summaries without hover.
- DEV-002 requires visible pre-play cues when state affects card output.
- DEV-002 requires enemy intent and Exposed readability to support consequence prediction.
- ART-001 pushes consistent action-first card wording.

### Remaining risk
This is the category most likely to wobble in real use.
Why? Because recognizing a state is easier than recognizing its tactical consequence under turn pressure.

The likely failure mode is:
- player sees they are Agitated,
- player can read the card,
- player can see enemy intent,
- but still cannot quickly judge whether they should exploit the aggression spike or stabilize before the downside bites.

That is not a wording problem alone.
That is a hierarchy-and-feedback problem.

### QA call
The current documentation is good enough to test gameplay impact recognition, but this should stay on the watchlist as a top validation risk in implementation and first-session observation.

---

## 4. Readability
**Verdict: Pass**

### What is working
Readability is well-considered across the references.
The team has not made the common mistake of treating readability as “make the font larger later.”
Instead, the docs address:
- layout stability
- hierarchy
- icon simplicity
- text density
- screenshot clarity
- shape-first fallback logic
- separation of card role vs active state

That is solid prototype thinking.

### Evidence from references
- ART-001 defines card information priority clearly.
- ART-001 recommends bold, grayscale-testable icons rather than over-detailed mini-art.
- ART-001 defines screenshot legibility checks for Discord/mobile/compressed viewing.
- DEV-002 defines stable layout zones for answering core combat questions.
- DEV-002 requires card text and state-shift text to stay explicit and readable at gameplay size.
- QA-001 includes card readability, screenshot legibility, and clip legibility as success criteria.

### Remaining risk
The main readability risk is cumulative clutter.
None of the individual guidance is bad.
The problem would come from implementing all of it at equal visual weight.

Likely clutter traps:
- too many role tags glowing at once
- state synergy cues competing with intent cues
- transition effects briefly obscuring card readability
- enemy intent, Exposed, state summary, and card bonus markers all demanding attention in the same moment

### QA call
The spec is readable enough to proceed.
Implementation should treat readability as a subtraction problem, not a feature-adding contest.
If two cues solve the same comprehension problem, keep the cleaner one.

---

## 5. Onboarding Clarity
**Verdict: Pass with mild risk**

### What is working
The onboarding path is not fully scripted here, but the documents do support a workable first-session ramp.
Most importantly, they establish what must be visible early enough for onboarding to work:
- current state
- what the state does
- what the enemy is about to do
- how cards shift or exploit state

That is enough foundation for a short, prototype-grade onboarding layer.

### Evidence from references
- QA-001 defines first-session usability goals and onboarding checks.
- DEV-002 insists the current-state summary be visible without hover.
- DEV-002 explicitly avoids bloated glossary/UI complexity in this phase.
- ART-001 prioritizes function before flourish, which supports teachability.

### Remaining risk
The mild risk is that the prototype may still depend too much on “the UI explains itself.”
A readable UI helps, but it does not replace onboarding sequencing.

The likely onboarding miss would be this:
- the player can technically see all the right information,
- but the prototype does not introduce those ideas in the right order,
- so the player understands pieces only after making a few confused turns.

### QA call
The current package supports onboarding, but implementation should make sure first contact happens in this order:
1. identify current state
2. read what that state changes
3. read enemy intent
4. choose a card with obvious shift/effect language
5. see the result clearly

If the prototype teaches those in that order, onboarding should hold.

---

## Pass / Risk Matrix
| Validation area | Verdict | Risk level | Notes |
|---|---|---:|---|
| Tactical clarity | Pass | Medium | Strong structure; must avoid equal-weight cue overload |
| Fast state recognition | Pass | Low | One of the strongest parts of the current package |
| Gameplay impact recognition | Pass | Medium | Most likely area to slip under live turn pressure |
| Readability | Pass | Medium | Strong rules; execution could still get cluttered |
| Onboarding clarity | Pass | Medium-Low | Foundation is good; sequencing matters |

---

## Key Strengths
1. **State is treated as the game’s main readable system, not hidden math.**
2. **Color is backed by shape/text, which is the right prototype safeguard.**
3. **Card wording favors explicit effect/shift language over cute abstraction.**
4. **Enemy intent and Exposed windows give players a visible reason to care about state.**
5. **QA-001 already defines measurable first-session success targets, which makes future validation cleaner.**

---

## Key Risks to Watch During Implementation
1. **Too many simultaneous cues**
   - The prototype could become technically informative but mentally noisy.

2. **Calm vs Focused under weak implementation**
   - If shape contrast is weak, these may read as the same family too often.

3. **Agitated/Overwhelmed becoming generic danger red**
   - If Overwhelmed does not feel categorically worse, the escalation ladder weakens.

4. **Card bonuses being visible but not interpretable**
   - A bonus marker is only useful if the player knows why it matters.

5. **Onboarding assuming too much ambient literacy**
   - New players still need the first few moments framed in the right order.

---

## QA Requirements Before Calling the Prototype Healthy in Practice
Before this moves from document-level validation to a healthy prototype verdict, QA should confirm in actual play or mock implementation review that:

- players can identify the current state in under 5 seconds
- players can explain what that state is changing after 1–2 turns
- players can read enemy intent without hunting
- players can predict why one card is better than another in the current moment
- state transition feedback clarifies rather than distracts
- at least one screenshot and one short clip communicate the emotional hook cleanly

---

## Final Recommendation
**Recommendation: Proceed**

QA recommends continuing with the prototype using the current documentation set.
The clarity/readability foundation is strong enough to justify implementation and downstream testing.

However, the team should treat the next validation pass as an execution check, not a box-tick.
The prototype will only really succeed if implementation preserves hierarchy and refuses clutter.

### Priority watchpoints for the next QA pass
- state recognition speed in real play
- gameplay consequence understanding after 1–2 turns
- overlap between state cues, card cues, and enemy intent cues
- whether onboarding teaches the loop in the right order

### QA release note
At document level, this prototype is **clear enough to move forward**.
At implementation level, it is **one visual-hierarchy mistake away from becoming noisier than it looks on paper**.

That’s manageable — but it should be watched closely.
