/**
 * v1-card-pool-expansion.js
 * ──────────────────────────
 * Emotion Cards Four — GDD Design Artifact
 *
 * 14 additional CARD_DEFINITIONS appended to the 15-card base pool
 * from src/data.js, targeting the DES-V1-002 / DES-V1-004a 35-card
 * v1 flagship pool (32 active + 3 breakthroughs).
 *
 * Card IDs are allocated as follows:
 *   R-005  Stand Ground         (Priority 1 — protect gap fix)
 *   R-008  Yield Ground         (Priority 2 — second stabilize reaction)
 *   E-004  Anger                (Priority 4 — pressure coverage)
 *   E-006  Fear                 (Priority 2 — protect emotion)
 *   E-007  Determination         (Priority 2 — recover emotion)
 *   E-008  Relief Through Laughter (Priority 2 — stabilize emotion)
 *   E-009  Doubt                (Priority 3 — reveal emotion)
 *   M-005  Repeated Pattern     (Priority 3 — reveal memory)
 *   M-007  Hidden Cost          (Priority 2 — reveal memory)
 *   M-008  Shared Victory       (Priority 2 — connect memory)
 *   S-003  Name the Pattern     (Priority 4 — Old Grudge coverage)
 *   S-004  Try Again Differently (Priority 4 — recover shift)
 *   S-005  Fresh Start          (Priority 3 — recover shift)
 *   S-006  Deep Breath          (Priority 3 — stabilize shift)
 *
 * All IDs, intent tags, tone tags, risk tags, response windows, and
 * encounter keywords reference canonical constants from vocabulary.js.
 */

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
} from '../src/vocabulary.js'

// ---------------------------------------------------------------------------
// Additional Card Definitions
// ---------------------------------------------------------------------------

export const EXPANSION_CARD_DEFINITIONS = [

  // ══════════════════════════════════════════════════════════════════════════
  // REACTIONS
  // ══════════════════════════════════════════════════════════════════════════

  // ── R-005 · Stand Ground ──────────────────────────────────────────────────

  {
    id: 'R-005',
    name: 'Stand Ground',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: RISK_TAGS.PUNISHED_IF_REPEATED,
    tags: [
      CATEGORIES.REACTION,
      INTENT_TAGS.PROTECT,
      TONE_TAGS.ASSERTIVE,
      CARD_TAGS.COLLAPSE_GUARD,
    ],
    summaryText:
      'Prevent collapse this turn regardless of tension or failed play count. At higher trust, gain momentum.',
    rulesText:
      'Gain a one-turn collapse shield: you cannot collapse this turn even if tension is at maximum or the encounter would otherwise force collapse. If trust is 5 or higher, gain 1 momentum.',
    effects: [{ type: 'add_modifier', modifierId: 'collapse_shield', duration: 'turn' }],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.TRUST, value: 5 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
    synergyRules: [],
    riskRules: [
      {
        id: 'stand_ground_repeat_penalty',
        if: { primaryCardId: 'R-005' }, // already played this encounter
        penaltyEffects: [
          { type: 'modify_stat', stat: STATS.CLARITY, amount: -1 },
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
        ],
      },
    ],
  },

  // ── R-008 · Yield Ground ──────────────────────────────────────────────────

  {
    id: 'R-008',
    name: 'Yield Ground',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.GUARDED,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [
      CATEGORIES.REACTION,
      INTENT_TAGS.STABILIZE,
      TONE_TAGS.GUARDED,
      CARD_TAGS.TENSION_DROP,
    ],
    summaryText:
      '-2 tension and opens a recover window. Costs 1 momentum if already positive.',
    rulesText:
      'Reduce tension by 2 and open the recover response window. If momentum is currently positive (1 or higher), lose 1 momentum as the cost of yielding.',
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
    synergyRules: [
      {
        id: 'yield_ground_memory_synergy',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'yield_ground_high_tension_weak',
        if: { statGte: { stat: STATS.TENSION, value: 8 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  // ══════════════════════════════════════════════════════════════════════════
  // EMOTIONS
  // ══════════════════════════════════════════════════════════════════════════

  // ── E-004 · Anger ─────────────────────────────────────────────────────────

  {
    id: 'E-004',
    name: 'Anger',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PRESSURE,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [
      CATEGORIES.EMOTION,
      INTENT_TAGS.PRESSURE,
      TONE_TAGS.ASSERTIVE,
      CARD_TAGS.TENSION_DROP, // forces immediate reaction — reduces drift
    ],
    summaryText:
      'Force an immediate encounter reaction. At very high tension it costs trust.',
    rulesText:
      'Force the encounter to react immediately — skip the next response window and trigger encounter reaction resolution now. If tension is 7 or higher, tension also increases by 1 and trust decreases by 1.',
    effects: [{ type: 'force_encounter_reaction', skipNextWindow: true }],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.TENSION, value: 7 } },
        then: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
        ],
      },
    ],
    synergyRules: [
      {
        id: 'anger_low_tension_bonus',
        if: { statLte: { stat: STATS.TENSION, value: 4 } },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
    riskRules: [],
  },

  // ── E-006 · Fear ──────────────────────────────────────────────────────────

  {
    id: 'E-006',
    name: 'Fear',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.UNCERTAIN,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [
      CATEGORIES.EMOTION,
      INTENT_TAGS.PROTECT,
      TONE_TAGS.UNCERTAIN,
      CARD_TAGS.COLLAPSE_GUARD,
    ],
    summaryText:
      'Cancel the next negative encounter reaction and reduce its momentum drain. Synergizes with memory.',
    rulesText:
      'Place a shield on the next negative encounter reaction: cancel it and halve any momentum drain it would cause. If paired with Memory, gain 1 clarity.',
    effects: [{ type: 'add_modifier', modifierId: 'fear_shield', duration: 'encounter' }],
    synergyRules: [
      {
        id: 'fear_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'fear_low_clarity_fails',
        if: { statLte: { stat: STATS.CLARITY, value: 2 } },
        penaltyEffects: [
          { type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 },
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
        ],
      },
    ],
  },

  // ── E-007 · Determination ────────────────────────────────────────────────

  {
    id: 'E-007',
    name: 'Determination',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [
      CATEGORIES.EMOTION,
      INTENT_TAGS.RECOVER,
      TONE_TAGS.ASSERTIVE,
      CARD_TAGS.MOMENTUM_GAIN,
    ],
    summaryText:
      'Climb out of negative momentum or push positive momentum higher. Memory support adds trust.',
    rulesText:
      'If momentum is negative, move it to neutral (set to 0). If momentum is neutral or positive, gain 1 momentum. If paired with Memory, gain 1 trust.',
    effects: [],
    conditionalEffects: [
      {
        if: { statLte: { stat: STATS.MOMENTUM, value: -1 } },
        then: [{ type: 'set_stat', stat: STATS.MOMENTUM, value: 0 }],
      },
      {
        if: { statGte: { stat: STATS.MOMENTUM, value: 0 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
    synergyRules: [
      {
        id: 'determination_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
    riskRules: [],
  },

  // ── E-008 · Relief Through Laughter ──────────────────────────────────────

  {
    id: 'E-008',
    name: 'Relief Through Laughter',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.PLAYFUL,
    riskTag: RISK_TAGS.PUNISHED_IF_REPEATED,
    tags: [
      CATEGORIES.EMOTION,
      INTENT_TAGS.STABILIZE,
      TONE_TAGS.PLAYFUL,
      CARD_TAGS.TENSION_DROP,
    ],
    summaryText:
      '-1 tension in non-heated encounters. In public encounters it becomes volatile on repetition.',
    rulesText:
      'Reduce tension by 1. If the encounter is heated, this has no effect. If the encounter is public and you have already played Relief Through Laughter this encounter, tension instead increases by 1.',
    effects: [{ type: 'modify_stat', stat: STATS.TENSION, amount: -1 }],
    conditionalEffects: [
      {
        if: { encounterHasKeyword: ENCOUNTER_KEYWORDS.HEATED },
        then: [], // no effect
      },
      {
        if: {
          encounterHasKeyword: ENCOUNTER_KEYWORDS.PUBLIC,
          alreadyPlayedThisEncounter: 'E-008',
        },
        then: [
          { type: 'set_stat', stat: STATS.TENSION, value: 'current' }, // cancel -1
          { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },    // replace with +1
        ],
      },
    ],
    synergyRules: [],
    riskRules: [
      {
        id: 'laughter_repeated_public',
        if: {
          encounterHasKeyword: ENCOUNTER_KEYWORDS.PUBLIC,
          alreadyPlayedThisEncounter: 'E-008',
        },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  // ── E-009 · Doubt ─────────────────────────────────────────────────────────

  {
    id: 'E-009',
    name: 'Doubt',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.UNCERTAIN,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [
      CATEGORIES.EMOTION,
      INTENT_TAGS.REVEAL,
      TONE_TAGS.UNCERTAIN,
      CARD_TAGS.CLARITY_GAIN,
    ],
    summaryText:
      '+1 clarity. Costs 1 trust unless paired with a protect reaction.',
    rulesText:
      'Gain 1 clarity. If the package does not include a protect reaction, lose 1 trust.',
    effects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
    synergyRules: [
      {
        id: 'doubt_protect_cancels_penalty',
        if: { primaryIntentTag: INTENT_TAGS.PROTECT },
        bonusEffects: [], // cancels the trust loss
      },
    ],
    riskRules: [
      {
        id: 'doubt_low_trust_escalates',
        if: { statLte: { stat: STATS.TRUST, value: 3 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.TENSION, amount: 1 }],
      },
    ],
  },

  // ══════════════════════════════════════════════════════════════════════════
  // MEMORY
  // ══════════════════════════════════════════════════════════════════════════

  // ── M-005 · Repeated Pattern ─────────────────────────────────────────────

  {
    id: 'M-005',
    name: 'Repeated Pattern',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.GUARDED,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [
      CATEGORIES.MEMORY,
      INTENT_TAGS.REVEAL,
      TONE_TAGS.GUARDED,
      CARD_TAGS.CLARITY_GAIN,
    ],
    summaryText:
      '+1 clarity and mark the encounter as defensive. A shift next turn grants momentum.',
    rulesText:
      'Gain 1 clarity and add the defensive keyword to the encounter. If the next turn you play a shift card, gain 1 momentum.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 1 },
      { type: 'add_keyword', keyword: ENCOUNTER_KEYWORDS.DEFENSIVE },
    ],
    synergyRules: [
      {
        id: 'repeated_pattern_shift_followup',
        if: { nextTurnCategory: CATEGORIES.SHIFT },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'repeated_pattern_high_tension',
        if: { statGte: { stat: STATS.TENSION, value: 8 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: -1 }],
      },
    ],
  },

  // ── M-007 · Hidden Cost ───────────────────────────────────────────────────

  {
    id: 'M-007',
    name: 'Hidden Cost',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.HEAVY,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [
      CATEGORIES.MEMORY,
      INTENT_TAGS.REVEAL,
      TONE_TAGS.HEAVY,
      CARD_TAGS.CLARITY_GAIN,
    ],
    summaryText:
      '+2 clarity but tension rises. A protect reaction cancels the tension cost.',
    rulesText:
      'Gain 2 clarity. Tension increases by 1. If the package includes a protect reaction, the tension increase is cancelled.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 2 },
      { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
    ],
    synergyRules: [
      {
        id: 'hidden_cost_protect_cancels_tension',
        if: { primaryIntentTag: INTENT_TAGS.PROTECT },
        bonusEffects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: -1 }, // cancel tension rise
        ],
      },
    ],
    riskRules: [
      {
        id: 'hidden_cost_low_trust',
        if: { statLte: { stat: STATS.TRUST, value: 3 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: -1 }],
      },
    ],
  },

  // ── M-008 · Shared Victory ────────────────────────────────────────────────

  {
    id: 'M-008',
    name: 'Shared Victory',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.CONNECT,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.REQUIRES_OPEN_WINDOW,
    tags: [
      CATEGORIES.MEMORY,
      INTENT_TAGS.CONNECT,
      TONE_TAGS.WARM,
      CARD_TAGS.TRUST_GAIN,
      CARD_TAGS.MOMENTUM_GAIN,
    ],
    summaryText:
      '+1 trust and +1 momentum. In net-positive runs, also gain clarity. Key for Breakthrough Moment.',
    rulesText:
      'Gain 1 trust and 1 momentum. If the run has net positive results (breakthroughs outweigh collapses), gain 1 clarity.',
    effects: [
      { type: 'modify_stat', stat: STATS.TRUST, amount: 1 },
      { type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 },
    ],
    conditionalEffects: [
      {
        if: { runNetPositive: true },
        then: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
    synergyRules: [
      {
        id: 'shared_victory_connect_emotion',
        if: { primaryIntentTag: INTENT_TAGS.CONNECT },
        bonusEffects: [{ type: 'open_response_window', windowId: RESPONSE_WINDOWS.BREAKTHROUGH }],
      },
    ],
    riskRules: [],
  },

  // ══════════════════════════════════════════════════════════════════════════
  // SHIFTS
  // ══════════════════════════════════════════════════════════════════════════

  // ── S-003 · Name the Pattern ─────────────────────────────────────────────

  {
    id: 'S-003',
    name: 'Name the Pattern',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.HEAVY,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [
      CATEGORIES.SHIFT,
      INTENT_TAGS.REVEAL,
      TONE_TAGS.HEAVY,
      CARD_TAGS.CLARITY_GAIN,
      CARD_TAGS.KEYWORD_REMOVE,
    ],
    summaryText:
      '+2 clarity and the encounter becomes fragile. At high trust, set breakthroughReady. Critical for Old Grudge.',
    rulesText:
      'Gain 2 clarity. Mark the encounter as fragile. If trust is 5 or higher, set breakthroughReady to true. Removes misread if present.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 2 },
      { type: 'add_keyword', keyword: ENCOUNTER_KEYWORDS.FRAGILE },
      { type: 'set_breakthrough_ready', value: true },
    ],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.TRUST, value: 5 } },
        then: [{ type: 'set_breakthrough_ready', value: true }],
      },
    ],
    synergyRules: [
      {
        id: 'name_pattern_remove_misread',
        if: { encounterHasKeyword: ENCOUNTER_KEYWORDS.MISREAD },
        bonusEffects: [{ type: 'remove_keyword', keyword: ENCOUNTER_KEYWORDS.MISREAD }],
      },
    ],
    riskRules: [
      {
        id: 'name_pattern_low_trust',
        if: { statLte: { stat: STATS.TRUST, value: 2 } },
        penaltyEffects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 2 },
          { type: 'close_response_window', windowId: RESPONSE_WINDOWS.RECOVER },
        ],
      },
    ],
  },

  // ── S-004 · Try Again Differently ────────────────────────────────────────

  {
    id: 'S-004',
    name: 'Try Again Differently',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.REQUIRES_OPEN_WINDOW,
    tags: [
      CATEGORIES.SHIFT,
      INTENT_TAGS.RECOVER,
      TONE_TAGS.WARM,
    ],
    summaryText:
      'Replay the last encounter reaction with one stat of your choice improved by 1. Only after a failed or weak turn.',
    rulesText:
      'Replay the previous encounter reaction with one stat of your choice increased by 1. This can only be triggered if the previous turn resulted in a failed or weak outcome (momentum negative, trust collapsed, or stalemate). Opens recover.',
    effects: [
      { type: 'open_response_window', windowId: RESPONSE_WINDOWS.RECOVER },
      { type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 },
    ],
    conditionalEffects: [
      {
        if: { lastTurnWasWeak: true },
        then: [{ type: 'replay_last_encounter_reaction', withStatBoost: 'player_choice' }],
      },
    ],
    synergyRules: [
      {
        id: 'try_again_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'try_again_not_weak',
        if: { lastTurnWasWeak: false },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  // ── S-005 · Fresh Start ───────────────────────────────────────────────────

  {
    id: 'S-005',
    name: 'Fresh Start',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.OPEN,
    riskTag: RISK_TAGS.REQUIRES_OPEN_WINDOW,
    tags: [
      CATEGORIES.SHIFT,
      INTENT_TAGS.RECOVER,
      TONE_TAGS.OPEN,
      CARD_TAGS.KEYWORD_REMOVE,
    ],
    summaryText:
      'Remove one negative keyword and open recover. Replaces player_choice.',
    rulesText:
      'Remove one of the following keywords from the encounter: misread, defensive, or stalled. Open the recover response window. Replaces the player_choice window for this turn.',
    effects: [
      {
        type: 'remove_keyword_one_of',
        keywords: [
          ENCOUNTER_KEYWORDS.MISREAD,
          ENCOUNTER_KEYWORDS.DEFENSIVE,
          ENCOUNTER_KEYWORDS.STALLED,
        ],
      },
      { type: 'open_response_window', windowId: RESPONSE_WINDOWS.RECOVER },
    ],
    synergyRules: [
      {
        id: 'fresh_start_emotion_recover',
        if: { primaryIntentTag: INTENT_TAGS.RECOVER },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
    riskRules: [],
  },

  // ── S-006 · Deep Breath ───────────────────────────────────────────────────

  {
    id: 'S-006',
    name: 'Deep Breath',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [
      CATEGORIES.SHIFT,
      INTENT_TAGS.STABILIZE,
      TONE_TAGS.WARM,
      CARD_TAGS.TENSION_DROP,
      CARD_TAGS.COLLAPSE_GUARD,
    ],
    summaryText:
      '-1 tension now and prevent tension increase on the next state refresh.',
    rulesText:
      'Reduce tension by 1. Add a modifier that prevents tension from increasing during the next state refresh. Opens stabilize.',
    effects: [
      { type: 'modify_stat', stat: STATS.TENSION, amount: -1 },
      { type: 'add_modifier', modifierId: 'no_tension_increase', duration: 'next_refresh' },
      { type: 'open_response_window', windowId: RESPONSE_WINDOWS.STABILIZE },
    ],
    synergyRules: [
      {
        id: 'deep_breath_memory_warm',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'deep_breath_high_tension',
        if: { statGte: { stat: STATS.TENSION, value: 8 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },
]

// ---------------------------------------------------------------------------
// Combined export for convenience (base + expansion, ready to merge)
// ---------------------------------------------------------------------------

export const COMBINED_CARD_DEFINITIONS = [
  ...(await import('../src/data.js')).CARD_DEFINITIONS,
  ...EXPANSION_CARD_DEFINITIONS,
]
