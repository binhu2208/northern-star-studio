# Emotion Cards Four — Card Schema and Content Integration Requirements

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DEV-001B
- **Purpose:** Define the implementation-ready card schema, content boundaries, validation rules, and runtime integration requirements for the prototype card set
- **Primary audience:** DEV-002 implementation, design handoff, QA test planning
- **Scope:** Prototype card content and runtime integration for the first playable slice
- **Depends on:**
  - `projects/emotion-cards-four/src/prototype-architecture-baseline.md`
  - `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`

---

## 1. Why this document exists

DES-002 defines what the cards are supposed to mean. DEV-001A defines the runtime architecture they must plug into. This document locks the middle layer: **how card content is represented as data, how that data is validated, and how it maps into deterministic runtime behavior in DEV-002**.

The prototype should treat cards as **content records using a constrained effect vocabulary**, not as bespoke scripted objects and not as freeform text parsing targets.

If this layer stays tight, design can iterate card wording and tuning without forcing engine rewrites.

---

## 2. Integration goals

The schema and content pipeline must support these goals:
- stable identifiers for save/load, logs, and analytics,
- one canonical card record shape across all categories,
- category-specific required fields without category-specific runtime classes,
- deterministic validation of legal play packages,
- tag-driven synergy and encounter-fit logic,
- separation between player-facing text and machine-facing logic,
- enough metadata for UI explanation, debug visibility, QA assertions, and tuning.

---

## 3. Content model principles

### 3.1 Single source of truth
Each card must exist as **one canonical definition record**. Runtime card instances may reference that definition by `id`, but the definition file is the source of truth for logic and presentation metadata.

### 3.2 Logic is structured, not inferred from text
`rulesText`, `readabilityNote`, and UI strings are descriptive only. Runtime behavior must come from structured fields like:
- `effects`
- `playRequirements`
- `synergyRules`
- `riskRules`
- `unlockRules`
- `tags`

### 3.3 Shared schema, constrained variation
All cards use the same base schema. Category determines:
- which slots they can occupy,
- which fields are required,
- which effect patterns are allowed,
- whether they are normally drawable or conditionally surfaced.

### 3.4 Prototype-first constraints
Do not build a general card scripting language here. If a card cannot be expressed via the allowed primitives and conditions in this document, it should either:
1. be simplified,
2. be represented as an encounter rule instead,
3. or be deferred.

---

## 4. Canonical card definition schema

Recommended implementation shape for DEV-002:

```ts
export type CardCategory =
  | 'emotion'
  | 'memory'
  | 'reaction'
  | 'shift'
  | 'breakthrough'

export type CardSlotRole = 'primary' | 'support' | 'breakthrough'

export interface CardDefinition {
  id: string
  name: string
  category: CardCategory
  deckRole: CardSlotRole

  intentTag: IntentTag
  toneTag: ToneTag
  riskTag: RiskTag
  tags: CardTag[]
  synergyTags: CardTag[]

  summaryText: string
  rulesText: string
  readabilityNote: string

  stateInfluence: Partial<Record<StateAxis, number>>
  effects: EffectPrimitive[]
  conditionalEffects?: ConditionalEffect[]
  playRequirements?: Requirement[]
  synergyRules?: SynergyRule[]
  riskRules?: RiskRule[]
  unlockRules?: UnlockRule[]

  responseWindowHints?: ResponseWindowId[]
  encounterFitTags?: EncounterKeyword[]
  carryForwardHooks?: CarryForwardHook[]

  drawBehavior: 'deck' | 'generated' | 'unlock_only'
  stackLimit?: number
  starterDeckEligible: boolean

  uiMeta: CardUiMeta
  contentVersion: number
}
```

### 4.1 Field definitions

#### Identity and classification
- `id`: stable machine identifier. Never change after implementation.
- `name`: player-facing title.
- `category`: one of the five prototype categories.
- `deckRole`: runtime slot behavior.

#### Intent / tone / risk
- `intentTag`: primary gameplay purpose.
- `toneTag`: emotional/behavioral presentation tone.
- `riskTag`: primary failure mode.

#### Logic tags
- `tags`: canonical machine-facing card tags used by encounter logic, validation, analytics, and synergy.
- `synergyTags`: narrower subset highlighting what this card enables or benefits from.

#### Presentation text
- `summaryText`: short front-of-card summary.
- `rulesText`: slightly fuller player-facing effect language.
- `readabilityNote`: design/QA note; not required in player UI.

#### Runtime behavior
- `stateInfluence`: simple baseline state deltas visible at content level.
- `effects`: unconditional primitives.
- `conditionalEffects`: conditional primitives tied to clear state/tag checks.
- `playRequirements`: legality checks before play resolves.
- `synergyRules`: bonus or altered behavior when a valid pairing/context exists.
- `riskRules`: explicit penalty or warning logic when misplayed.
- `unlockRules`: mainly for breakthrough cards and special surfaced states.

#### Encounter/runtime hooks
- `responseWindowHints`: content-side hint about intended windows; not a substitute for actual legality rules.
- `encounterFitTags`: the encounter contexts this card is intended to perform well in.
- `carryForwardHooks`: optional hooks if the card can affect next encounter state.

#### Distribution and decking
- `drawBehavior`:
  - `deck`: normal draw pile card
  - `generated`: surfaced temporarily by effect or encounter
  - `unlock_only`: never normally drawn; becomes available only when unlocked
- `stackLimit`: optional copy cap if needed by deck builder later.
- `starterDeckEligible`: whether the card can appear in the initial prototype deck.

#### UI metadata
- `uiMeta`: category color/icon/layout data and optional label strings.
- `contentVersion`: schema/content migration version for save compatibility.

---

## 5. Category-specific requirements

## 5.1 Emotion cards
**Purpose:** set turn tone and direction.

Required constraints:
- `category = 'emotion'`
- `deckRole = 'primary'`
- must be legal as a primary card
- should have exactly one baseline emotional direction
- should usually affect trust and/or momentum, with limited clarity impact
- should not directly resolve breakthrough on their own

Recommended limits:
- max 2 unconditional primitives
- max 1 conditional bonus block

## 5.2 Memory cards
**Purpose:** provide history/context support.

Required constraints:
- `category = 'memory'`
- `deckRole = 'support'`
- cannot be played alone in default prototype rules
- should primarily affect clarity and/or trust
- should usually gain value when paired with an emotion or reaction card

Recommended limits:
- at least 1 synergy rule or conditional effect
- should not be the sole source of direct collapse protection unless clearly framed as support

## 5.3 Reaction cards
**Purpose:** alter immediate exchange, protect, stabilize, redirect, or push.

Required constraints:
- `category = 'reaction'`
- `deckRole = 'primary'`
- legal as a primary card
- should directly affect tension, response windows, or immediate reaction pacing

Recommended limits:
- may include stronger defensive or pressure tools than emotion cards
- should still fit within primitive effect list; no bespoke reaction mini-engine

## 5.4 Shift cards
**Purpose:** reframe the encounter or alter what is playable/effective.

Required constraints:
- `category = 'shift'`
- `deckRole = 'support'`
- cannot be the only card in a response package under default rules
- should mainly operate on clarity, windows, keyword penalties, or momentum recovery

Recommended limits:
- at least one effect should interact with windows/tags/keyword penalties rather than only raw stats

## 5.5 Breakthrough cards
**Purpose:** represent earned payoff states, not generic hand actions.

Required constraints:
- `category = 'breakthrough'`
- `deckRole = 'breakthrough'`
- `drawBehavior = 'unlock_only'` unless explicitly surfaced by encounter flow
- must include `unlockRules`
- must include outcome-facing effects or resolution transformation logic
- cannot be part of a normal response package unless unlocked and legally surfaced

Recommended limits:
- no more than 1 core payoff effect plus 1 carry-forward bonus
- should depend on encounter state more than on named-card combinations

---

## 6. Canonical vocabularies

These vocabularies should be locked centrally and reused across card content, encounter templates, logs, and QA expectations.

## 6.1 Intent tags
```ts
type IntentTag =
  | 'connect'
  | 'stabilize'
  | 'reveal'
  | 'protect'
  | 'pressure'
  | 'reframe'
  | 'recover'
```

## 6.2 Tone tags
```ts
type ToneTag =
  | 'open'
  | 'guarded'
  | 'vulnerable'
  | 'assertive'
  | 'uncertain'
  | 'warm'
  | 'defensive'
  | 'playful'
  | 'heavy'
```

## 6.3 Risk tags
```ts
type RiskTag =
  | 'escalates_if_trust_low'
  | 'fails_if_clarity_low'
  | 'weak_if_tension_high'
  | 'punished_if_repeated'
  | 'requires_memory_support'
  | 'requires_open_window'
```

## 6.4 Core state axes
```ts
type StateAxis = 'tension' | 'trust' | 'clarity' | 'momentum'
```

## 6.5 Encounter keywords
These come from DES-002 and should remain controlled.

```ts
type EncounterKeyword =
  | 'fragile'
  | 'guarded'
  | 'misread'
  | 'public'
  | 'private'
  | 'heated'
  | 'stalled'
  | 'repairable'
  | 'defensive'
  | 'open_window'
```

## 6.6 Response windows
DEV-001A describes response windows as a runtime concept. For prototype implementation, use explicit IDs instead of freeform labels.

Recommended initial IDs:
```ts
type ResponseWindowId =
  | 'connect'
  | 'stabilize'
  | 'reveal'
  | 'protect'
  | 'pressure'
  | 'reframe'
  | 'recover'
  | 'repair'
  | 'boundary'
  | 'breakthrough'
```

Notes:
- the first seven mirror intent tags for clean mapping,
- `repair`, `boundary`, and `breakthrough` cover encounter-specific openings that are useful but not identical to intent,
- encounter templates may open/close these, but should not invent ad hoc values in prototype v1.

## 6.7 Machine-facing card tags
Beyond intent/tone/risk, cards need a broader normalized tag space for synergy and analytics.

Recommended `CardTag` families:
- category tags: `emotion`, `memory`, `reaction`, `shift`, `breakthrough`
- tone tags reused as machine tags where helpful
- intent tags reused as machine tags where helpful
- effect tags: `trust_gain`, `tension_drop`, `clarity_gain`, `momentum_gain`, `momentum_repair`, `window_open`, `window_close`, `collapse_guard`, `reaction_skip`, `misread_clear`, `keyword_remove`, `breakthrough_enable`
- risk tags reused as machine tags where helpful
- encounter-fit tags mirrored from `EncounterKeyword` when needed

Guardrail: use a documented tag list file or exported constants module. Do not let tags drift through typo-based strings.

---

## 7. Effect primitive schema

Cards must resolve through constrained, serializable primitives.

```ts
export type EffectPrimitive =
  | ModifyStatEffect
  | ClampStatEffect
  | AddTagEffect
  | RemoveTagEffect
  | OpenResponseWindowEffect
  | CloseResponseWindowEffect
  | AddModifierEffect
  | RemoveModifierEffect
  | ProtectFromCollapseEffect
  | DrawCardsEffect
  | RetainCardEffect
  | ClearPenaltyEffect
  | RerunReactionCheckEffect
  | UpgradeOutcomeEffect
  | UnlockBreakthroughEffect
```

Recommended minimal shapes:

```ts
interface ModifyStatEffect {
  type: 'modify_stat'
  stat: StateAxis
  amount: number
  reasonId?: string
}

interface AddTagEffect {
  type: 'add_tag'
  tag: string
  target: 'card_play' | 'encounter' | 'turn'
}

interface RemoveTagEffect {
  type: 'remove_tag'
  tag: string
  target: 'encounter' | 'turn'
}

interface OpenResponseWindowEffect {
  type: 'open_response_window'
  windowId: ResponseWindowId
}

interface CloseResponseWindowEffect {
  type: 'close_response_window'
  windowId: ResponseWindowId
}

interface AddModifierEffect {
  type: 'add_modifier'
  modifierId: string
  duration: 'turn' | 'encounter' | 'run'
}

interface ProtectFromCollapseEffect {
  type: 'protect_from_collapse'
  amount?: number
  scope: 'direct_pressure' | 'turn' | 'reaction_step'
}

interface ClearPenaltyEffect {
  type: 'clear_penalty'
  penaltyId: string
  count?: number
}

interface RerunReactionCheckEffect {
  type: 'rerun_reaction_check'
  improveStat?: StateAxis
  improveAmount?: number
}

interface UpgradeOutcomeEffect {
  type: 'upgrade_outcome'
  from: 'partial' | 'stalemate'
  to: 'breakthrough'
}

interface UnlockBreakthroughEffect {
  type: 'unlock_breakthrough'
  breakthroughId: string
}
```

### 7.1 Primitive guardrails
- Effects must be serializable and deterministic.
- Effects must declare explicit targets and ids.
- Effects must not embed executable code or freeform formulas.
- If a card needs encounter-specific interpretation, that should happen through condition matching or encounter rule config, not by card-local scripting.

---

## 8. Conditions, requirements, synergy, and risk rules

## 8.1 Requirement shape
Requirements gate whether a card or package is legal to submit.

```ts
interface Requirement {
  type:
    | 'min_stat'
    | 'max_stat'
    | 'has_open_window'
    | 'requires_support_category'
    | 'requires_tag_present'
    | 'requires_failed_or_weak_turn'
    | 'is_unlocked'
  value: string | number
  stat?: StateAxis
  category?: CardCategory
  windowId?: ResponseWindowId
  tag?: string
  messageKey: string
}
```

## 8.2 Conditional effect shape
```ts
interface ConditionalEffect {
  if: ConditionSet
  then: EffectPrimitive[]
  explanationKey?: string
}
```

## 8.3 Synergy rule shape
```ts
interface SynergyRule {
  id: string
  if: ConditionSet
  bonusEffects: EffectPrimitive[]
  explanationKey: string
}
```

## 8.4 Risk rule shape
```ts
interface RiskRule {
  id: string
  if: ConditionSet
  penaltyEffects: EffectPrimitive[]
  explanationKey: string
}
```

## 8.5 Unlock rule shape
```ts
interface UnlockRule {
  id: string
  if: ConditionSet
  availability: 'surface' | 'enable_play'
  explanationKey: string
}
```

## 8.6 Condition vocabulary
Prototype conditions should only reference controlled data points:
- current stats (`tension`, `trust`, `clarity`, `momentum`)
- open/closed response windows
- encounter keywords
- card categories in current package
- tags contributed by the played package
- prior turn flags (`failedPlayCount`, `lastOutcomeBand`, `breakthroughReady`, `collapseArmed`)
- unlocked breakthrough ids

Recommended condition operators:
- `stat_gte`, `stat_lte`
- `encounter_has_keyword`, `encounter_lacks_keyword`
- `window_open`, `window_closed`
- `package_has_category`
- `package_has_tag`
- `paired_with_card_id` only if absolutely needed
- `failed_play_count_gte`
- `last_turn_was_weak`
- `breakthrough_ready`
- `card_unlocked`

Guardrail: avoid `paired_with_card_id` as the default synergy mechanism. Prefer tags, categories, and encounter state.

---

## 9. Play package legality and slot mapping

DEV-001A already defines the intended turn package model. This document makes it concrete for implementation.

## 9.1 Default prototype package
- exactly 1 primary card,
- optional 1 support card,
- optional modifier slot only if later enabled by encounter/card rules,
- breakthrough cards are not normal support or primary cards.

## 9.2 Slot legality by category
| Category | Legal as Primary | Legal as Support | Normal Draw | Notes |
|---|---:|---:|---:|---|
| Emotion | Yes | No | Yes | baseline emotional stance |
| Memory | No | Yes | Yes | support/context only in v1 |
| Reaction | Yes | No | Yes | immediate response/action |
| Shift | No | Yes | Yes | support/reframe only in v1 |
| Breakthrough | No | No* | No | only surfaced/unlocked through rules |

`*` Breakthrough is only playable through special surfaced state, not via default support slot.

## 9.3 Illegal package examples
- no primary card submitted,
- memory or shift card submitted without primary,
- two primary cards,
- two support cards,
- breakthrough card submitted without unlock/surface permission,
- card submitted into a closed required window,
- card requiring a failed prior turn when that condition is false.

## 9.4 Package-level derived tags
Before resolution, runtime should derive a package tag set from:
- `intentTag`
- `toneTag`
- `riskTag`
- `tags`
- `synergyTags`
- category tags

This derived set is what encounter reaction logic and synergy evaluation should primarily inspect.

---

## 10. Validation rules

Validation should happen in two layers: **content validation** and **runtime play validation**.

## 10.1 Content validation
Executed when card data is loaded or built.

Each card must pass:
- `id` present, unique, and format-valid,
- required base fields present,
- enum values valid,
- category/slot combination valid,
- `stateInfluence` only uses allowed axes,
- `effects` only use allowed primitive types,
- all referenced `windowId`, `tag`, `modifierId`, `breakthroughId`, and `messageKey` values are defined,
- breakthrough cards must include `unlockRules`,
- non-breakthrough cards must not use `drawBehavior = 'unlock_only'` unless explicitly approved,
- no card exceeds prototype complexity limits,
- all conditional/synergy/risk rules resolve against legal condition vocabulary.

Recommended id pattern:
```txt
E-001 .. E-999
M-001 .. M-999
R-001 .. R-999
S-001 .. S-999
B-001 .. B-999
```

## 10.2 Runtime play validation
Executed when a player submits a response package.

Checks:
1. phase is `play_response`
2. exactly one legal primary card present
3. optional support card is legal for slot
4. all package cards are in hand or surfaced availability pool
5. all card requirements pass
6. package-level restrictions pass
7. breakthrough cards only allowed when unlocked and surfaced
8. selected package does not violate explicit encounter restrictions

On validation failure:
- reject without mutating state,
- emit `play_validation_failed`,
- return machine-readable reason ids plus player-readable explanation text.

## 10.3 Complexity limits
To prevent schema creep, enforce these prototype limits:
- max 2 unconditional effects per card,
- max 1 conditional effect block,
- max 2 synergy rules,
- max 1 risk rule,
- max 1 unlock rule for normal cards,
- max 2 unlock rules for breakthrough cards,
- no nested conditions beyond a simple AND list in v1.

---

## 11. Content boundaries: what belongs where

This is the part most likely to get muddy if not locked now.

## 11.1 What belongs in card content
Card data should own:
- identity,
- category/slot role,
- intent/tone/risk metadata,
- base state changes,
- card-local conditions,
- general synergy hooks,
- player-facing text,
- optional carry-forward hooks directly caused by the card.

## 11.2 What belongs in encounter templates
Encounter data should own:
- starting stats,
- starting/opening windows,
- keyword context,
- opposition reaction rules,
- escalation patterns,
- breakthrough/collapse thresholds,
- which package tags or plays are rewarded/punished in that encounter,
- surfaced breakthrough opportunities.

## 11.3 What belongs in runtime engine code
Runtime systems should own:
- turn phase transitions,
- package validation order,
- effect resolution order,
- rule evaluation order,
- stat clamping,
- save/load serialization,
- event emission,
- debug and explanation assembly.

## 11.4 What should not be in card data
Do not put these directly into card content for prototype v1:
- arbitrary script functions,
- direct UI layout behavior beyond metadata,
- hand-authored encounter-specific hardcode per card,
- long flavor prose used as logic source,
- engine callbacks,
- random roll tables.

---

## 12. Data relationships

## 12.1 Card definition vs card instance
Use separate types.

```ts
interface CardInstance {
  instanceId: string
  definitionId: string
  zone: 'draw' | 'hand' | 'discard' | 'exhaust' | 'surface'
  temporaryCostMods?: never // not used in v1 unless resource model changes
  transientTags?: string[]
}
```

`CardInstance` should be lightweight. Logic lives in `CardDefinition`.

## 12.2 Cards and encounter templates
Encounter rules should target cards through:
- category,
- intent tag,
- package tag sets,
- encounter-fit tags,
- specific ids only when the prototype absolutely requires a bespoke named moment.

Preferred priority:
1. tags/intents/windows
2. category
3. explicit card id as exception

## 12.3 Cards and carry-forward
Most carry-forward changes should come from **encounter results** and specific breakthrough effects, not from ordinary card spam.

Use `carryForwardHooks` sparingly for cards that explicitly promise next-encounter impact, for example:
- `B-002 Stable Repair` granting trust bonus into next encounter,
- a surfaced breakthrough card blocking a penalty tag,
- a special support effect unlocking a future card.

## 12.4 Cards and analytics
Every card must be traceable through:
- `id`
- `category`
- `intentTag`
- `toneTag`
- derived package tags

That gives analytics enough structure without fragile text parsing.

---

## 13. Design-to-runtime mapping for the current prototype list

This section translates the DES-002 card language into how DEV-002 should treat it.

## 13.1 Mapping rules by design field

### Intent Tag
Maps to:
- one canonical `intentTag` field,
- package-derived tag,
- likely matching response window id,
- analytics grouping,
- UI badge/icon if desired.

### Tone Tag
Maps to:
- one canonical `toneTag` field,
- descriptive UI styling hook,
- optional package tag for encounter reactions.

### Primary Effect
Maps to:
- one or more unconditional `effects`,
- mirrored in `stateInfluence` if it changes core axes.

### Conditional
Maps to:
- either `conditionalEffects`, `synergyRules`, or `unlockRules`.

Rule of thumb:
- use `conditionalEffects` when the card’s own effect changes based on state,
- use `synergyRules` when the bonus depends on what it was paired with,
- use `unlockRules` when it controls special availability.

### Risk Tag
Maps to:
- `riskTag`,
- optional `riskRules`,
- explanation messaging when the failure state occurs.

### Readability Note
Maps to:
- `readabilityNote` only,
- optionally QA/dev debug panels,
- not runtime effect logic.

## 13.2 Example translations

### E-001 Concern
Design says:
- intent `connect`
- tone `open`
- primary `+1 Trust`
- conditional `if paired with Memory, +1 Clarity`

Runtime-friendly shape:
```ts
{
  id: 'E-001',
  name: 'Concern',
  category: 'emotion',
  deckRole: 'primary',
  intentTag: 'connect',
  toneTag: 'open',
  riskTag: 'weak_if_tension_high',
  tags: ['emotion', 'connect', 'open', 'trust_gain'],
  synergyTags: ['memory_pair', 'clarity_gain'],
  stateInfluence: { trust: 1 },
  effects: [{ type: 'modify_stat', stat: 'trust', amount: 1 }],
  synergyRules: [
    {
      id: 'concern_memory_bonus',
      if: { all: [{ type: 'package_has_category', category: 'memory' }] },
      bonusEffects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }],
      explanationKey: 'card.concern.memory_bonus'
    }
  ],
  drawBehavior: 'deck',
  starterDeckEligible: true,
  contentVersion: 1
}
```

### M-006 Missed Signal
Design says:
- remove one `misread` penalty,
- if paired with Concern, open safer response window.

Runtime-friendly interpretation:
- `clear_penalty` or `remove_tag` depending on encounter implementation,
- named-card pairing can be allowed here because the design callout is specific, but tag-based pairing is cleaner if generalized to `connect` + `misread_clear`.

### R-004 Hold Boundary
Design says:
- prevent collapse from direct pressure this turn,
- conditional trust-high bonus.

Runtime mapping:
- `protect_from_collapse` primitive,
- optional `modify_stat(momentum, +1)` under `trust >= threshold`.

### S-004 Try Again Differently
Design says:
- replay reaction check with one improved state value of your choice,
- only usable after failed or weak turn.

Runtime mapping:
- play requirement `requires_failed_or_weak_turn`,
- primitive `rerun_reaction_check` with constrained chosen axis and amount,
- no general rollback system; just rerun the reaction evaluation using a bounded improvement modifier.

### B-002 Stable Repair
Design says:
- convert likely partial into breakthrough under low tension and positive momentum,
- grant carry-forward trust bonus.

Runtime mapping:
- `unlockRules` based on state and breakthrough readiness,
- `upgrade_outcome` from partial to breakthrough,
- `carryForwardHooks` or an effect recorded at encounter resolution.

---

## 14. Runtime resolution contract for DEV-002

When cards are played, DEV-002 should process them in this order.

## 14.1 Resolution order
1. validate package legality
2. derive package tags and package context
3. resolve primary card unconditional effects
4. resolve support card unconditional effects
5. resolve primary/support conditional effects
6. resolve synergy rules
7. resolve risk rules triggered by current state/package
8. apply encounter modifiers and carry-forward turn modifiers
9. clamp stats and update windows/flags
10. hand off package summary to opposition reaction rules
11. emit explanation payload and instrumentation

This aligns with DEV-001A while making content-owned logic boundaries explicit.

## 14.2 Explanation payload requirements
Each resolved package should produce an explanation object such as:

```ts
interface ResolvedPlayExplanation {
  primaryCardId: string
  supportCardId?: string
  appliedEffectIds: string[]
  triggeredSynergyRuleIds: string[]
  triggeredRiskRuleIds: string[]
  derivedTags: string[]
  summaryLines: string[]
}
```

This is necessary for:
- player readability,
- dev debug panels,
- QA assertion clarity,
- analytics attribution.

---

## 15. Suggested content storage structure

Prototype-friendly storage recommendation:

```txt
projects/emotion-cards-four/
  src/
    data/
      cards/
        emotions.json
        memories.json
        reactions.json
        shifts.json
        breakthroughs.json
      vocab/
        card-tags.ts
        response-windows.ts
        effect-types.ts
```

Alternative: keep all cards in one file if the set remains tiny. But vocab/constants should still be centralized.

Preferred authoring shape for prototype:
- human-editable JSON or TS object literals,
- validated at load/build time,
- exported into runtime registries keyed by `id`.

---

## 16. QA and implementation acceptance criteria

DEV-001B should be considered satisfied for implementation if DEV-002 can rely on these truths:
- every prototype card can be represented without bespoke runtime code,
- every card category has clear slot legality,
- tags and windows are canonical and finite,
- breakthrough cards have a distinct unlock-only path,
- runtime can explain why a card succeeded or failed,
- content validation can reject malformed definitions before play,
- encounter rules can react to package tags rather than card-specific hardcode in most cases.

---

## 17. Recommendations

### Strong recommendation 1: keep intent and response windows aligned
Using the same vocabulary for both greatly reduces logic drift and makes the game easier to explain.

### Strong recommendation 2: prefer tag- and state-based synergy over named-card pair locks
Specific named combos are fine as spice, but the core system should reward reading the encounter, not memorizing bespoke recipes.

### Strong recommendation 3: make breakthrough cards surfaced state, not hidden random draws
That better matches the prototype’s readability promise and keeps outcome causality visible.

### Strong recommendation 4: validate content automatically before runtime integration
Bad tags or broken window ids will create subtle bugs fast. Catch them on load.

### Strong recommendation 5: do not let card text become logic source
Player wording should explain behavior, not define it.

---

## 18. Final implementation call

For DEV-002, the right move is a **single structured card definition model plus a strict validator and a small effect interpreter**.

That gives the prototype what it actually needs:
- readable content,
- deterministic resolution,
- faster tuning,
- safer save/load,
- cleaner analytics,
- and far less downstream pain than ad hoc card scripting.

---

**Deliverable path:** `projects/emotion-cards-four/src/card-schema-and-content-integration.md`
