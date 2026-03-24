# QA-004 — Emotion Cards Phase 3 Balance Pass

**Branch:** `release/v0.4.0`  
**Date:** 2026-03-17  
**Tester:** Sakura 🌸  
**Status:** Complete — design review pass

## Scope

Reviewed available character/card docs, balance notes, and implemented card data for:
- Maya
- Ember
- Wren
- Tide
- Frost
- Bloom

Sources reviewed included:
- `docs/gdd/emotion-cards-core-mechanics.md`
- `docs/gdd/ember-phase3-4-cards.md`
- `docs/gdd/ember-phase5-6-cards.md`
- `docs/gdd/wren-character.md`
- `docs/gdd/tide-character.md`
- `docs/gdd/frost-character.md`
- `tests/qa/balance-maya.md`
- `tests/qa/balance-ember.md`
- `tests/qa/balance-wren.md`
- Implemented data in `src/characters/maya/`, `src/characters/ember/`, `src/characters/wren/`

## Executive Summary

The biggest risk is **not raw number tuning** — it is **spec drift**.

Across Phase 3 materials, the GDD, prior QA notes, and implemented card data disagree on:
- card counts per phase
- card names
- resource models (`Heat`, `Charge`, `Fear`, `Memory Echo`, `Speed`, `Trust`, `Static`, `Soaked`)
- whether the game supports allies, positioning, movement, enemy hands, or delayed triggers
- whether emotional capacity/energy is 3 per turn, free-form, or card-specific only

Because of that, several characters cannot be balanced cleanly yet. Maya, Ember, and Wren have enough material for directional balance calls. Tide and Frost are still mostly design-stage. **Bloom appears unavailable in current branch docs/data and should be treated as missing content, not silently skipped.**

## Cross-Character Findings

### P0 — Core systemic blockers

1. **Undefined combat model**
   - Core mechanics mention resonance, conflict, transmutation, and possible emotional capacity, but do not lock down combat primitives.
   - Multiple character kits assume unsupported systems: allies, movement, adjacency, turn skipping, attack phases, opponent hands, deck peeking, speed, passive triggers, persistent summons.
   - **Risk:** individual cards may be “balanced” in isolation but unimplementable or non-comparable across characters.

2. **Phase and roster inconsistency**
   - Ember docs alternate between 20, 23, and 24 total cards depending on file.
   - Wren docs and implementation disagree on phase names and late-phase card counts.
   - Maya starter-deck notes differ from implementation, and implementation currently appears incorrect.
   - **Risk:** QA cannot validate progression or draft encounter pacing against a stable roster.

3. **No unified power budget**
   - There is no shared baseline for what 1-cost, 2-cost, and 3-cost cards should do across offense, defense, draw, healing, and scaling.
   - **Risk:** characters will feel balanced only inside their own docs, not against each other or encounter tuning.

### P1 — Recurring balance patterns

- **Too many self-damage / delayed-cost cards** across Shadow/Fire kits; risk of decks that feel punishing instead of cozy/expressive.
- **Several scaling cards lack caps** or their caps differ by document.
- **Too much complexity too early** in some kits, especially Wren and Tide.
- **Support/ally assumptions** appear in Tide and some Ember/Warmth interactions, but companion combat support is not established globally.

## Character-by-Character Findings

## Maya

### Current state
- Has prior QA doc and implemented card data.
- Implementation is the most concerning part because it appears internally inconsistent.

### Major risks

1. **Starter deck construction bug / misassembly**
   - In `src/characters/maya/maya_cards.gd`, `get_starting_deck()` slices `get_shadow_cards()` repeatedly where comments imply card duplication counts.
   - It does **not** actually create the intended 4x/3x/3x/2x/2x distribution from the design notes.
   - It also references `get_shadow_cards().slice(3, 5)` while comment says this should represent `I Was Right`, but `I Was Right` is in `get_fire_cards()`, not `get_shadow_cards()`.
   - **Risk:** Maya’s real starting deck is currently not the deck described by docs or QA notes.

2. **Warmth access is still too slow/expensive**
   - `Grandmother's Hands` costs 3 for heal 5 and is a single early Warmth anchor.
   - With early Shadow-heavy composition, Maya still risks being locked into Shadow lines before reconciliation mechanics feel reachable.
   - **Risk:** reconciliation fantasy arrives too late; early runs over-index on resentment.

3. **Shadow efficiency may still dominate**
   - `What He Said` at cost 2 / value 4 and `Bitter Memory` with resonance bonus create very reliable Shadow throughput.
   - `Should Have Been Different` drawing 1 at cost 1 is a clean setup tool with little downside.
   - **Risk:** Shadow remains both safest and most efficient, making Warmth/Storm pivots suboptimal.

4. **Some values fight the cozy progression goals**
   - `Empty Studio` gives only 2 shield and self-damage.
   - `Overwhelmed` is 6 to opponent / 4 to self, which is steep unless encounter damage pacing is very low.
   - **Risk:** “sadness/uncertainty” cards become trap picks instead of emotional-expression tools.

### Recommendation
- Fix Maya’s actual starter-deck assembly first.
- Set explicit family targets for her first 15 cards.
- Add one more low-cost Warmth bridge card before phase transition.
- Re-evaluate self-damage on Shadow/Storm cards so they are not mathematically dominated picks.

## Ember

### Current state
- Strong thematic arc, but docs and implementation diverge heavily.
- Implemented card data is numerically defined, which exposes outlier risks clearly.

### Major risks

1. **Heat scale is likely overtuned or unnormalized**
   - Early cards grant `+10`, `+15`, `+20`, `+25 Heat` while later docs describe much smaller late-game heat bands like 3+, 5+, 8+ or max 10.
   - `Backdraft` deals damage equal to `current Heat / 2` in implementation.
   - **Risk:** if Heat values are literal, Backdraft and heat-threshold cards can break damage curves immediately; if they are percent-like, the docs need to say that.

2. **Implementation does not match design intent of recovery/control phases**
   - GDD Phase 3-4 focuses on guilt, defense, cooling, low-heat play, and hybrid healing.
   - Implemented Phase 3 cards are mostly raw attack spikes: `Immolate`, `Thermal Strike`, `Rain of Fire`, `Combustion`.
   - **Risk:** Ember stays a pure damage snowball instead of transitioning into “anger mastered.”

3. **AOE and burn stacking look dangerous**
   - `Rain of Fire`: 7 AOE + burn at cost 3.
   - `Supernova`: 15 AOE + 4 burn at cost 4.
   - Without encounter HP targets and burn rules, these are impossible to balance responsibly.
   - **Risk:** multi-enemy fights collapse; single-target tuning becomes irrelevant.

4. **Late-game finisher curve looks too explosive**
   - `Phoenix Blaze` at 12 for 3, `Supernova` at 15 AOE for 4, plus heat-scaling and burn amplification.
   - `Guided Flame` is very rate-efficient at cost 1, damage 5, draw 1.
   - **Risk:** Ember has the best burst, best scaling, and best consistency unless costs or heat management meaningfully constrain it.

5. **Card-count mismatch creates progression uncertainty**
   - Some docs list 20 cards, others 23/24, and card names differ (`Bonfire` vs implemented `Efficient Blaze`, `Phoenix Rise` vs `Phoenix Blaze`, etc.).
   - **Risk:** impossible to test intended unlock pacing.

### Recommendation
- Freeze one canonical Ember card list before more balance work.
- Normalize Heat to a single scale and define exact thresholds/caps.
- Reinsert actual recovery/control cards into implemented Phase 3-4 if the arc is meant to slow and mature.
- Put explicit caps on any Heat-to-damage conversion.

## Wren

### Current state
- Best narrative cohesion after Maya, but still highly system-dependent.
- Has both design docs and implemented card data; they only partially align.

### Major risks

1. **Memory mechanics are underspecified across files**
   - Docs reference `Memory Echo`, `Memory Fragment`, persistent summons, fade timers, death triggers, and token scaling.
   - Implementation uses `Memory Token`, `Memory Tokens`, and dynamic effects, but token rules are still not standardized.
   - **Risk:** Wren’s whole deck balance is impossible until token persistence, cap, and encounter reset rules are fixed.

2. **Scaling attacks need caps or lower multipliers**
   - `Memory Strike` implementation: base 3 +2 per card played this combat, with no cap in code text.
   - `Legacy`: damage = memory tokens × 3.
   - `Carry Forward`: heal = cards played × 2.
   - **Risk:** Wren snowballs too hard in longer fights and becomes encounter-length dependent.

3. **Too many edge-case mechanics for one character**
   - Delayed damage, copied effects, random outcomes, discard/topdeck manipulation, summons, dynamic scaling, debuff conversion.
   - **Risk:** Wren becomes the highest cognitive-load deck while also being Shadow’s attrition deck.

4. **Randomness clashes with strategic/cozy goals**
   - `Hallucination` remains high variance in both docs and implementation.
   - **Risk:** frustrating swing card in a game positioned around emotional intentionality.

5. **Phase structure still drifts**
   - Design doc includes Bargaining, Shadows, Wren and later cards up to 26 including meta-progression.
   - Implementation ends with 22 playable cards and remaps late phases differently.
   - **Risk:** progression/pick cadence cannot be tested accurately.

### Recommendation
- Standardize one token model: name, cap, duration, whether it is a summon or abstract resource.
- Cap `Memory Strike` and `Carry Forward` explicitly.
- Replace or narrow `Hallucination` to a controlled “choose 1 of 2 unstable outcomes” model.
- Reduce mechanic count in early phases so Wren’s complexity ramps later.

## Tide

### Current state
- Design doc only; no balance note or implementation found.
- Several cards are clearly written before the combat model is locked.

### Major risks

1. **Heavy dependence on unsupported ally systems**
   - `Lightning Rod`, `Conductor`, `Ground Current`, `Spark Connection`, `First Drop`, `Ripple`, `Dew`, `Monsoon`, `Ocean` all assume allies are active combat participants.
   - **Risk:** a large portion of Tide’s kit is unusable if the game remains primarily 1v1 encounter-based.

2. **Movement/positioning assumptions are undefined**
   - `Riptide` refers to escape/move range; `Conduct` chains to adjacent targets.
   - **Risk:** design language from a tactics battler is bleeding into a deckbuilder without confirmed support.

3. **Charge package may create feast-or-famine gameplay**
   - Early isolation cards generate Charge efficiently, then later connection cards require the player to abandon those incentives.
   - `Isolation Pattern` and `Voltage Build` may be too rewarding if the ally system is optional or weak.
   - **Risk:** players ignore the intended emotional growth and just stay in the isolation engine.

4. **Control effects look too strong for low costs**
   - `Thunderclap` for 2 damage plus stun at cost 2 is already premium, even before Charge setup.
   - `Spark Connection` at cost 0 can become a repeat-value engine depending on ally frequency.
   - **Risk:** Tide becomes either oppressive with support enabled or nonfunctional without it.

### Recommendation
- Do not balance Tide numerically yet.
- First decide whether the core game supports allies, adjacency, movement, and reactive multi-unit turns.
- If not, redesign Tide around self-state shifts and enemy debuffs instead of ally board play.

## Frost

### Current state
- Design doc only; no balance note or implementation found.
- Concept is strong, but many mechanics are still speculative.

### Major risks

1. **Introduces another full custom resource layer without framework**
   - `Fear Tokens`, `Courage`, `Freeze`, and `Frostbite` all need system rules.
   - **Risk:** Frost adds more bespoke complexity before shared status architecture exists.

2. **Several cards depend on unsupported systems**
   - `Distance` uses movement.
   - `Frozen Stance` blocks all damage and removes energy gain, which depends on exact turn structure.
   - `Winter Blindness` “resets the board state somewhat,” which is too vague to balance.
   - **Risk:** design reads well emotionally but lacks implementable balance hooks.

3. **Polarity risk: overdefensive or nonfunctional**
   - Cards like `Frozen Stance`, `Walls`, `Frost Form`, and `Glacier` lean extremely defensive or action-denying.
   - **Risk:** Frost either stalls encounters indefinitely or feels terrible because too many cards skip agency.

4. **Fear penalties may be anti-fun if stacked globally**
   - “Each fear token gives -1 to all actions” can make a losing state spiral hard.
   - **Risk:** violates cozy/non-punishing principles from the core mechanics doc.

### Recommendation
- Convert Frost’s mechanics into a small set of shared statuses instead of a new subsystem explosion.
- Avoid “skip turn / cannot act / cannot attack” stacking as the main fantasy delivery.
- Keep courage as payoff, but make fear a manageable friction, not a spiral mechanic.

## Bloom

### Current state
- **No Bloom character/card docs, balance note, or implementation were found in the current branch search.**

### Major risk
- Phase 3 review scope names Bloom, but repository content for Bloom appears absent.
- **Risk:** release planning may assume six reviewed characters when only five have source material, and only three have implemented card data.

### Recommendation
- Mark Bloom as **missing from branch** and block any claim that Phase 3 balance coverage is complete for Bloom until source files exist.

## Highest-Priority Actions Before Numeric Playtesting

1. **Create a single combat-rules spec** covering:
   - energy/emotional capacity per turn
   - supported status effects
   - ally support yes/no
   - movement/positioning yes/no
   - summon/token rules
   - delayed effects and reaction windows

2. **Lock one canonical card roster per character**
   - names
   - phase counts
   - unlock order
   - implementation source of truth

3. **Fix Maya starter deck implementation immediately**
   - current function appears to assemble the wrong cards/counts.

4. **Normalize scaling resources**
   - Heat, Charge, Fear, Memory should each have explicit cap, gain rate, spend rules, and expected range.

5. **Establish a cross-character power budget**
   - 1-cost attack baseline
   - 2-cost attack baseline
   - shield baseline
   - heal baseline
   - draw baseline
   - scaling card cap rules

## Suggested Pass/Fail Criteria for next QA pass

### Must pass
- Each character has one canonical card list.
- Each custom resource has a defined cap and resolution timing.
- No card relies on an unsupported combat feature.
- No starter deck is missing intended families/archetype bridges.

### Should pass
- Every phase transition changes play pattern meaningfully.
- Self-damage cards are optional/high-payoff, not default tax cards.
- Scaling cards have explicit caps.
- Cozy design principles still hold under suboptimal play.

## Final Assessment

**Overall status:** Not ready for final balance tuning.

The project has strong emotional identity and several genuinely good character hooks, but Phase 3 content is currently limited more by **system ambiguity and document drift** than by individual number tuning. Maya, Ember, and Wren can move into targeted rebalance once their source-of-truth lists are unified. Tide and Frost still need system validation before serious balance work. Bloom is currently missing from the reviewed branch.
