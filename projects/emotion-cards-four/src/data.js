export const PHASES = [
  'state_refresh',
  'draw_prepare',
  'read_situation',
  'play_response',
  'resolve_effects',
  'encounter_reaction',
  'check_outcome',
  'cleanup'
]

export const RESPONSE_WINDOWS = ['connect', 'stabilize', 'reveal', 'protect', 'pressure', 'reframe', 'recover', 'repair', 'boundary', 'breakthrough']

export const STARTER_DECK = ['E-001', 'E-005', 'E-003', 'M-001', 'M-004', 'M-006', 'R-001', 'R-003', 'R-002', 'R-007', 'S-001', 'S-002']

export const BREAKTHROUGH_SURFACES = {
  missed_signal: 'B-001',
  public_embarrassment: 'B-003',
  quiet_repair: 'B-002'
}

export const CARD_DEFINITIONS = [
  { id: 'E-001', name: 'Concern', category: 'emotion', deckRole: 'primary', intentTag: 'connect', toneTag: 'open', riskTag: 'weak_if_tension_high', tags: ['emotion', 'connect', 'open', 'trust_gain'], summaryText: '+1 trust. Better with memory support.', rulesText: 'Gain 1 trust. If paired with Memory, gain 1 clarity. In high tension, lose 1 momentum.', effects: [{ type: 'modify_stat', stat: 'trust', amount: 1 }], synergyRules: [{ id: 'concern_memory', if: { packageHasCategory: 'memory' }, bonusEffects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }] }], riskRules: [{ id: 'concern_high_tension', if: { statGte: { stat: 'tension', value: 8 } }, penaltyEffects: [{ type: 'modify_stat', stat: 'momentum', amount: -1 }] }] },
  { id: 'E-003', name: 'Shame', category: 'emotion', deckRole: 'primary', intentTag: 'reveal', toneTag: 'heavy', riskTag: 'escalates_if_trust_low', tags: ['emotion', 'reveal', 'heavy', 'clarity_gain'], summaryText: '+1 clarity, -1 momentum. Safer with support.', rulesText: 'Gain 1 clarity and lose 1 momentum. If paired with Quiet Support, gain 1 trust. At low trust, tension rises.', effects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }, { type: 'modify_stat', stat: 'momentum', amount: -1 }], synergyRules: [{ id: 'shame_support', if: { supportCardId: 'M-004' }, bonusEffects: [{ type: 'modify_stat', stat: 'trust', amount: 1 }] }], riskRules: [{ id: 'shame_low_trust', if: { statLte: { stat: 'trust', value: 3 } }, penaltyEffects: [{ type: 'modify_stat', stat: 'tension', amount: 1 }] }] },
  { id: 'E-005', name: 'Hope', category: 'emotion', deckRole: 'primary', intentTag: 'recover', toneTag: 'vulnerable', riskTag: 'fails_if_clarity_low', tags: ['emotion', 'recover', 'vulnerable', 'momentum_gain'], summaryText: '+1 momentum. At decent clarity, also gain trust.', rulesText: 'Gain 1 momentum. If clarity is 5+, gain 1 trust. If clarity is 2 or less, lose 1 trust.', effects: [{ type: 'modify_stat', stat: 'momentum', amount: 1 }], conditionalEffects: [{ if: { statGte: { stat: 'clarity', value: 5 } }, then: [{ type: 'modify_stat', stat: 'trust', amount: 1 }] }], riskRules: [{ id: 'hope_low_clarity', if: { statLte: { stat: 'clarity', value: 2 } }, penaltyEffects: [{ type: 'modify_stat', stat: 'trust', amount: -1 }] }] },
  { id: 'M-001', name: 'Old Promise', category: 'memory', deckRole: 'support', intentTag: 'connect', toneTag: 'warm', riskTag: 'fails_if_clarity_low', tags: ['memory', 'connect', 'warm', 'trust_gain'], summaryText: 'Supportive history. Builds trust if the moment is not hostile.', rulesText: 'If tension is 6 or lower, gain 1 trust. If paired with Concern or Hope, gain 1 clarity.', effects: [], conditionalEffects: [{ if: { statLte: { stat: 'tension', value: 6 } }, then: [{ type: 'modify_stat', stat: 'trust', amount: 1 }] }], synergyRules: [{ id: 'old_promise_connect_bonus', if: { primaryIntentTagIn: ['connect', 'recover'] }, bonusEffects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }] }] },
  { id: 'M-004', name: 'Quiet Support', category: 'memory', deckRole: 'support', intentTag: 'protect', toneTag: 'warm', riskTag: 'weak_if_tension_high', tags: ['memory', 'protect', 'warm', 'collapse_guard'], summaryText: 'Prevents the first trust loss this turn and helps vulnerable lines.', rulesText: 'Gain a one-turn trust guard. If paired with Shame or Doubt-like lines, gain 1 trust.', effects: [{ type: 'add_modifier', modifierId: 'trust_guard', duration: 'turn' }], synergyRules: [{ id: 'quiet_support_vulnerable_bonus', if: { primaryToneTagIn: ['heavy', 'uncertain', 'vulnerable'] }, bonusEffects: [{ type: 'modify_stat', stat: 'trust', amount: 1 }] }] },
  { id: 'M-006', name: 'Missed Signal', category: 'memory', deckRole: 'support', intentTag: 'reveal', toneTag: 'uncertain', riskTag: 'requires_open_window', tags: ['memory', 'reveal', 'misread_clear', 'repair'], summaryText: 'Clear a misread and open a safer line with Concern.', rulesText: 'Remove misread from encounter if present. If paired with Concern, open repair and gain 1 clarity.', effects: [{ type: 'remove_keyword', keyword: 'misread' }], synergyRules: [{ id: 'missed_signal_concern', if: { primaryCardId: 'E-001' }, bonusEffects: [{ type: 'open_response_window', windowId: 'repair' }, { type: 'modify_stat', stat: 'clarity', amount: 1 }] }] },
  { id: 'R-001', name: 'Guarded Honesty', category: 'reaction', deckRole: 'primary', intentTag: 'reveal', toneTag: 'guarded', riskTag: 'fails_if_clarity_low', tags: ['reaction', 'reveal', 'guarded', 'clarity_gain'], summaryText: '+1 clarity and -1 tension. Memory support opens repair.', rulesText: 'Gain 1 clarity and reduce tension by 1. If paired with Memory, open repair.', effects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }, { type: 'modify_stat', stat: 'tension', amount: -1 }], synergyRules: [{ id: 'guarded_honesty_memory', if: { packageHasCategory: 'memory' }, bonusEffects: [{ type: 'open_response_window', windowId: 'repair' }] }] },
  { id: 'R-002', name: 'Deflect', category: 'reaction', deckRole: 'primary', intentTag: 'protect', toneTag: 'defensive', riskTag: 'punished_if_repeated', tags: ['reaction', 'protect', 'defensive', 'reaction_skip'], summaryText: 'Prevent immediate pressure, but clarity slips next turn.', rulesText: 'Gain 1 reaction shield this turn. Add lingering deflection for next refresh.', effects: [{ type: 'add_modifier', modifierId: 'reaction_shield', duration: 'turn' }, { type: 'add_modifier', modifierId: 'deflected_last_turn', duration: 'encounter' }] },
  { id: 'R-003', name: 'De-escalate', category: 'reaction', deckRole: 'primary', intentTag: 'stabilize', toneTag: 'open', riskTag: 'weak_if_tension_high', tags: ['reaction', 'stabilize', 'open', 'tension_drop'], summaryText: 'Strong tension control in heated scenes.', rulesText: 'Reduce tension by 1, or by 2 if the encounter is heated or fragile. If momentum is negative, move it toward neutral.', effects: [{ type: 'modify_stat', stat: 'tension', amount: -1 }], conditionalEffects: [{ if: { encounterHasKeywordIn: ['heated', 'fragile'] }, then: [{ type: 'modify_stat', stat: 'tension', amount: -1 }] }, { if: { statLte: { stat: 'momentum', value: -1 } }, then: [{ type: 'modify_stat', stat: 'momentum', amount: 1 }] }] },
  { id: 'R-007', name: 'Reframe Gently', category: 'reaction', deckRole: 'primary', intentTag: 'reframe', toneTag: 'open', riskTag: 'fails_if_clarity_low', tags: ['reaction', 'reframe', 'open', 'misread_clear'], summaryText: 'Improve clarity and soften bad momentum.', rulesText: 'Gain 1 clarity. If momentum is negative, gain 1 momentum. In misread encounters, open connect.', effects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }], conditionalEffects: [{ if: { statLte: { stat: 'momentum', value: -1 } }, then: [{ type: 'modify_stat', stat: 'momentum', amount: 1 }] }, { if: { encounterHasKeyword: 'misread' }, then: [{ type: 'open_response_window', windowId: 'connect' }] }] },
  { id: 'S-001', name: 'Change of Lens', category: 'shift', deckRole: 'support', intentTag: 'reframe', toneTag: 'open', riskTag: 'requires_memory_support', tags: ['shift', 'reframe', 'keyword_remove', 'clarity_gain'], summaryText: 'Strip a misread/defensive penalty and sharpen clarity.', rulesText: 'Remove misread or defensive keyword. If paired with Memory, gain 1 clarity.', effects: [{ type: 'remove_keyword_one_of', keywords: ['misread', 'defensive'] }], synergyRules: [{ id: 'change_of_lens_memory', if: { packageHasCategory: 'memory' }, bonusEffects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }] }] },
  { id: 'S-002', name: 'Slow the Room', category: 'shift', deckRole: 'support', intentTag: 'stabilize', toneTag: 'guarded', riskTag: 'weak_if_tension_high', tags: ['shift', 'stabilize', 'guarded', 'collapse_guard'], summaryText: 'Freeze tension growth for a turn and reward calm follow-up.', rulesText: 'Lock tension from increasing during the next reaction step. Opens stabilize.', effects: [{ type: 'add_modifier', modifierId: 'no_tension_increase', duration: 'turn' }, { type: 'open_response_window', windowId: 'stabilize' }] },
  { id: 'B-001', name: 'Mutual Recognition', category: 'breakthrough', deckRole: 'breakthrough', intentTag: 'connect', toneTag: 'vulnerable', riskTag: 'requires_open_window', tags: ['breakthrough', 'connect', 'breakthrough_enable'], summaryText: 'Resolve as breakthrough when trust and clarity are high.', rulesText: 'If trust and clarity are both high and breakthrough is open, this seals the encounter.', effects: [{ type: 'upgrade_outcome', from: 'partial', to: 'breakthrough' }], unlockRules: [{ id: 'unlock_mutual_recognition', if: { breakthroughReady: true }, availability: 'surface' }] },
  { id: 'B-002', name: 'Stable Repair', category: 'breakthrough', deckRole: 'breakthrough', intentTag: 'recover', toneTag: 'warm', riskTag: 'fails_if_clarity_low', tags: ['breakthrough', 'recover', 'breakthrough_enable'], summaryText: 'Turn a calm partial into a breakthrough and carry trust forward.', rulesText: 'If tension is low and momentum is positive, promote partial to breakthrough and grant next-encounter trust.', effects: [{ type: 'upgrade_outcome', from: 'partial', to: 'breakthrough' }, { type: 'carry_forward', stat: 'trustModifier', amount: 1 }], unlockRules: [{ id: 'unlock_stable_repair', if: { breakthroughReady: true }, availability: 'surface' }] },
  { id: 'B-003', name: 'Hard Truth, Open Door', category: 'breakthrough', deckRole: 'breakthrough', intentTag: 'reveal', toneTag: 'assertive', riskTag: 'escalates_if_trust_low', tags: ['breakthrough', 'reveal', 'breakthrough_enable'], summaryText: 'Reward a high-clarity, high-risk honesty line.', rulesText: 'If clarity is high and trust did not collapse, convert the encounter to breakthrough.', effects: [{ type: 'upgrade_outcome', from: 'partial', to: 'breakthrough' }], unlockRules: [{ id: 'unlock_hard_truth', if: { breakthroughReady: true }, availability: 'surface' }] }
]

export const ENCOUNTER_TEMPLATES = [
  {
    id: 'missed_signal',
    name: 'Missed Signal',
    prompt: 'Someone important thinks they were ignored on purpose.',
    keywords: ['misread', 'repairable'],
    startingStats: { tension: 5, trust: 5, clarity: 2, momentum: 0 },
    startingWindows: ['connect', 'reveal'],
    visibleCues: ['The issue feels personal, but still repairable.'],
    breakthroughThresholds: { trust: 7, clarity: 6, momentum: 1 },
    reactionRules: [
      { id: 'ms_pressure_low_fit', priority: 90, if: { packageHasTag: 'pressure' }, effects: [{ type: 'modify_stat', stat: 'tension', amount: 2 }, { type: 'modify_stat', stat: 'momentum', amount: -1 }, { type: 'close_response_window', windowId: 'repair' }], cue: 'Pushing too hard confirms the hurt and narrows the repair line.' },
      { id: 'ms_connect_memory', priority: 60, if: { packageHasTag: 'connect', packageHasCategory: 'memory' }, effects: [{ type: 'modify_stat', stat: 'trust', amount: 1 }, { type: 'open_response_window', windowId: 'repair' }, { type: 'set_breakthrough_ready', value: true }], cue: 'The shared context lands. A real repair opening appears.' },
      { id: 'ms_reveal_careful', priority: 50, if: { packageHasTag: 'reveal' }, effects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }], cue: 'Careful honesty exposes what actually went wrong.' },
      { id: 'ms_default', priority: 10, if: {}, effects: [{ type: 'modify_stat', stat: 'momentum', amount: -1 }], cue: 'The exchange drifts without fully connecting.' }
    ]
  },
  {
    id: 'public_embarrassment',
    name: 'Public Embarrassment',
    prompt: 'A painful moment happened in front of other people, and everyone remembers it differently.',
    keywords: ['public', 'heated', 'fragile'],
    startingStats: { tension: 7, trust: 2, clarity: 5, momentum: -1 },
    startingWindows: ['stabilize', 'protect'],
    visibleCues: ['The room is hot. Safety matters more than winning the point.'],
    breakthroughThresholds: { trust: 6, clarity: 7, momentum: 1 },
    reactionRules: [
      { id: 'pe_pressure_backfire', priority: 90, if: { packageHasTag: 'pressure' }, effects: [{ type: 'modify_stat', stat: 'tension', amount: 2 }, { type: 'modify_stat', stat: 'trust', amount: -1 }], cue: 'Public pressure hardens everyone immediately.' },
      { id: 'pe_deflect_cost', priority: 70, if: { primaryCardId: 'R-002' }, effects: [{ type: 'modify_stat', stat: 'clarity', amount: -1 }, { type: 'close_response_window', windowId: 'reveal' }], cue: 'Deflection buys a moment, but the real issue blurs further.' },
      { id: 'pe_stabilize_reward', priority: 55, if: { packageHasTag: 'stabilize' }, effects: [{ type: 'modify_stat', stat: 'tension', amount: -1 }, { type: 'open_response_window', windowId: 'recover' }], cue: 'Slowing things down creates room for recovery.' },
      { id: 'pe_shame_memory_reward', priority: 50, if: { primaryCardId: 'E-003', packageHasCategory: 'memory' }, effects: [{ type: 'modify_stat', stat: 'trust', amount: 1 }, { type: 'set_breakthrough_ready', value: true }], cue: 'Owning the hurt in context makes the moment less performative.' },
      { id: 'pe_default', priority: 10, if: {}, effects: [{ type: 'modify_stat', stat: 'tension', amount: 1 }], cue: 'The room stays volatile.' }
    ]
  },
  {
    id: 'quiet_repair',
    name: 'Quiet Repair',
    prompt: 'After the damage, there is one private chance to see whether anything can still be rebuilt.',
    keywords: ['private', 'repairable', 'guarded'],
    startingStats: { tension: 4, trust: 4, clarity: 4, momentum: 0 },
    startingWindows: ['connect', 'recover', 'reframe'],
    visibleCues: ['This is quieter, but not automatically safe.'],
    breakthroughThresholds: { trust: 7, clarity: 6, momentum: 1 },
    reactionRules: [
      { id: 'qr_recover_reward', priority: 70, if: { packageHasTag: 'recover' }, effects: [{ type: 'modify_stat', stat: 'momentum', amount: 1 }, { type: 'open_response_window', windowId: 'breakthrough' }], cue: 'Steady repair creates a real path forward.' },
      { id: 'qr_reframe_reward', priority: 60, if: { packageHasTag: 'reframe' }, effects: [{ type: 'modify_stat', stat: 'clarity', amount: 1 }], cue: 'A new framing helps both sides see the pattern more clearly.' },
      { id: 'qr_guarded_punish_pressure', priority: 85, if: { packageHasTag: 'pressure' }, effects: [{ type: 'modify_stat', stat: 'trust', amount: -2 }, { type: 'modify_stat', stat: 'tension', amount: 1 }], cue: 'Forcing the issue in a guarded repair moment backfires.' },
      { id: 'qr_default', priority: 10, if: {}, effects: [{ type: 'modify_stat', stat: 'momentum', amount: -1 }], cue: 'The conversation stays cautious and slow.' }
    ]
  }
]
