// v1-card-pool-expansion.js — 14 additional cards for Emotion Cards Four v1
// Adds to the existing 15 cards in data.js, bringing the pool to 29 cards
// All card IDs, intent tags, tone tags, risk tags reference vocabulary.js constants

import {
  CATEGORIES,
  INTENT_TAGS,
  TONE_TAGS,
  RISK_TAGS,
  DECK_ROLES,
  CARD_TAGS,
  RESPONSE_WINDOWS,
  ENCOUNTER_KEYWORDS,
  STATS,
} from '../src/vocabulary.js';

/**
 * EXPANSION_CARD_DEFINITIONS — 14 cards added to the starter pool.
 * Categories: REACTION ×2, EMOTION ×6, MEMORY ×3, SHIFT ×4 (one id gap each)
 */
export const EXPANSION_CARD_DEFINITIONS = [

  // ── Reactions ─────────────────────────────────────────────────────────────

  {
    id: 'R-005',
    name: 'Stand Ground',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: null,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.PROTECT, TONE_TAGS.ASSERTIVE, CARD_TAGS.COLLAPSE_GUARD],
    summaryText: 'Hold the line without collapsing.',
    rulesText: 'Prevent collapse this turn regardless of tension or failed play count. If trust is 5 or higher, gain 1 momentum.',
    effects: [
      { type: 'add_modifier', modifierId: 'collapse_guard', duration: 'turn' },
    ],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.TRUST, value: 5 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
  },

  {
    id: 'R-008',
    name: 'Yield Ground',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.GUARDED,
    riskTag: null,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.STABILIZE, TONE_TAGS.GUARDED, CARD_TAGS.TENSION_DROP],
    summaryText: 'Step back to reduce tension and open a recovery path.',
    rulesText: 'Reduce tension by 2 and open recover. If momentum is above 0, spend 1 momentum.',
    effects: [
      { type: 'modify_stat', stat: STATS.TENSION, amount: -2 },
      { type: 'open_response_window', windowId: RESPONSE_WINDOWS.RECOVER },
    ],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.MOMENTUM, value: 1 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  // ── Emotions ───────────────────────────────────────────────────────────────

  {
    id: 'E-004',
    name: 'Anger',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PRESSURE,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.PRESSURE, TONE_TAGS.ASSERTIVE, CARD_TAGS.ESCALATE],
    summaryText: 'Force an immediate reaction. High tension makes it cost trust.',
    rulesText: 'Force immediate encounter reaction. If tension is 7 or higher, also gain 1 tension and lose 1 trust.',
    effects: [
      { type: 'force_encounter_reaction', timing: 'immediate' },
    ],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.TENSION, value: 7 } },
        then: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
        ],
      },
    ],
    riskRules: [
      {
        id: 'anger_low_trust',
        if: { statLte: { stat: STATS.TRUST, value: 3 } },
        penaltyEffects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
        ],
      },
    ],
  },

  {
    id: 'E-006',
    name: 'Fear',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.UNCERTAIN,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.PROTECT, TONE_TAGS.UNCERTAIN, CARD_TAGS.REACTION_SKIP],
    summaryText: 'Block the next negative encounter reaction and soften its cost.',
    rulesText: 'Cancel the next negative encounter reaction. Reduce momentum loss from that reaction by 1. If paired with Memory, gain 1 clarity.',
    effects: [
      { type: 'add_modifier', modifierId: 'reaction_skip', duration: 1 },
    ],
    synergyRules: [
      {
        id: 'fear_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'fear_low_clarity',
        if: { statLte: { stat: STATS.CLARITY, value: 2 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  {
    id: 'E-007',
    name: 'Determination',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.RECOVER, TONE_TAGS.ASSERTIVE, CARD_TAGS.MOMENTUM_GAIN],
    summaryText: 'Pull momentum back to neutral or positive territory.',
    rulesText: 'If momentum is -1 or lower, move it to 0. If momentum is 0 or higher, gain 1 momentum. If paired with Memory, gain 1 trust.',
    effects: [
      { type: 'set_stat', stat: STATS.MOMENTUM, value: 0, condition: 'if_lower' },
    ],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.MOMENTUM, value: 0 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
      {
        if: { packageHasCategory: CATEGORIES.MEMORY },
        then: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'determination_high_tension',
        if: { statGte: { stat: STATS.TENSION, value: 7 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  {
    id: 'E-008',
    name: 'Relief Through Laughter',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.PLAYFUL,
    riskTag: RISK_TAGS.PUNISHED_IF_REPEATED,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.STABILIZE, TONE_TAGS.PLAYFUL, CARD_TAGS.TENSION_DROP],
    summaryText: 'Ease tension through levity, unless the encounter is public.',
    rulesText: 'If the encounter is not heated, reduce tension by 1. If the encounter is public, this card has no tension reduction and the encounter becomes volatile.',
    effects: [],
    conditionalEffects: [
      {
        if: { encounterHasKeywordNotIn: [ENCOUNTER_KEYWORDS.HEATED] },
        then: [{ type: 'modify_stat', stat: STATS.TENSION, amount: -1 }],
      },
      {
        if: { encounterHasKeyword: ENCOUNTER_KEYWORDS.PUBLIC },
        then: [{ type: 'add_encounter_keyword', keyword: ENCOUNTER_KEYWORDS.HEATED }],
      },
    ],
    riskRules: [
      {
        id: 'relief_repeated',
        if: { cardPlayedTwiceInEncounter: true },
        penaltyEffects: [
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
          { type: 'add_encounter_keyword', keyword: ENCOUNTER_KEYWORDS.HEATED },
        ],
      },
    ],
  },

  {
    id: 'E-009',
    name: 'Doubt',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.UNCERTAIN,
    riskTag: RISK_TAGS.REQUIRES_MEMORY_SUPPORT,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.REVEAL, TONE_TAGS.UNCERTAIN, CARD_TAGS.CLARITY_GAIN],
    summaryText: 'Gain clarity but at a trust cost without protection.',
    rulesText: 'Gain 1 clarity. If not paired with a protect reaction, lose 1 trust.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 1 },
    ],
    conditionalEffects: [
      {
        if: { packageHasCategoryNot: CATEGORIES.REACTION, reactionHasIntentNot: INTENT_TAGS.PROTECT },
        then: [{ type: 'modify_stat', stat: STATS.TRUST, amount: -1 }],
        else: [],
      },
    ],
    riskRules: [
      {
        id: 'doubt_no_memory',
        if: { packageHasCategoryNot: CATEGORIES.MEMORY },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: -1 }],
      },
    ],
  },

  // ── Memory ────────────────────────────────────────────────────────────────

  {
    id: 'M-005',
    name: 'Repeated Pattern',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.GUARDED,
    riskTag: RISK_TAGS.PUNISHED_IF_REPEATED,
    tags: [CATEGORIES.MEMORY, INTENT_TAGS.REVEAL, TONE_TAGS.GUARDED, CARD_TAGS.CLARITY_GAIN, CARD_TAGS.KEYWORD_ADD],
    summaryText: 'Spot the loop and name it — clarity now, momentum later.',
    rulesText: 'Gain 1 clarity. Encounter gains the defensive keyword. If the next turn plays a Shift card, gain 1 momentum.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 1 },
      { type: 'add_encounter_keyword', keyword: ENCOUNTER_KEYWORDS.DEFENSIVE },
    ],
    conditionalEffects: [
      {
        if: { nextCardCategory: CATEGORIES.SHIFT },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'repeated_pattern_repeated',
        if: { cardPlayedTwiceInEncounter: true },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -2 }],
      },
    ],
  },

  {
    id: 'M-007',
    name: 'Hidden Cost',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.HEAVY,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [CATEGORIES.MEMORY, INTENT_TAGS.REVEAL, TONE_TAGS.HEAVY, CARD_TAGS.CLARITY_GAIN],
    summaryText: 'Expose what\'s underneath — big clarity, but tension rises.',
    rulesText: 'Gain 2 clarity and 1 tension. If paired with a protect reaction, cancel the tension rise.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 2 },
      { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
    ],
    synergyRules: [
      {
        id: 'hidden_cost_protect',
        if: { packageHasIntentTag: INTENT_TAGS.PROTECT },
        bonusEffects: [{ type: 'cancel_last_effect', stat: STATS.TENSION }],
      },
    ],
    riskRules: [
      {
        id: 'hidden_cost_low_trust',
        if: { statLte: { stat: STATS.TRUST, value: 3 } },
        penaltyEffects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
          { type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 },
        ],
      },
    ],
  },

  {
    id: 'M-008',
    name: 'Shared Victory',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.CONNECT,
    toneTag: TONE_TAGS.WARM,
    riskTag: null,
    tags: [CATEGORIES.MEMORY, INTENT_TAGS.CONNECT, TONE_TAGS.WARM, CARD_TAGS.TRUST_GAIN, CARD_TAGS.MOMENTUM_GAIN],
    summaryText: 'Celebrate progress together — trust, momentum, and clarity if results are positive.',
    rulesText: 'Gain 1 trust and 1 momentum. If the run has net positive results, gain 1 clarity.',
    effects: [
      { type: 'modify_stat', stat: STATS.TRUST, amount: 1 },
      { type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 },
    ],
    conditionalEffects: [
      {
        if: { runNetPositiveResults: true },
        then: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
  },

  // ── Shifts ────────────────────────────────────────────────────────────────

  {
    id: 'S-003',
    name: 'Name the Pattern',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.HEAVY,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [CATEGORIES.SHIFT, INTENT_TAGS.REVEAL, TONE_TAGS.HEAVY, CARD_TAGS.CLARITY_GAIN, CARD_TAGS.KEYWORD_ADD],
    summaryText: 'High-clarity reveal that makes the encounter fragile and unlocks breakthrough.',
    rulesText: 'Gain 2 clarity. Encounter gains the fragile keyword. If trust is 5 or higher, set breakthroughReady.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 2 },
      { type: 'add_encounter_keyword', keyword: ENCOUNTER_KEYWORDS.FRAGILE },
    ],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.TRUST, value: 5 } },
        then: [{ type: 'set_breakthrough_ready', value: true }],
      },
    ],
    riskRules: [
      {
        id: 'name_the_pattern_low_trust',
        if: { statLte: { stat: STATS.TRUST, value: 3 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  {
    id: 'S-004',
    name: 'Try Again Differently',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.REQUIRES_OPEN_WINDOW,
    tags: [CATEGORIES.SHIFT, INTENT_TAGS.RECOVER, TONE_TAGS.WARM],
    summaryText: 'Replay a weak encounter reaction with one stat improved.',
    rulesText: 'Replay the previous encounter reaction with one stat of your choice improved by 1. Usable only after a failed or weak turn.',
    effects: [
      { type: 'replay_last_encounter_reaction', statBoost: { amount: 1, choice: 'player' } },
    ],
    riskRules: [
      {
        id: 'try_again_no_window',
        if: { noOpenWindow: true },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  {
    id: 'S-005',
    name: 'Fresh Start',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.OPEN,
    riskTag: null,
    tags: [CATEGORIES.SHIFT, INTENT_TAGS.RECOVER, TONE_TAGS.OPEN, CARD_TAGS.KEYWORD_REMOVE],
    summaryText: 'Strip a blocking keyword and open a recovery path.',
    rulesText: 'Remove one keyword from misread, defensive, or stalled. Open recover.',
    effects: [
      { type: 'remove_keyword_one_of', keywords: [ENCOUNTER_KEYWORDS.MISREAD, ENCOUNTER_KEYWORDS.DEFENSIVE, ENCOUNTER_KEYWORDS.STALLED] },
      { type: 'open_response_window', windowId: RESPONSE_WINDOWS.RECOVER },
    ],
  },

  {
    id: 'S-006',
    name: 'Deep Breath',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.WARM,
    riskTag: null,
    tags: [CATEGORIES.SHIFT, INTENT_TAGS.STABILIZE, TONE_TAGS.WARM, CARD_TAGS.TENSION_DROP, 'tension_lock'],
    summaryText: 'Reduce tension and freeze its growth for one state refresh.',
    rulesText: 'Reduce tension by 1. Prevent tension from increasing during the next state refresh.',
    effects: [
      { type: 'modify_stat', stat: STATS.TENSION, amount: -1 },
      { type: 'add_modifier', modifierId: 'no_tension_increase', duration: 'state_refresh' },
    ],
  },

] // end EXPANSION_CARD_DEFINITIONS
