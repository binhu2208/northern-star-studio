import {
  CATEGORIES,
  CATEGORY_LIST,
  INTENT_TAGS,
  TONE_TAGS,
  RISK_TAGS,
  DECK_ROLES,
  CARD_TAGS,
  RESPONSE_WINDOWS,
  ENCOUNTER_KEYWORDS,
  STATS,
  PHASES,
  PHASE_LIST,
  VOCAB,
} from './vocabulary.js'

// Re-export PHASES and RESPONSE_WINDOWS from vocabulary so existing imports
// (e.g. in engine.js) continue to work without changes.
export { PHASES, PHASE_LIST }
export { RESPONSE_WINDOWS }

/** Canonical list of card IDs in the starter deck. */
export const STARTER_DECK = ['E-001', 'E-005', 'E-003', 'M-001', 'M-004', 'M-006', 'R-001', 'R-003', 'R-002', 'R-007', 'S-001', 'S-002']

/**
 * @deprecated Breakthrough surfacing is now handled by BreakthroughManager
 * which evaluates unlock conditions dynamically per v1 flagship mode rules.
 * This map is only a fallback for encounters without per-card unlock rules
 * and will be removed once all encounters define proper unlock conditions.
 * @see BreakthroughManager in engine.js
 */
export const BREAKTHROUGH_SURFACES = {
  [ENCOUNTER_KEYWORDS.MISREAD]:     'B-001',  // Missed Signal
  [ENCOUNTER_KEYWORDS.PUBLIC]:      'B-003',  // Public Embarrassment
  [ENCOUNTER_KEYWORDS.PRIVATE]:     'B-002',  // Quiet Repair
}

// ---------------------------------------------------------------------------
// Card Definitions
// ---------------------------------------------------------------------------

export const CARD_DEFINITIONS = [
  // ── Emotions ──────────────────────────────────────────────────────────────

  {
    id: 'E-001',
    name: 'Concern',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.CONNECT,
    toneTag: TONE_TAGS.OPEN,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.CONNECT, TONE_TAGS.OPEN, CARD_TAGS.TRUST_GAIN],
    summaryText: '+1 trust. Better with memory support.',
    rulesText: 'Gain 1 trust. If paired with Memory, gain 1 clarity. In high tension, lose 1 momentum.',
    effects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
    synergyRules: [
      {
        id: 'concern_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'concern_high_tension',
        if: { statGte: { stat: STATS.TENSION, value: 8 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
      },
    ],
  },

  {
    id: 'E-003',
    name: 'Shame',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.HEAVY,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.REVEAL, TONE_TAGS.HEAVY, CARD_TAGS.CLARITY_GAIN],
    summaryText: '+1 clarity, -1 momentum. Safer with support.',
    rulesText: 'Gain 1 clarity and lose 1 momentum. If paired with Quiet Support, gain 1 trust. At low trust, tension rises.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 1 },
      { type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 },
    ],
    synergyRules: [
      {
        id: 'shame_support',
        if: { supportCardId: 'M-004' },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'shame_low_trust',
        if: { statLte: { stat: STATS.TRUST, value: 3 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.TENSION, amount: 1 }],
      },
    ],
  },

  {
    id: 'E-005',
    name: 'Hope',
    category: CATEGORIES.EMOTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.VULNERABLE,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [CATEGORIES.EMOTION, INTENT_TAGS.RECOVER, TONE_TAGS.VULNERABLE, CARD_TAGS.MOMENTUM_GAIN],
    summaryText: '+1 momentum. At decent clarity, also gain trust.',
    rulesText: 'Gain 1 momentum. If clarity is 5+, gain 1 trust. If clarity is 2 or less, lose 1 trust.',
    effects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
    conditionalEffects: [
      {
        if: { statGte: { stat: STATS.CLARITY, value: 5 } },
        then: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
    riskRules: [
      {
        id: 'hope_low_clarity',
        if: { statLte: { stat: STATS.CLARITY, value: 2 } },
        penaltyEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: -1 }],
      },
    ],
  },

  // ── Memory ────────────────────────────────────────────────────────────────

  {
    id: 'M-001',
    name: 'Old Promise',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.CONNECT,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [CATEGORIES.MEMORY, INTENT_TAGS.CONNECT, TONE_TAGS.WARM, CARD_TAGS.TRUST_GAIN],
    summaryText: 'Supportive history. Builds trust if the moment is not hostile.',
    rulesText: 'If tension is 6 or lower, gain 1 trust. If paired with Concern or Hope, gain 1 clarity.',
    effects: [],
    conditionalEffects: [
      {
        if: { statLte: { stat: STATS.TENSION, value: 6 } },
        then: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
    synergyRules: [
      {
        id: 'old_promise_connect_bonus',
        if: { primaryIntentTagIn: [INTENT_TAGS.CONNECT, INTENT_TAGS.RECOVER] },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
  },

  {
    id: 'M-004',
    name: 'Quiet Support',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [CATEGORIES.MEMORY, INTENT_TAGS.PROTECT, TONE_TAGS.WARM, CARD_TAGS.COLLAPSE_GUARD],
    summaryText: 'Prevents the first trust loss this turn and helps vulnerable lines.',
    rulesText: 'Gain a one-turn trust guard. If paired with Shame or Doubt-like lines, gain 1 trust.',
    effects: [{ type: 'add_modifier', modifierId: 'trust_guard', duration: 'turn' }],
    synergyRules: [
      {
        id: 'quiet_support_vulnerable_bonus',
        if: { primaryToneTagIn: [TONE_TAGS.HEAVY, TONE_TAGS.UNCERTAIN, TONE_TAGS.VULNERABLE] },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.TRUST, amount: 1 }],
      },
    ],
  },

  {
    id: 'M-006',
    name: 'Missed Signal',
    category: CATEGORIES.MEMORY,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.UNCERTAIN,
    riskTag: RISK_TAGS.REQUIRES_OPEN_WINDOW,
    tags: [CATEGORIES.MEMORY, INTENT_TAGS.REVEAL, CARD_TAGS.MISREAD_CLEAR, RESPONSE_WINDOWS.REPAIR],
    summaryText: 'Clear a misread and open a safer line with Concern.',
    rulesText: 'Remove misread from encounter if present. If paired with Concern, open repair and gain 1 clarity.',
    effects: [{ type: 'remove_keyword', keyword: ENCOUNTER_KEYWORDS.MISREAD }],
    synergyRules: [
      {
        id: 'missed_signal_concern',
        if: { primaryCardId: 'E-001' },
        bonusEffects: [
          { type: 'open_response_window', windowId: RESPONSE_WINDOWS.REPAIR },
          { type: 'modify_stat', stat: STATS.CLARITY, amount: 1 },
        ],
      },
    ],
  },

  // ── Reactions ───────────────────────────────────────────────────────────────

  {
    id: 'R-001',
    name: 'Guarded Honesty',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.GUARDED,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.REVEAL, TONE_TAGS.GUARDED, CARD_TAGS.CLARITY_GAIN],
    summaryText: '+1 clarity and -1 tension. Memory support opens repair.',
    rulesText: 'Gain 1 clarity and reduce tension by 1. If paired with Memory, open repair.',
    effects: [
      { type: 'modify_stat', stat: STATS.CLARITY, amount: 1 },
      { type: 'modify_stat', stat: STATS.TENSION, amount: -1 },
    ],
    synergyRules: [
      {
        id: 'guarded_honesty_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'open_response_window', windowId: RESPONSE_WINDOWS.REPAIR }],
      },
    ],
  },

  {
    id: 'R-002',
    name: 'Deflect',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.DEFENSIVE,
    riskTag: RISK_TAGS.PUNISHED_IF_REPEATED,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.PROTECT, TONE_TAGS.DEFENSIVE, CARD_TAGS.REACTION_SKIP],
    summaryText: 'Prevent immediate pressure, but clarity slips next turn.',
    rulesText: 'Gain 1 reaction shield this turn. Add lingering deflection for next refresh.',
    effects: [
      { type: 'add_modifier', modifierId: 'reaction_shield', duration: 'turn' },
      { type: 'add_modifier', modifierId: 'deflected_last_turn', duration: 'encounter' },
    ],
  },

  {
    id: 'R-003',
    name: 'De-escalate',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.OPEN,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.STABILIZE, TONE_TAGS.OPEN, CARD_TAGS.TENSION_DROP],
    summaryText: 'Strong tension control in heated scenes.',
    rulesText: 'Reduce tension by 1, or by 2 if the encounter is heated or fragile. If momentum is negative, move it toward neutral.',
    effects: [{ type: 'modify_stat', stat: STATS.TENSION, amount: -1 }],
    conditionalEffects: [
      {
        if: { encounterHasKeywordIn: [ENCOUNTER_KEYWORDS.HEATED, ENCOUNTER_KEYWORDS.FRAGILE] },
        then: [{ type: 'modify_stat', stat: STATS.TENSION, amount: -1 }],
      },
      {
        if: { statLte: { stat: STATS.MOMENTUM, value: -1 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
    ],
  },

  {
    id: 'R-005',
    name: 'Stand Ground',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.PROTECT,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: null,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.PROTECT, TONE_TAGS.ASSERTIVE, 'collapse_guard'],
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
    id: 'R-007',
    name: 'Reframe Gently',
    category: CATEGORIES.REACTION,
    deckRole: DECK_ROLES.PRIMARY,
    intentTag: INTENT_TAGS.REFRAME,
    toneTag: TONE_TAGS.OPEN,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [CATEGORIES.REACTION, INTENT_TAGS.REFRAME, TONE_TAGS.OPEN, CARD_TAGS.MISREAD_CLEAR],
    summaryText: 'Improve clarity and soften bad momentum.',
    rulesText: 'Gain 1 clarity. If momentum is negative, gain 1 momentum. In misread encounters, open connect.',
    effects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
    conditionalEffects: [
      {
        if: { statLte: { stat: STATS.MOMENTUM, value: -1 } },
        then: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 }],
      },
      {
        if: { encounterHasKeyword: ENCOUNTER_KEYWORDS.MISREAD },
        then: [{ type: 'open_response_window', windowId: RESPONSE_WINDOWS.CONNECT }],
      },
    ],
  },

  // ── Shifts ────────────────────────────────────────────────────────────────

  {
    id: 'S-001',
    name: 'Change of Lens',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.REFRAME,
    toneTag: TONE_TAGS.OPEN,
    riskTag: RISK_TAGS.REQUIRES_MEMORY_SUPPORT,
    tags: [CATEGORIES.SHIFT, INTENT_TAGS.REFRAME, CARD_TAGS.KEYWORD_REMOVE, CARD_TAGS.CLARITY_GAIN],
    summaryText: 'Strip a misread/defensive penalty and sharpen clarity.',
    rulesText: 'Remove misread or defensive keyword. If paired with Memory, gain 1 clarity.',
    effects: [{ type: 'remove_keyword_one_of', keywords: [ENCOUNTER_KEYWORDS.MISREAD, ENCOUNTER_KEYWORDS.DEFENSIVE] }],
    synergyRules: [
      {
        id: 'change_of_lens_memory',
        if: { packageHasCategory: CATEGORIES.MEMORY },
        bonusEffects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
      },
    ],
  },

  {
    id: 'S-002',
    name: 'Slow the Room',
    category: CATEGORIES.SHIFT,
    deckRole: DECK_ROLES.SUPPORT,
    intentTag: INTENT_TAGS.STABILIZE,
    toneTag: TONE_TAGS.GUARDED,
    riskTag: RISK_TAGS.WEAK_IF_TENSION_HIGH,
    tags: [CATEGORIES.SHIFT, INTENT_TAGS.STABILIZE, TONE_TAGS.GUARDED, CARD_TAGS.COLLAPSE_GUARD],
    summaryText: 'Freeze tension growth for a turn and reward calm follow-up.',
    rulesText: 'Lock tension from increasing during the next reaction step. Opens stabilize.',
    effects: [
      { type: 'add_modifier', modifierId: 'no_tension_increase', duration: 'turn' },
      { type: 'open_response_window', windowId: RESPONSE_WINDOWS.STABILIZE },
    ],
  },

  // ── Breakthroughs ─────────────────────────────────────────────────────────

  {
    id: 'B-001',
    name: 'Mutual Recognition',
    category: CATEGORIES.BREAKTHROUGH,
    deckRole: DECK_ROLES.BREAKTHROUGH,
    intentTag: INTENT_TAGS.CONNECT,
    toneTag: TONE_TAGS.VULNERABLE,
    riskTag: RISK_TAGS.REQUIRES_OPEN_WINDOW,
    tags: [CATEGORIES.BREAKTHROUGH, INTENT_TAGS.CONNECT, CARD_TAGS.BREAKTHROUGH_ENABLE],
    summaryText: 'Resolve as breakthrough when trust and clarity are high.',
    rulesText: 'If trust and clarity are both high and breakthrough is open, this seals the encounter.',
    effects: [{ type: 'upgrade_outcome', from: 'partial', to: 'breakthrough' }],
    unlockRules: [
      {
        id: 'unlock_mutual_recognition',
        if: { breakthroughReady: true },
        availability: 'surface',
      },
    ],
  },

  {
    id: 'B-002',
    name: 'Stable Repair',
    category: CATEGORIES.BREAKTHROUGH,
    deckRole: DECK_ROLES.BREAKTHROUGH,
    intentTag: INTENT_TAGS.RECOVER,
    toneTag: TONE_TAGS.WARM,
    riskTag: RISK_TAGS.FAILS_IF_CLARITY_LOW,
    tags: [CATEGORIES.BREAKTHROUGH, INTENT_TAGS.RECOVER, CARD_TAGS.BREAKTHROUGH_ENABLE],
    summaryText: 'Turn a calm partial into a breakthrough and carry trust forward.',
    rulesText: 'If tension is low and momentum is positive, promote partial to breakthrough and grant next-encounter trust.',
    effects: [
      { type: 'upgrade_outcome', from: 'partial', to: 'breakthrough' },
      { type: 'carry_forward', stat: 'trustModifier', amount: 1 },
    ],
    unlockRules: [
      {
        id: 'unlock_stable_repair',
        if: { breakthroughReady: true },
        availability: 'surface',
      },
    ],
  },

  {
    id: 'B-003',
    name: 'Hard Truth, Open Door',
    category: CATEGORIES.BREAKTHROUGH,
    deckRole: DECK_ROLES.BREAKTHROUGH,
    intentTag: INTENT_TAGS.REVEAL,
    toneTag: TONE_TAGS.ASSERTIVE,
    riskTag: RISK_TAGS.ESCALATES_IF_TRUST_LOW,
    tags: [CATEGORIES.BREAKTHROUGH, INTENT_TAGS.REVEAL, CARD_TAGS.BREAKTHROUGH_ENABLE],
    summaryText: 'Reward a high-clarity, high-risk honesty line.',
    rulesText: 'If clarity is high and trust did not collapse, convert the encounter to breakthrough.',
    effects: [{ type: 'upgrade_outcome', from: 'partial', to: 'breakthrough' }],
    unlockRules: [
      {
        id: 'unlock_hard_truth',
        if: { breakthroughReady: true },
        availability: 'surface',
      },
    ],
  },
]

// ---------------------------------------------------------------------------
// Encounter Templates
// ---------------------------------------------------------------------------

export const ENCOUNTER_TEMPLATES = [
  // ── 1. Missed Signal ──────────────────────────────────────────────────────

  {
    id: 'missed_signal',
    name: 'Missed Signal',
    prompt: 'Someone important thinks they were ignored on purpose.',
    keywords: [ENCOUNTER_KEYWORDS.MISREAD, ENCOUNTER_KEYWORDS.REPAIRABLE],
    startingStats: { tension: 5, trust: 5, clarity: 3, momentum: 0 },
    startingWindows: [RESPONSE_WINDOWS.CONNECT, RESPONSE_WINDOWS.REVEAL],
    visibleCues: ['The issue feels personal, but still repairable.'],
    breakthroughThresholds: { trust: 7, clarity: 6, momentum: 1 },
    reactionRules: [
      {
        id: 'ms_pressure_low_fit',
        priority: 90,
        if: { packageHasTag: INTENT_TAGS.PRESSURE },
        effects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 2 },
          { type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 },
          { type: 'close_response_window', windowId: RESPONSE_WINDOWS.REPAIR },
        ],
        cue: 'Pushing too hard confirms the hurt and narrows the repair line.',
      },
      {
        id: 'ms_connect_memory',
        priority: 60,
        if: { packageHasTag: INTENT_TAGS.CONNECT, packageHasCategory: CATEGORIES.MEMORY },
        effects: [
          { type: 'modify_stat', stat: STATS.TRUST, amount: 1 },
          { type: 'open_response_window', windowId: RESPONSE_WINDOWS.REPAIR },
          { type: 'set_breakthrough_ready', value: true },
        ],
        cue: 'The shared context lands. A real repair opening appears.',
      },
      {
        id: 'ms_reveal_careful',
        priority: 50,
        if: { packageHasTag: INTENT_TAGS.REVEAL },
        effects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
        cue: 'Careful honesty exposes what actually went wrong.',
      },
      {
        id: 'ms_default',
        priority: 10,
        if: {},
        effects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
        cue: 'The exchange drifts without fully connecting.',
      },
    ],
  },

  // ── 2. Public Embarrassment ────────────────────────────────────────────────

  {
    id: 'public_embarrassment',
    name: 'Public Embarrassment',
    prompt: 'A painful moment happened in front of other people, and everyone remembers it differently.',
    keywords: [ENCOUNTER_KEYWORDS.PUBLIC, ENCOUNTER_KEYWORDS.HEATED, ENCOUNTER_KEYWORDS.FRAGILE],
    startingStats: { tension: 7, trust: 2, clarity: 5, momentum: -1 },
    startingWindows: [RESPONSE_WINDOWS.STABILIZE, RESPONSE_WINDOWS.PROTECT],
    visibleCues: ['The room is hot. Safety matters more than winning the point.'],
    breakthroughThresholds: { trust: 6, clarity: 7, momentum: 1 },
    reactionRules: [
      {
        id: 'pe_pressure_backfire',
        priority: 90,
        if: { packageHasTag: INTENT_TAGS.PRESSURE },
        effects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: 2 },
          { type: 'modify_stat', stat: STATS.TRUST, amount: -1 },
        ],
        cue: 'Public pressure hardens everyone immediately.',
      },
      {
        id: 'pe_deflect_cost',
        priority: 70,
        if: { primaryCardId: 'R-002' },
        effects: [
          { type: 'modify_stat', stat: STATS.CLARITY, amount: -1 },
          { type: 'close_response_window', windowId: RESPONSE_WINDOWS.REVEAL },
        ],
        cue: 'Deflection buys a moment, but the real issue blurs further.',
      },
      {
        id: 'pe_stabilize_reward',
        priority: 55,
        if: { packageHasTag: INTENT_TAGS.STABILIZE },
        effects: [
          { type: 'modify_stat', stat: STATS.TENSION, amount: -1 },
          { type: 'open_response_window', windowId: RESPONSE_WINDOWS.RECOVER },
        ],
        cue: 'Slowing things down creates room for recovery.',
      },
      {
        id: 'pe_shame_memory_reward',
        priority: 50,
        if: { primaryCardId: 'E-003', packageHasCategory: CATEGORIES.MEMORY },
        effects: [
          { type: 'modify_stat', stat: STATS.TRUST, amount: 1 },
          { type: 'set_breakthrough_ready', value: true },
        ],
        cue: 'Owning the hurt in context makes the moment less performative.',
      },
      {
        id: 'pe_default',
        priority: 10,
        if: {},
        effects: [{ type: 'modify_stat', stat: STATS.TENSION, amount: 1 }],
        cue: 'The room stays volatile.',
      },
    ],
  },

  // ── 3. Quiet Repair ───────────────────────────────────────────────────────

  {
    id: 'quiet_repair',
    name: 'Quiet Repair',
    prompt: 'After the damage, there is one private chance to see whether anything can still be rebuilt.',
    keywords: [ENCOUNTER_KEYWORDS.PRIVATE, ENCOUNTER_KEYWORDS.REPAIRABLE, ENCOUNTER_KEYWORDS.GUARDED],
    startingStats: { tension: 4, trust: 4, clarity: 4, momentum: 0 },
    startingWindows: [RESPONSE_WINDOWS.CONNECT, RESPONSE_WINDOWS.RECOVER, RESPONSE_WINDOWS.REFRAME],
    visibleCues: ['This is quieter, but not automatically safe.'],
    breakthroughThresholds: { trust: 7, clarity: 6, momentum: 1 },
    reactionRules: [
      {
        id: 'qr_recover_reward',
        priority: 70,
        if: { packageHasTag: INTENT_TAGS.RECOVER },
        effects: [
          { type: 'modify_stat', stat: STATS.MOMENTUM, amount: 1 },
          { type: 'open_response_window', windowId: RESPONSE_WINDOWS.BREAKTHROUGH },
        ],
        cue: 'Steady repair creates a real path forward.',
      },
      {
        id: 'qr_reframe_reward',
        priority: 60,
        if: { packageHasTag: INTENT_TAGS.REFRAME },
        effects: [{ type: 'modify_stat', stat: STATS.CLARITY, amount: 1 }],
        cue: 'A new framing helps both sides see the pattern more clearly.',
      },
      {
        id: 'qr_guarded_punish_pressure',
        priority: 85,
        if: { packageHasTag: INTENT_TAGS.PRESSURE },
        effects: [
          { type: 'modify_stat', stat: STATS.TRUST, amount: -2 },
          { type: 'modify_stat', stat: STATS.TENSION, amount: 1 },
        ],
        cue: 'Forcing the issue in a guarded repair moment backfires.',
      },
      {
        id: 'qr_default',
        priority: 10,
        if: {},
        effects: [{ type: 'modify_stat', stat: STATS.MOMENTUM, amount: -1 }],
        cue: 'The conversation stays cautious and slow.',
      },
    ],
  },
]

// ---------------------------------------------------------------------------
// Vocabulary export (needed by validateVocabulary in engine.js)
// ---------------------------------------------------------------------------

export { VOCAB }
