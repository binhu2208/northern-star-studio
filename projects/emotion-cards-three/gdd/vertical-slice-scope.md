# Emotion Cards Three — Vertical Slice Scope

**Task:** DES-002  
**Purpose:** Define the minimum playable vertical slice and one polished archetype path for downstream implementation and QA.

---

## 1. Slice Goal

Ship a **small but complete playable slice** that proves three things:

1. The **emotion-state card loop** is understandable and fun.
2. A single character arc can move from **starting emotion -> confrontation -> resolution** through card play.
3. Design, engineering, UI, and QA can all work from a clear, testable scope.

This slice is not trying to prove the full game. It is trying to prove the **core loop and one emotionally coherent path**.

---

## 2. Minimum Playable Slice

The vertical slice includes:

### Playable content
- **1 playable character:** Maya Chen
- **1 complete run path** built around her estranged-sibling arc
- **3 encounter beats:**
  1. Tutorial / first memory
  2. Letter / mid-run choice beat
  3. Confrontation + resolution
- **1 final ending path fully polished**

### Core systems required
- Deck / draw / discard / reshuffle loop
- Hand play with **emotional capacity = 3 plays per turn**
- Emotion family tagging on cards
- **Resonance** trigger for 3+ cards from the same family
- Basic emotional-state progression tracking for Maya
- Choice gating based on deck state / played emotion profile
- End-of-run resolution check

### Presentation required
- Readable combat/state UI
- Clear card text and emotion-family signaling
- Minimal narrative panels for memory, letter, confrontation, and ending
- Basic feedback for:
  - card play
  - resonance trigger
  - state change
  - encounter outcome

---

## 3. Chosen Polished Archetype Path

### Archetype
**Maya -> Resentment to Reconciliation**

This is the one path that gets full polish in the slice.

### Why this path
It best demonstrates the game's promise:
- starts from a strong, readable emotional baseline
- shows deck/state change across the run
- uses both mechanics and narrative gating
- lands on a hopeful resolution instead of just a combat win state

### Intended player arc
1. Start Shadow-heavy and emotionally closed off
2. See evidence that complicates Maya's certainty
3. Introduce Warmth through specific choices/cards
4. Reach confrontation with enough vulnerability to unlock reconciliation
5. End on a clear emotional payoff

### Required beats for this path
- **Start state:** Maya begins in **Resentment** with Shadow-heavy deck
- **Beat 1: First Memory**
  - player can review memory
  - curiosity/compassion option is available if requirements are met
- **Beat 2: The Letter**
  - player can read from a more open perspective
  - this unlocks Warmth-supporting cards / flags
- **Beat 3: Confrontation**
  - deck composition and prior flags allow a vulnerability-led approach
- **Ending:** **Reconciliation**
  - requires Warmth-leaning outcome and full-truth path support

---

## 4. Scope Boundaries

## In Scope
- Maya only
- One run structure with 3 major encounters
- One polished ending: **Reconciliation**
- Limited set of cards sufficient to support:
  - Shadow opening play
  - Warmth transition
  - one or two Fire/other off-path options only as rough support
- One enemy/opposition pattern for confrontation
- One readable UI flow for hand, deck state, resonance, and narrative choices
- Save/load not required beyond basic restartable local run state unless already trivial

## Out of Scope
- Additional playable characters
- Full roguelike map structure
- Multiple zones
- Full meta-progression
- All four Maya endings at full quality
- Large card pool / balance pass across many archetypes
- Advanced AI behaviors
- Voice, final art, final audio, or cinematic presentation
- Accessibility polish beyond baseline readability unless already low-cost

---

## 5. Practical Content Target

Keep the content footprint intentionally small.

### Recommended card pool for the slice
Target **12-16 total cards** implemented and usable.

Breakdown:
- **6-8 core Shadow cards** for Maya's starting state
- **4-6 Warmth / bridge cards** that enable the reconciliation route
- **2-3 support cards** for edge cases, tutorial teaching, or simple off-path variance

That is enough to prove:
- deck identity
- state transition
- resonance
- narrative gating through deck composition

---

## 6. Acceptance Criteria

The slice is complete when all of the following are true:

### Core loop
- Player can start a run, draw cards, play cards, end turns, and finish the run without dev intervention.
- Deck, discard, and reshuffle behavior work consistently.
- Emotional capacity limits card plays per turn.

### Emotion-state functionality
- Cards clearly communicate their emotion family.
- Resonance triggers when 3+ same-family cards are played or satisfied by the implemented rule.
- Maya's tracked emotional progression updates based on implemented choices / progression flags.

### Narrative/choice path
- The player can reach the **Reconciliation** ending through a readable, repeatable path.
- That path depends on both:
  - play/choice behavior during the run
  - emotional/deck-state requirements
- The slice shows at least one visible moment where the player's emotional approach changes what becomes available.

### UX/readability
- Hand, card text, state indicators, and outcome feedback are readable without designer explanation.
- Player can tell:
  - current capacity
  - current emotional leaning or state
  - when resonance occurred
  - why a key choice/end state unlocked or did not unlock

### Stability
- No blocker bugs across one full playthrough of the target path.
- A tester can complete the intended path in a predictable session length.

---

## 7. Done Definition for the Polished Path

The polished path should feel intentional, not placeholder-heavy.

Minimum bar:
- onboarding teaches the core card/state loop
- card set is coherent and not obviously random
- confrontation resolves through the same emotional logic taught earlier
- ending text/UI makes the emotional payoff legible
- the player can explain, in simple terms, **why** they reached reconciliation

If that bar is not met, the slice is not done even if the systems technically function.

---

## 8. Implementation Handoff Notes

### Design-to-engineering handoff
Engineering should implement the slice around these concrete flags/states:
- Maya emotional states:
  - Resentment
  - Curiosity
  - Conflict
  - Vulnerability
  - Understanding
  - Resolution
- Story flags at minimum:
  - first memory seen
  - letter read
  - confrontation reached
  - full truth known
  - confrontation path chosen

### Suggested implementation order
1. Basic deck/turn loop
2. Card data with emotion-family tags
3. Capacity + resonance rules
4. Maya run-state / story flags
5. Encounter 1 and tutorial flow
6. Letter encounter and unlock logic
7. Confrontation encounter
8. Reconciliation ending check and end screen
9. Readability polish / feedback pass

### Data expectations
Use data-driven definitions where possible for:
- cards
- encounter requirements
- ending requirements
- narrative choice unlock conditions

That keeps the slice expandable without rewriting the core logic.

---

## 9. QA Handoff Notes

QA should focus on whether the slice is **clear and finishable**, not only bug-free.

### Primary QA pass
Validate the golden path:
1. Start Maya run
2. Complete first memory beat
3. Read letter through reconciliation-supporting route
4. Reach confrontation with required state/flags
5. Unlock and complete Reconciliation ending

### Secondary QA checks
- resonance triggers correctly
- capacity limit cannot be bypassed
- invalid ending unlocks do not appear incorrectly
- required flags persist through the run
- UI reflects state changes after major choices
- loss/failure edge states, if present, recover cleanly

### QA questions to answer
- Can a new tester understand what the run wants from them?
- Is the Warmth shift readable, or does the ending feel arbitrary?
- Is any key unlock too hidden to be reliable in a slice demo?
- Does the confrontation feel like the payoff of prior choices, not a disconnected event?

---

## 10. Summary

The vertical slice should be **small, complete, and honest**:
- one character
- one short run
- one polished emotional archetype path
- one clear ending

For this slice, the bet is simple: **Maya's resentment-to-reconciliation path is the proof case for Emotion Cards Three.** If that path works, the broader game has something real to build on.
