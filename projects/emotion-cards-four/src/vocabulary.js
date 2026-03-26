/**
 * vocabulary.ts — Canonical constants for all tagged values in Emotion Cards Four (v1).
 *
 * All tags, intent tags, tone tags, risk tags, response window IDs,
 * encounter keywords, stat names, categories, deck roles, phases,
 * and modifiers are defined here as frozen constants.
 *
 * This file is the single source of truth. Any freeform string used
 * in card definitions, encounter templates, or engine logic should
 * be a reference to one of these constants — never a raw string.
 *
 * A startup validation pass (validateVocabulary) checks that all
 * CARD_DEFINITIONS and ENCOUNTER_TEMPLATES use only values from
 * this canonical vocabulary.
 */

// ---------------------------------------------------------------------------
// Categories
// ---------------------------------------------------------------------------

export const CATEGORIES = Object.freeze({
  EMOTION:   'emotion',
  MEMORY:    'memory',
  REACTION:  'reaction',
  SHIFT:     'shift',
  BREAKTHROUGH: 'breakthrough',
})

export const CATEGORY_LIST = Object.freeze(Object.values(CATEGORIES))

// ---------------------------------------------------------------------------
// Intent Tags
// ---------------------------------------------------------------------------

export const INTENT_TAGS = Object.freeze({
  CONNECT:    'connect',
  STABILIZE:  'stabilize',
  REVEAL:     'reveal',
  PROTECT:    'protect',
  PRESSURE:   'pressure',
  REFRAME:    'reframe',
  RECOVER:    'recover',
})

export const INTENT_TAG_LIST = Object.freeze(Object.values(INTENT_TAGS))

// ---------------------------------------------------------------------------
// Tone Tags
// ---------------------------------------------------------------------------

export const TONE_TAGS = Object.freeze({
  OPEN:       'open',
  GUARDED:    'guarded',
  VULNERABLE: 'vulnerable',
  ASSERTIVE:  'assertive',
  UNCERTAIN:  'uncertain',
  WARM:       'warm',
  DEFENSIVE:  'defensive',
  PLAYFUL:    'playful',
  HEAVY:      'heavy',
})

export const TONE_TAG_LIST = Object.freeze(Object.values(TONE_TAGS))

// ---------------------------------------------------------------------------
// Risk Tags
// ---------------------------------------------------------------------------

export const RISK_TAGS = Object.freeze({
  ESCALATES_IF_TRUST_LOW:    'escalates_if_trust_low',
  FAILS_IF_CLARITY_LOW:       'fails_if_clarity_low',
  WEAK_IF_TENSION_HIGH:       'weak_if_tension_high',
  PUNISHED_IF_REPEATED:       'punished_if_repeated',
  REQUIRES_MEMORY_SUPPORT:    'requires_memory_support',
  REQUIRES_OPEN_WINDOW:       'requires_open_window',
})

export const RISK_TAG_LIST = Object.freeze(Object.values(RISK_TAGS))

// ---------------------------------------------------------------------------
// Deck Roles
// ---------------------------------------------------------------------------

export const DECK_ROLES = Object.freeze({
  PRIMARY:     'primary',
  SUPPORT:      'support',
  BREAKTHROUGH: 'breakthrough',
})

export const DECK_ROLE_LIST = Object.freeze(Object.values(DECK_ROLES))

// ---------------------------------------------------------------------------
// Card Tags (effect qualifiers appearing in card `tags` arrays)
// ---------------------------------------------------------------------------

export const CARD_TAGS = Object.freeze({
  TRUST_GAIN:         'trust_gain',
  CLARITY_GAIN:       'clarity_gain',
  MOMENTUM_GAIN:      'momentum_gain',
  COLLAPSE_GUARD:     'collapse_guard',
  MISREAD_CLEAR:      'misread_clear',
  REACTION_SKIP:      'reaction_skip',
  TENSION_DROP:       'tension_drop',
  BREAKTHROUGH_ENABLE:'breakthrough_enable',
  KEYWORD_REMOVE:     'keyword_remove',
})

export const CARD_TAG_LIST = Object.freeze(Object.values(CARD_TAGS))

// ---------------------------------------------------------------------------
// Response Window IDs
// ---------------------------------------------------------------------------

export const RESPONSE_WINDOWS = Object.freeze({
  CONNECT:      'connect',
  STABILIZE:    'stabilize',
  REVEAL:       'reveal',
  PROTECT:      'protect',
  PRESSURE:     'pressure',
  REFRAME:      'reframe',
  RECOVER:      'recover',
  REPAIR:       'repair',
  BOUNDARY:     'boundary',
  BREAKTHROUGH: 'breakthrough',
})

export const RESPONSE_WINDOW_LIST = Object.freeze(Object.values(RESPONSE_WINDOWS))

// ---------------------------------------------------------------------------
// Encounter Keywords
// ---------------------------------------------------------------------------

export const ENCOUNTER_KEYWORDS = Object.freeze({
  MISREAD:     'misread',
  REPAIRABLE:  'repairable',
  PUBLIC:      'public',
  HEATED:      'heated',
  FRAGILE:     'fragile',
  PRIVATE:     'private',
  GUARDED:     'guarded',
  STALLED:     'stalled',
  DEFENSIVE:   'defensive',
  OPEN_WINDOW: 'open_window',
})

export const ENCOUNTER_KEYWORD_LIST = Object.freeze(Object.values(ENCOUNTER_KEYWORDS))

// ---------------------------------------------------------------------------
// Stat Names
// ---------------------------------------------------------------------------

export const STATS = Object.freeze({
  TENSION:  'tension',
  TRUST:    'trust',
  CLARITY:  'clarity',
  MOMENTUM: 'momentum',
})

export const STAT_LIST = Object.freeze(Object.values(STATS))

// ---------------------------------------------------------------------------
// Phase Names
// ---------------------------------------------------------------------------

export const PHASES = Object.freeze({
  STATE_REFRESH:      'state_refresh',
  DRAW_PREPARE:       'draw_prepare',
  READ_SITUATION:     'read_situation',
  PLAY_RESPONSE:      'play_response',
  RESOLVE_EFFECTS:    'resolve_effects',
  ENCOUNTER_REACTION: 'encounter_reaction',
  CHECK_OUTCOME:      'check_outcome',
  CLEANUP:            'cleanup',
})

export const PHASE_LIST = Object.freeze(Object.values(PHASES))

// ---------------------------------------------------------------------------
// Modifier IDs
// ---------------------------------------------------------------------------

export const MODIFIERS = Object.freeze({
  TRUST_GUARD:         'trust_guard',
  REACTION_SHIELD:     'reaction_shield',
  DEFLECTED_LAST_TURN: 'deflected_last_turn',
  NO_TENSION_INCREASE: 'no_tension_increase',
  COLLAPSE_GUARD:      'collapse_guard',
})

export const MODIFIER_LIST = Object.freeze(Object.values(MODIFIERS))

// ---------------------------------------------------------------------------
// Outcome Types
// ---------------------------------------------------------------------------

export const OUTCOMES = Object.freeze({
  BREAKTHROUGH: 'breakthrough',
  PARTIAL:      'partial',
  STALEMATE:    'stalemate',
  COLLAPSE:     'collapse',
})

export const OUTCOME_LIST = Object.freeze(Object.values(OUTCOMES))

// ---------------------------------------------------------------------------
// Run Status
// ---------------------------------------------------------------------------

export const RUN_STATUS = Object.freeze({
  ACTIVE:    'active',
  COMPLETED: 'completed',
})

// ---------------------------------------------------------------------------
// All valid values by namespace (used by validateVocabulary)
// ---------------------------------------------------------------------------

export const VOCAB = Object.freeze({
  categories:        CATEGORY_LIST,
  intentTags:         INTENT_TAG_LIST,
  toneTags:           TONE_TAG_LIST,
  riskTags:          RISK_TAG_LIST,
  deckRoles:         DECK_ROLE_LIST,
  cardTags:          CARD_TAG_LIST,
  responseWindows:   RESPONSE_WINDOW_LIST,
  encounterKeywords: ENCOUNTER_KEYWORD_LIST,
  stats:             STAT_LIST,
  phases:            PHASE_LIST,
  modifiers:         MODIFIER_LIST,
  outcomes:          OUTCOME_LIST,
})
