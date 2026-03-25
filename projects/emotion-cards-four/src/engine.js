/**
 * GameEngine — pure game logic, zero DOM dependencies.
 *
 * Responsibilities:
 * - Run / encounter / deck state management
 * - Turn state machine (phase transitions)
 * - Card package validation and resolution
 * - Opposition reaction evaluation
 * - Outcome classification (collapse / breakthrough / stalemate / partial)
 * - Carry-forward between encounters
 * - Deterministic shuffle
 * - Event logging
 * - Save / load via injected storage adapter
 *
 * The engine is data-in / data-out. All inputs come from the call site;
 * all outputs (including the updated run object) are returned, never
 * written to external state directly.
 */

import {
  CARD_DEFINITIONS,
  ENCOUNTER_TEMPLATES,
  RESPONSE_WINDOWS,
  STARTER_DECK,
} from './data.js'

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// Vocabulary validation
// ---------------------------------------------------------------------------
import {
  VOCAB,
  CATEGORIES,
  CATEGORY_LIST,
  DECK_ROLES,
  DECK_ROLE_LIST,
  CARD_TAGS,
  RESPONSE_WINDOWS,
  ENCOUNTER_KEYWORDS,
  PHASES,
  STATS,
  OUTCOME_RESULT,
  MODIFIER_IDS,
} from './vocabulary.js'

const EFFECT_TYPES = new Set([
  'modify_stat',
  'open_response_window',
  'close_response_window',
  'add_modifier',
  'remove_keyword',
  'remove_keyword_one_of',
  'set_breakthrough_ready',
  'upgrade_outcome',
  'carry_forward',
])

const CONDITION_KEYS = new Set([
  'packageHasCategory',
  'packageHasTag',
  'primaryCardId',
  'supportCardId',
  'primaryIntentTagIn',
  'primaryToneTagIn',
  'statGte',
  'statLte',
  'encounterHasKeyword',
  'encounterHasKeywordIn',
  'breakthroughReady',
  'runHasPositiveCarryForward',
  'runHasNegativeCarryForward',
])

function validateConditionBlock(path, condition, errors, ctx) {
  const addError = (severity, subPath, message) =>
    errors.push({ severity, path: `${path}.${subPath}`, message, cardId: ctx.cardId, encounterId: ctx.encounterId })
  if (!condition || typeof condition !== 'object') return
  for (const key of Object.keys(condition)) {
    if (!CONDITION_KEYS.has(key))
      addError('warning', key, `Unknown condition key "${key}"`)
  }
  if (condition.packageHasCategory && !CATEGORY_LIST.includes(condition.packageHasCategory))
    addError('error', 'packageHasCategory', `Invalid category "${condition.packageHasCategory}"`)
  if (condition.packageHasTag && !VOCAB.intentTags.includes(condition.packageHasTag))
    addError('error', 'packageHasTag', `Invalid intent tag "${condition.packageHasTag}"`)
  if (condition.primaryIntentTagIn) {
    for (let i = 0; i < condition.primaryIntentTagIn.length; i++) {
      if (!VOCAB.intentTags.includes(condition.primaryIntentTagIn[i]))
        addError('error', `primaryIntentTagIn[${i}]`, `Invalid intent tag "${condition.primaryIntentTagIn[i]}"`)
    }
  }
  if (condition.primaryToneTagIn) {
    for (let i = 0; i < condition.primaryToneTagIn.length; i++) {
      if (!VOCAB.toneTags.includes(condition.primaryToneTagIn[i]))
        addError('error', `primaryToneTagIn[${i}]`, `Invalid tone tag "${condition.primaryToneTagIn[i]}"`)
    }
  }
  if (condition.encounterHasKeyword && !ENCOUNTER_KEYWORDS.includes(condition.encounterHasKeyword))
    addError('error', 'encounterHasKeyword', `Invalid keyword "${condition.encounterHasKeyword}"`)
  if (condition.encounterHasKeywordIn) {
    for (let i = 0; i < condition.encounterHasKeywordIn.length; i++) {
      if (!ENCOUNTER_KEYWORDS.includes(condition.encounterHasKeywordIn[i]))
        addError('error', `encounterHasKeywordIn[${i}]`, `Invalid keyword "${condition.encounterHasKeywordIn[i]}"`)
    }
  }
}

export function validateVocabulary() {
  const errors = []
  const addError = (severity, path, message, cardId, encounterId) =>
    errors.push({ severity, path, message, cardId: cardId || undefined, encounterId: encounterId || undefined })

  // Validate cards
  for (const card of CARD_DEFINITIONS) {
    const ctx = { cardId: card.id }
    if (!CATEGORY_LIST.includes(card.category))
      addError('error', `${card.id}.category`, `Invalid category "${card.category}"`, card.id)
    if (!DECK_ROLE_LIST.includes(card.deckRole))
      addError('error', `${card.id}.deckRole`, `Invalid deckRole "${card.deckRole}"`, card.id)
    if (!VOCAB.intentTags.includes(card.intentTag))
      addError('error', `${card.id}.intentTag`, `Invalid intentTag "${card.intentTag}"`, card.id)
    if (card.toneTag && !VOCAB.toneTags.includes(card.toneTag))
      addError('error', `${card.id}.toneTag`, `Invalid toneTag "${card.toneTag}"`, card.id)
    if (card.riskTag && !VOCAB.riskTags.includes(card.riskTag))
      addError('warning', `${card.id}.riskTag`, `Invalid riskTag "${card.riskTag}"`, card.id)
    for (const tag of (card.tags || [])) {
      if (!VOCAB.cardTags.includes(tag))
        addError('warning', `${card.id}.tags`, `Unknown tag "${tag}"`, card.id)
    }
    for (const effect of (card.effects || [])) {
      if (!EFFECT_TYPES.has(effect.type))
        addError('warning', `${card.id}.effects`, `Unknown effect type "${effect.type}"`, card.id)
    }
    for (let ci = 0; ci < (card.conditionalEffects || []).length; ci++) {
      const block = card.conditionalEffects[ci]
      if (block.if) validateConditionBlock(`${card.id}.conditionalEffects[${ci}].if`, block.if, errors, ctx)
    }
    for (const rule of (card.synergyRules || [])) {
      if (rule.if) validateConditionBlock(`${card.id}.synergyRules.${rule.id}.if`, rule.if, errors, ctx)
    }
    for (const rule of (card.riskRules || [])) {
      if (rule.if) validateConditionBlock(`${card.id}.riskRules.${rule.id}.if`, rule.if, errors, ctx)
    }
    for (const rule of (card.unlockRules || [])) {
      if (rule.if) validateConditionBlock(`${card.id}.unlockRules.${rule.id}.if`, rule.if, errors, ctx)
    }
  }

  // Validate encounters
  for (const enc of ENCOUNTER_TEMPLATES) {
    const ctx = { encounterId: enc.id }
    for (const keyword of (enc.keywords || [])) {
      if (!ENCOUNTER_KEYWORDS.includes(keyword))
        addError('warning', `${enc.id}.keywords`, `Unknown keyword "${keyword}"`, null, enc.id)
    }
    for (const window of (enc.startingWindows || [])) {
      if (!RESPONSE_WINDOWS.includes(window))
        addError('error', `${enc.id}.startingWindows`, `Invalid window "${window}"`, null, enc.id)
    }
    for (const rule of (enc.reactionRules || [])) {
      if (rule.if) validateConditionBlock(`${enc.id}.reactionRules.${rule.id}.if`, rule.if, errors, ctx)
    }
  }

  return errors
}

const _vocabErrors = validateVocabulary()
if (_vocabErrors.length > 0) {
  console.error('[Vocabulary] Validation errors found:')
  for (const e of _vocabErrors) {
    console.error(`  [${e.severity}] ${e.path}: ${e.message}${e.cardId ? ` (card: ${e.cardId})` : ''}${e.encounterId ? ` (encounter: ${e.encounterId})` : ''}`)
  }
  throw new Error(`[Vocabulary] ${_vocabErrors.filter((e) => e.severity === 'error').length} error(s), ${_vocabErrors.filter((e) => e.severity === 'warning').length} warning(s) — fix before proceeding`)
}

// Constants
// ---------------------------------------------------------------------------

const MAX_HAND_SIZE = 4
const MAX_TURNS = 6

// ---------------------------------------------------------------------------
// Lookup maps (built once at module load — pure data, no side effects)
// ---------------------------------------------------------------------------

const cardMap = new Map(CARD_DEFINITIONS.map((card) => [card.id, card]))
const encounterMap = new Map(ENCOUNTER_TEMPLATES.map((enc) => [enc.id, enc]))
const breakthroughCardIds = CARD_DEFINITIONS.filter((c) => c.deckRole === 'breakthrough').map((c) => c.id)

// ---------------------------------------------------------------------------
// BreakthroughManager
// ---------------------------------------------------------------------------

/**
 * BreakthroughManager evaluates breakthrough unlock conditions against live
 * encounter state and surfaces breakthrough cards when conditions are met.
 *
 * Key rules (v1 flagship mode):
 * - Breakthrough cards surface when unlock conditions are met during encounter
 * - A surfaced breakthrough cannot be played until the NEXT turn after surfacing
 *   (not the same turn it was surfaced)
 * - Unlock conditions are evaluated dynamically against live encounter state,
 *   not via a static map
 */
export class BreakthroughManager {
  /**
   * Evaluate breakthrough unlock conditions for the given encounter and surface
   * a breakthrough card if conditions are met and no breakthrough is yet surfaced.
   *
   * @param {object} run
   * @param {object} encounter
   * @returns {{ surfaced: boolean, breakthroughId: string|null, reason: string }}
   */
  static evaluateAndSurface(run, encounter) {
    // Already surfaced — nothing to do
    if (encounter.surfacedBreakthroughId) {
      return { surfaced: false, breakthroughId: encounter.surfacedBreakthroughId, reason: 'already_surfaced' }
    }

    // breakthroughReady must be true before any breakthrough can surface
    if (!encounter.breakthroughReady) {
      return { surfaced: false, breakthroughId: null, reason: 'breakthrough_not_ready' }
    }

    // Evaluate each breakthrough card's unlock rules against live encounter state
    for (const breakthroughId of breakthroughCardIds) {
      const unlocked = this._evaluateUnlockRules(breakthroughId, run, encounter)
      if (unlocked) {
        encounter.surfacedBreakthroughId = breakthroughId
        encounter.breakthroughSurfaceTurn = encounter.turn
        encounter.breakthroughPlayable = false // Cannot be played until next turn

        // Open the breakthrough response window so the card can be played next turn
        setWindowOpen(encounter, 'breakthrough', true)

        // Register in carry-forward so the card is recognized as unlocked globally
        if (!run.carryForward.unlockedBreakthroughCards.includes(breakthroughId)) {
          run.carryForward.unlockedBreakthroughCards.push(breakthroughId)
        }

        logEvent(run, 'breakthrough_unlocked', {
          encounterId: encounter.encounterId,
          turn: encounter.turn,
          breakthroughId,
        })

        return { surfaced: true, breakthroughId, reason: 'conditions_met' }
      }
    }

    // breakthroughReady is true but no unlock rules matched — surface the default
    // based on encounter id as a fallback (maintains backward compat for encounters
    // without per-card unlock rules)
    const defaultId = _breakthroughDefaults[encounter.encounterId] ?? null
    if (defaultId && !encounter.surfacedBreakthroughId) {
      encounter.surfacedBreakthroughId = defaultId
      encounter.breakthroughSurfaceTurn = encounter.turn
      encounter.breakthroughPlayable = false
      setWindowOpen(encounter, 'breakthrough', true)
      if (!run.carryForward.unlockedBreakthroughCards.includes(defaultId)) {
        run.carryForward.unlockedBreakthroughCards.push(defaultId)
      }
      logEvent(run, 'breakthrough_unlocked', {
        encounterId: encounter.encounterId,
        turn: encounter.turn,
        breakthroughId: defaultId,
        fallback: true,
      })
      return { surfaced: true, breakthroughId: defaultId, reason: 'default_fallback' }
    }

    return { surfaced: false, breakthroughId: null, reason: 'no_conditions_met' }
  }

  /**
   * Check if a specific breakthrough card instance can be played.
   * Enforces: card must be surfaced, and it must be played on a turn AFTER
   * the turn it was surfaced (next turn rule per v1 flagship mode rules).
   *
   * @param {object} encounter
   * @param {string} breakthroughId
   * @returns {{ canPlay: boolean, reason: string }}
   */
  static canPlayBreakthrough(encounter, breakthroughId) {
    if (!encounter.surfacedBreakthroughId) {
      return { canPlay: false, reason: 'no_breakthrough_surfaced' }
    }
    if (encounter.surfacedBreakthroughId !== breakthroughId) {
      return { canPlay: false, reason: 'breakthrough_not_surfaced' }
    }
    // Next-turn rule: breakthrough can only be played on a turn AFTER the surface turn
    if (encounter.turn <= encounter.breakthroughSurfaceTurn) {
      return { canPlay: false, reason: 'breakthrough_not_yet_playable' }
    }
    return { canPlay: true, reason: 'ok' }
  }

  /**
   * Called at the start of each new turn to update breakthrough playability.
   * Once a surfaced breakthrough exists, it becomes playable from the turn
   * AFTER it was surfaced.
   *
   * @param {object} encounter
   */
  static advanceBreakthroughPlayability(encounter) {
    if (!encounter.surfacedBreakthroughId) return
    if (encounter.turn > encounter.breakthroughSurfaceTurn) {
      encounter.breakthroughPlayable = true
    }
  }

  /**
   * Evaluate a breakthrough card's unlock rules against live encounter state.
   * Returns true if all conditions in at least one unlock rule are satisfied.
   *
   * @param {string} breakthroughId
   * @param {object} run
   * @param {object} encounter
   * @returns {boolean}
   */
  static _evaluateUnlockRules(breakthroughId, run, encounter) {
    const def = cardMap.get(breakthroughId)
    if (!def || def.deckRole !== 'breakthrough') return false

    const rules = def.unlockRules ?? []
    if (rules.length === 0) return false

    // Each rule's `if` conditions must all match (AND), and we need at least
    // one rule to pass (OR between rules)
    for (const rule of rules) {
      if (matchesUnlockCondition(encounter, run, rule.if)) {
        return true
      }
    }
    return false
  }
}

/**
 * Match a single set of unlock conditions against encounter/run state.
 * Extends the standard condition matching with breakthrough-specific fields.
 */
function matchesUnlockCondition(encounter, run, condition = {}) {
  if (!condition || Object.keys(condition).length === 0) return true

  // breakthroughReady must be true
  if ('breakthroughReady' in condition) {
    if (encounter.breakthroughReady !== condition.breakthroughReady) return false
  }

  // Stat threshold: statGte { stat, value }
  if (condition.statGte) {
    const { stat, value } = condition.statGte
    if (encounter.stats[stat] < value) return false
  }

  // Stat threshold: statLte { stat, value }
  if (condition.statLte) {
    const { stat, value } = condition.statLte
    if (encounter.stats[stat] > value) return false
  }

  // Stat threshold: statEq { stat, value }
  if (condition.statEq) {
    const { stat, value } = condition.statEq
    if (encounter.stats[stat] !== value) return false
  }

  // Encounter has a specific keyword
  if (condition.encounterHasKeyword) {
    if (!encounter.keywords.includes(condition.encounterHasKeyword)) return false
  }

  // Encounter has any of a list of keywords
  if (condition.encounterHasKeywordIn) {
    if (!condition.encounterHasKeywordIn.some((k) => encounter.keywords.includes(k))) return false
  }

  // Encounter id matches (useful for encounter-specific breakthrough assignment)
  if (condition.encounterId) {
    if (encounter.encounterId !== condition.encounterId) return false
  }

  // Encounter result must be a specific value (for post-resolution upgrades)
  if (condition.result) {
    if (encounter.result !== condition.result) return false
  }

  return true
}

/**
 * Fallback defaults for breakthrough surfacing — used only when no unlock rules
 * match. This preserves backward compatibility during transition.
 * @deprecated — remove once all encounters have per-card unlock rules
 */
const _breakthroughDefaults = {
  missed_signal: 'B-001',
  public_embarrassment: 'B-003',
  quiet_repair: 'B-002',
}

// ---------------------------------------------------------------------------
// GameEngine class
// ---------------------------------------------------------------------------

export class GameEngine {
  /**
   * @param {object} options
   * @param {object} options.storageAdapter  - must provide getItem(key) and setItem(key, value)
   * @param {string} options.saveKey          - localStorage key for autosave
   */
  constructor({ storageAdapter, saveKey = 'emotion-cards-four-prototype-save-v1' } = {}) {
    this._storage = storageAdapter ?? {
      getItem: (k) => (typeof localStorage !== 'undefined' ? localStorage.getItem(k) : null),
      setItem: (k, v) => { if (typeof localStorage !== 'undefined') localStorage.setItem(k, v) },
    }
    this._saveKey = saveKey
    this._currentRun = null
    this._selection = { primary: null, support: null }

    // Optional listeners for UI sync (purely informational, engine doesn't render)
    this._listeners = []
  }

  // -------------------------------------------------------------------------
  // Public: run lifecycle
  // -------------------------------------------------------------------------

  /** Create a new deterministic run and return the run object. */
  createRun() {
    const encounterIds = ENCOUNTER_TEMPLATES.map((enc) => enc.id)
    const drawPile = shuffleDeterministic(STARTER_DECK.map(createCardInstance), 17)
    const run = {
      schemaVersion: 1,
      runId: `run-${Date.now()}`,
      seed: 17,
      status: 'active',
      encounterIndex: 0,
      encounterOrder: encounterIds,
      resultHistory: [],
      metrics: { turnsTaken: 0, poorFitPlays: 0, saveWrites: 0, resumes: 0 },
      deckState: {
        drawPile,
        hand: [],
        discardPile: [],
        maxHandSize: MAX_HAND_SIZE,
      },
      carryForward: {
        trustModifier: 0,
        tensionModifier: 0,
        clarityModifier: 0,
        momentumModifier: 0,
        blockedResponseTags: [],
        unlockedBreakthroughCards: [],
        rewardChoicesRemaining: 0,
      },
      eventLog: [],
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    }
    run.currentEncounter = createEncounterInstance(encounterIds[0], run.carryForward)
    logEvent(run, 'run_started', { encounterId: run.currentEncounter.encounterId })
    logEvent(run, 'encounter_started', { encounterId: run.currentEncounter.encounterId, prompt: run.currentEncounter.prompt })
    enterPhase(run, 'state_refresh')
    this._currentRun = run
    this._emit('run_created', run)
    return run
  }

  /** Return the current run object or null. */
  getRun() {
    return this._currentRun
  }

  /** Load a saved run from storage and return it (or null). */
  loadRun() {
    const raw = this._storage.getItem(this._saveKey)
    if (!raw) return null
    try {
      const run = JSON.parse(raw)
      run.metrics.resumes = (run.metrics.resumes || 0) + 1
      logEvent(run, 'save_loaded', { runId: run.runId })
      this._currentRun = run
      this._emit('run_loaded', run)
      return run
    } catch {
      return null
    }
  }

  /** Force-write the current run to storage. */
  saveRun(reason = 'manual') {
    const run = this._currentRun
    if (!run) return
    run.updatedAt = new Date().toISOString()
    run.metrics.saveWrites += 1
    this._storage.setItem(this._saveKey, JSON.stringify(run))
    logEvent(run, 'save_written', { reason, encounterId: run.currentEncounter?.encounterId, turn: run.currentEncounter?.turn })
    this._emit('saved', run)
  }

  /** Delete any saved run from storage. */
  clearSave() {
    this._storage.setItem(this._saveKey, null)
  }

  // -------------------------------------------------------------------------
  // Public: selection (card picks)
  // -------------------------------------------------------------------------

  /** Toggle selection of a card (primary or support). Returns the new selection. */
  toggleSelection(instanceId) {
    const run = this._currentRun
    if (!run) return this._selection
    const card = run.deckState.hand.find((entry) => entry.instanceId === instanceId)
    if (!card) return this._selection
    const def = getDefinition(card)
    if (def.deckRole === 'breakthrough') return this._selection
    if (def.deckRole === 'primary') {
      this._selection.primary = this._selection.primary === instanceId ? null : instanceId
    } else if (def.deckRole === 'support') {
      this._selection.support = this._selection.support === instanceId ? null : instanceId
    }
    this._emit('selection_changed', { selection: { ...this._selection } })
    return this._selection
  }

  /** Return the current selection state. */
  getSelection() {
    return { ...this._selection }
  }

  // -------------------------------------------------------------------------
  // Public: turn actions
  // -------------------------------------------------------------------------

  /**
   * Advance phase manually (used for read_situation → play_response transition).
   * Returns { ok, feedback }
   */
  advancePhase() {
    const run = this._currentRun
    if (!run || run.status !== 'active') return { ok: false, feedback: null }
    const encounter = getCurrentEncounter(run)
    const phase = encounter.phase
    if (phase === 'read_situation') {
      enterPhase(run, 'play_response')
      this._emit('phase_changed', { phase: 'play_response', encounter })
      return { ok: true, feedback: null }
    }
    if (phase === 'play_response') {
      return { ok: false, feedback: 'Choose a legal primary card before playing, or advance only after submitting a response.' }
    }
    return { ok: false, feedback: null }
  }

  /**
   * Submit the current card selection.
   * Returns { ok, feedback } where feedback is an error message if ok is false.
   */
  submitPlay() {
    const run = this._currentRun
    if (!run || run.status !== 'active') return { ok: false, feedback: 'No active run.' }
    const encounter = getCurrentEncounter(run)
    if (encounter.phase === 'read_situation') {
      enterPhase(run, 'play_response')
    } else if (encounter.phase !== 'play_response') {
      return { ok: false, feedback: 'You can only play cards during the play response phase.' }
    }

    const primary = run.deckState.hand.find((card) => card.instanceId === this._selection.primary)
    const support = run.deckState.hand.find((card) => card.instanceId === this._selection.support)
    const validation = validatePlay(run, primary, support)
    if (!validation.ok) {
      logEvent(run, 'play_validation_failed', { encounterId: encounter.encounterId, turn: encounter.turn, reason: validation.reason })
      return { ok: false, feedback: validation.reason }
    }

    const packageContext = buildPackageContext(primary, support)
    encounter.lastPlayerAction = resolvePlayerEffects(run, encounter, packageContext)
    enterPhase(run, 'resolve_effects')
    resolveOpposition(run, encounter, packageContext)
    evaluateOutcome(run, encounter)
    cleanupTurn(run, encounter, primary, support)
    this._selection = { primary: null, support: null }
    this._emit('play_resolved', { run, encounter })
    return { ok: true, feedback: null }
  }

  // -------------------------------------------------------------------------
  // Public: exported helpers (read-only queries)
  // -------------------------------------------------------------------------

  /** Return the full card definition for a card instance or definition id. */
  getDefinition(cardOrId) {
    return getDefinition(cardOrId)
  }

  /** Return phase instruction text for the current encounter phase. */
  getPhaseInstruction(encounter) {
    return getPhaseInstruction(encounter)
  }

  /** Return health/readability label for the current encounter. */
  getRunHealthLabel(encounter) {
    return getRunHealthLabel(encounter)
  }

  // -------------------------------------------------------------------------
  // Internal: event emitter (for UI renderer)
  // -------------------------------------------------------------------------

  on(event, listener) {
    this._listeners.push({ event, listener })
  }

  off(event, listener) {
    this._listeners = this._listeners.filter(
      (l) => !(l.event === event && l.listener === listener)
    )
  }

  _emit(event, data) {
    for (const { event: e, listener } of this._listeners) {
      if (e === event) listener(data)
    }
  }
}

// ---------------------------------------------------------------------------
// Factory helpers
// ---------------------------------------------------------------------------

function createEncounterInstance(encounterId, carryForward) {
  const template = encounterMap.get(encounterId)
  const stats = { ...template.startingStats }
  stats.trust = clamp(stats.trust + carryForward.trustModifier, 0, 10)
  stats.tension = clamp(stats.tension + carryForward.tensionModifier, 0, 10)
  stats.clarity = clamp(stats.clarity + carryForward.clarityModifier, 0, 10)
  stats.momentum = clamp(stats.momentum + carryForward.momentumModifier, -5, 5)
  return {
    encounterId: template.id,
    templateId: template.id,
    name: template.name,
    prompt: template.prompt,
    turn: 1,
    phase: 'state_refresh',
    status: 'active',
    result: null,
    keywords: [...template.keywords],
    stats,
    responseWindows: RESPONSE_WINDOWS.map((windowId) => ({
      windowId,
      open: template.startingWindows.includes(windowId) && !carryForward.blockedResponseTags.includes(windowId),
    })),
    visibleCues: [...template.visibleCues],
    activeModifiers: [],
    pressureLevel: 0,
    failedPlayCount: 0,
    breakthroughReady: false,
    breakthroughPlayable: false,
    collapseArmed: false,
    lastPlayerAction: null,
    lastOppositionAction: null,
    surfacedBreakthroughId: null,
    breakthroughSurfaceTurn: null,
  }
}

function createCardInstance(definitionId) {
  return { instanceId: `${definitionId}-${Math.random().toString(36).slice(2, 8)}`, definitionId }
}

// ---------------------------------------------------------------------------
// Shuffle (deterministic, seeded)
// ---------------------------------------------------------------------------

function shuffleDeterministic(items, seed) {
  const array = [...items]
  let value = seed
  for (let i = array.length - 1; i > 0; i -= 1) {
    value = (value * 9301 + 49297) % 233280
    const j = value % (i + 1)
    ;[array[i], array[j]] = [array[j], array[i]]
  }
  return array
}

// ---------------------------------------------------------------------------
// State getters
// ---------------------------------------------------------------------------

function getDefinition(cardOrId) {
  const id = typeof cardOrId === 'string' ? cardOrId : cardOrId.definitionId
  return cardMap.get(id)
}

function getCurrentEncounter(run = null) {
  // Will be called with engine's _currentRun via closure — accept null for safety
  return run?.currentEncounter ?? null
}

// ---------------------------------------------------------------------------
// Phase machine
// ---------------------------------------------------------------------------

function enterPhase(run, phase) {
  const encounter = getCurrentEncounter(run)
  if (!encounter || encounter.status !== 'active') return
  encounter.phase = phase
  logEvent(run, 'phase_entered', { encounterId: encounter.encounterId, turn: encounter.turn, phase })
  if (phase === 'state_refresh') handleStateRefresh(run)
  if (phase === 'draw_prepare') handleDrawPrepare(run)
}

function handleStateRefresh(run) {
  const encounter = getCurrentEncounter(run)
  const turn = encounter.turn

  // Advance breakthrough playability if a breakthrough is surfaced
  BreakthroughManager.advanceBreakthroughPlayability(encounter)

  if (turn >= 4 && !hasModifier(encounter, 'no_tension_increase')) {
    applyStatDelta(encounter, 'tension', 1)
    encounter.pressureLevel += 1
  }
  if (hasModifier(encounter, 'deflected_last_turn')) {
    applyStatDelta(encounter, 'clarity', -1)
    removeModifier(encounter, 'deflected_last_turn')
  }
  updateEncounterFlags(encounter)
  autosaveEngine(run)
  enterPhase(run, 'draw_prepare')
}

function handleDrawPrepare(run) {
  const encounter = getCurrentEncounter(run)
  drawToHand(run, run.deckState.maxHandSize)

  // Inject surfaced breakthrough into hand if not already present
  injectSurfacedBreakthrough(run)

  logEvent(run, 'cards_drawn', { encounterId: encounter.encounterId, turn: encounter.turn, hand: run.deckState.hand.map((card) => card.definitionId) })
  enterPhase(run, 'read_situation')
}

function injectSurfacedBreakthrough(run) {
  const encounter = getCurrentEncounter(run)
  if (!encounter.surfacedBreakthroughId) return
  const alreadyInHand = run.deckState.hand.some(
    (c) => c.definitionId === encounter.surfacedBreakthroughId
  )
  if (alreadyInHand) return
  const breakthroughInstance = createCardInstance(encounter.surfacedBreakthroughId)
  run.deckState.hand.push(breakthroughInstance)
  logEvent(run, 'breakthrough_card_added_to_hand', {
    encounterId: encounter.encounterId,
    turn: encounter.turn,
    breakthroughId: encounter.surfacedBreakthroughId,
    instanceId: breakthroughInstance.instanceId,
  })
}

function drawToHand(run, targetHandSize) {
  const deckState = run.deckState
  while (deckState.hand.length < targetHandSize) {
    if (deckState.drawPile.length === 0) {
      if (deckState.discardPile.length === 0) break
      deckState.drawPile = shuffleDeterministic(deckState.discardPile.splice(0), run.seed + run.metrics.turnsTaken)
    }
    const next = deckState.drawPile.shift()
    if (!next) break
    // Skip breakthrough cards — they surface via BreakthroughManager, not draw
    const def = getDefinition(next)
    if (def.deckRole === 'breakthrough') {
      run.deckState.discardPile.push(next)
      continue
    }
    deckState.hand.push(next)
  }
}

// ---------------------------------------------------------------------------
// Play validation and resolution
// ---------------------------------------------------------------------------

function validatePlay(run, primary, support) {
  const encounter = getCurrentEncounter(run)
  if (!primary) return { ok: false, reason: 'A primary Emotion or Reaction card is required.' }
  const primaryDef = getDefinition(primary)

  // Breakthrough cards cannot be played as primary
  if (primaryDef.deckRole === 'breakthrough') {
    return { ok: false, reason: 'Breakthrough cards cannot be played as primary cards.' }
  }

  if (!['emotion', 'reaction'].includes(primaryDef.category)) return { ok: false, reason: 'Primary card must be an Emotion or Reaction card.' }
  if (support) {
    const supportDef = getDefinition(support)
    if (supportDef.deckRole === 'breakthrough') {
      return { ok: false, reason: 'Breakthrough cards cannot be used as support.' }
    }
    if (!['memory', 'shift'].includes(supportDef.category)) return { ok: false, reason: 'Support card must be a Memory or Shift card.' }
  }
  const openWindows = encounter.responseWindows.filter((entry) => entry.open).map((entry) => entry.windowId)

  // Breakthrough card play — validate via BreakthroughManager
  if (primaryDef.deckRole === 'breakthrough') {
    const btCheck = BreakthroughManager.canPlayBreakthrough(encounter, primaryDef.id)
    if (!btCheck.canPlay) {
      encounter.failedPlayCount += 1
      run.metrics.poorFitPlays += 1
      return { ok: false, reason: `Breakthrough card cannot be played yet: ${btCheck.reason}.` }
    }
  } else if (!openWindows.includes(primaryDef.intentTag) && !openWindows.includes('repair') && primaryDef.intentTag !== 'protect') {
    encounter.failedPlayCount += 1
    run.metrics.poorFitPlays += 1
    return { ok: false, reason: `${primaryDef.name} does not fit the current open response windows.` }
  }
  return { ok: true }
}

function buildPackageContext(primary, support) {
  const cards = [primary, support].filter(Boolean)
  const defs = cards.map(getDefinition)
  return {
    cards,
    defs,
    primary,
    support,
    primaryDef: defs[0],
    supportDef: defs[1] ?? null,
    tags: [...new Set(defs.flatMap((def) => [def.intentTag, def.toneTag, def.riskTag, ...def.tags, def.category]))],
    categories: defs.map((def) => def.category),
  }
}

function resolvePlayerEffects(run, encounter, packageContext) {
  const preState = snapshotEncounter(encounter)
  const explanation = []
  const triggeredSynergyRuleIds = []
  const triggeredRiskRuleIds = []

  for (const def of packageContext.defs) {
    applyEffects(encounter, def.effects || [], explanation)
  }
  for (const def of packageContext.defs) {
    for (const block of def.conditionalEffects || []) {
      if (matchesCondition(encounter, packageContext, block.if)) {
        applyEffects(encounter, block.then, explanation)
      }
    }
  }
  for (const def of packageContext.defs) {
    for (const rule of def.synergyRules || []) {
      if (matchesCondition(encounter, packageContext, rule.if)) {
        triggeredSynergyRuleIds.push(rule.id)
        applyEffects(encounter, rule.bonusEffects, explanation)
      }
    }
  }
  for (const def of packageContext.defs) {
    for (const rule of def.riskRules || []) {
      if (matchesCondition(encounter, packageContext, rule.if)) {
        triggeredRiskRuleIds.push(rule.id)
        applyEffects(encounter, rule.penaltyEffects, explanation)
        encounter.failedPlayCount += 1
        run.metrics.poorFitPlays += 1
      }
    }
  }

  updateEncounterFlags(encounter)
  const resolved = {
    primaryCardId: packageContext.primaryDef.id,
    supportCardId: packageContext.supportDef?.id,
    appliedEffectIds: explanation,
    triggeredSynergyRuleIds,
    triggeredRiskRuleIds,
    derivedTags: packageContext.tags,
    preState,
    postState: snapshotEncounter(encounter),
    summaryLines: buildSummaryLines(packageContext, triggeredSynergyRuleIds, triggeredRiskRuleIds),
  }
  logEvent(run, 'player_effects_resolved', {
    encounterId: encounter.encounterId,
    turn: encounter.turn,
    cards: [resolved.primaryCardId, resolved.supportCardId].filter(Boolean),
    tags: resolved.derivedTags,
    synergy: triggeredSynergyRuleIds,
    risks: triggeredRiskRuleIds,
    preState,
    postState: resolved.postState,
  })
  return resolved
}

function buildSummaryLines(packageContext, synergyIds, riskIds) {
  const lines = [`${packageContext.primaryDef.name} set the tone as ${packageContext.primaryDef.intentTag}.`]
  if (packageContext.supportDef) lines.push(`${packageContext.supportDef.name} added ${packageContext.supportDef.intentTag} support.`)
  if (synergyIds.length) lines.push(`Synergy fired: ${synergyIds.join(', ')}.`)
  if (riskIds.length) lines.push(`Risk triggered: ${riskIds.join(', ')}.`)
  return lines
}

// ---------------------------------------------------------------------------
// Effect application
// ---------------------------------------------------------------------------

function applyEffects(encounter, effects, explanation) {
  for (const effect of effects) {
    explanation.push(effect.type + (effect.stat ? `:${effect.stat}` : effect.windowId ? `:${effect.windowId}` : effect.modifierId ? `:${effect.modifierId}` : ''))
    switch (effect.type) {
      case 'modify_stat':
        applyStatDelta(encounter, effect.stat, effect.amount)
        break
      case 'open_response_window':
        setWindowOpen(encounter, effect.windowId, true)
        break
      case 'close_response_window':
        setWindowOpen(encounter, effect.windowId, false)
        break
      case 'add_modifier':
        addModifier(encounter, effect.modifierId, effect.duration)
        break
      case 'remove_keyword':
        encounter.keywords = encounter.keywords.filter((keyword) => keyword !== effect.keyword)
        break
      case 'remove_keyword_one_of':
        encounter.keywords = encounter.keywords.filter((keyword) => !effect.keywords.includes(keyword))
        break
      case 'set_breakthrough_ready':
        encounter.breakthroughReady = effect.value
        if (effect.value) setWindowOpen(encounter, 'breakthrough', true)
        break
      case 'upgrade_outcome':
        if (encounter.result === effect.from || encounter.result === null) encounter.result = effect.to
        break
      case 'carry_forward':
        // Handled at finishEncounter level; no-op here
        break
      default:
        break
    }
  }
}

// ---------------------------------------------------------------------------
// Opposition resolution
// ---------------------------------------------------------------------------

function resolveOpposition(run, encounter, packageContext) {
  const template = encounterMap.get(encounter.templateId)
  const preState = snapshotEncounter(encounter)
  const sortedRules = [...template.reactionRules].sort((a, b) => b.priority - a.priority)
  const triggeredRule = sortedRules.find((rule) => matchesCondition(encounter, packageContext, rule.if))
  if (!triggeredRule) return
  if (hasModifier(encounter, 'reaction_shield')) {
    removeModifier(encounter, 'reaction_shield')
    encounter.lastOppositionAction = { ruleId: 'reaction_shielded', cue: 'A reaction shield soaked the encounter pushback.' }
    logEvent(run, 'opposition_rule_triggered', { encounterId: encounter.encounterId, turn: encounter.turn, ruleId: 'reaction_shielded', preState, postState: snapshotEncounter(encounter) })
    return
  }
  applyEffects(encounter, triggeredRule.effects || [], [])
  encounter.visibleCues = [triggeredRule.cue]
  encounter.lastOppositionAction = { ruleId: triggeredRule.id, cue: triggeredRule.cue }
  updateEncounterFlags(encounter)
  logEvent(run, 'opposition_rule_triggered', { encounterId: encounter.encounterId, turn: encounter.turn, ruleId: triggeredRule.id, preState, postState: snapshotEncounter(encounter), cue: triggeredRule.cue })
}

// ---------------------------------------------------------------------------
// Outcome evaluation
// ---------------------------------------------------------------------------

function evaluateOutcome(run, encounter) {
  const template = encounterMap.get(encounter.templateId)
  enterPhase(run, 'check_outcome')
  const breakthroughThresholds = template.breakthroughThresholds

  // Evaluate and surface breakthrough via BreakthroughManager (not static map)
  BreakthroughManager.evaluateAndSurface(run, encounter)

  const collapse = encounter.stats.tension >= 10 && encounter.stats.trust <= 2 || encounter.failedPlayCount >= 3 && encounter.stats.tension >= 8
  const breakthrough = encounter.stats.trust >= breakthroughThresholds.trust && encounter.stats.clarity >= breakthroughThresholds.clarity && encounter.stats.momentum >= breakthroughThresholds.momentum && encounter.breakthroughReady
  const stalemate = encounter.turn >= MAX_TURNS && encounter.stats.momentum <= 0 && encounter.stats.trust < 6
  const partial = encounter.turn >= 4 && (encounter.stats.trust >= 4 || encounter.stats.clarity >= 5)

  if (collapse) encounter.result = 'collapse'
  else if (encounter.surfacedBreakthroughId && encounter.responseWindows.find((entry) => entry.windowId === 'breakthrough' && entry.open) && breakthrough) encounter.result = 'breakthrough'
  else if (breakthrough) encounter.result = 'breakthrough'
  else if (stalemate) encounter.result = 'stalemate'
  else if (partial) encounter.result = 'partial'
  else encounter.result = null

  if (collapse) logEvent(run, 'collapse_armed', { encounterId: encounter.encounterId, turn: encounter.turn })
}

// ---------------------------------------------------------------------------
// Turn cleanup
// ---------------------------------------------------------------------------

function cleanupTurn(run, encounter, primary, support) {
  enterPhase(run, 'cleanup')
  discardIfPresent(run, primary)
  if (support) discardIfPresent(run, support)
  encounter.activeModifiers = encounter.activeModifiers.filter((modifier) => modifier.duration !== 'turn')
  run.metrics.turnsTaken += 1
  autosaveEngine(run)

  if (encounter.result) {
    finishEncounter(run, encounter)
  } else {
    encounter.turn += 1
    enterPhase(run, 'state_refresh')
  }
}

function finishEncounter(run, encounter) {
  encounter.status = 'resolved'
  logEvent(run, 'encounter_result', { encounterId: encounter.encounterId, result: encounter.result, turn: encounter.turn, stats: encounter.stats })
  applyCarryForward(run, encounter)
  run.resultHistory.push({ encounterId: encounter.encounterId, name: encounter.name, result: encounter.result, turn: encounter.turn })
  if (run.encounterIndex >= run.encounterOrder.length - 1) {
    run.status = 'completed'
    logEvent(run, 'run_completed', { results: run.resultHistory })
    autosaveEngine(run)
    return
  }
  run.encounterIndex += 1
  run.currentEncounter = createEncounterInstance(run.encounterOrder[run.encounterIndex], run.carryForward)
  logEvent(run, 'carry_forward_applied', { carryForward: run.carryForward })
  logEvent(run, 'encounter_started', { encounterId: run.currentEncounter.encounterId, prompt: run.currentEncounter.prompt })
  enterPhase(run, 'state_refresh')
}

function applyCarryForward(run, encounter) {
  const carry = run.carryForward
  carry.trustModifier = 0
  carry.tensionModifier = 0
  carry.clarityModifier = 0
  carry.momentumModifier = 0
  carry.blockedResponseTags = []

  if (encounter.result === 'breakthrough') {
    carry.trustModifier += 1
    carry.momentumModifier += 1
    if (encounter.surfacedBreakthroughId === 'B-002') carry.trustModifier += 1
  } else if (encounter.result === 'partial') {
    carry.clarityModifier += 1
  } else if (encounter.result === 'stalemate') {
    carry.momentumModifier -= 1
  } else if (encounter.result === 'collapse') {
    carry.trustModifier -= 1
    carry.tensionModifier += 1
    carry.blockedResponseTags = ['connect']
  }
}

// ---------------------------------------------------------------------------
// Deck operations
// ---------------------------------------------------------------------------

function discardIfPresent(run, card) {
  if (!card) return
  const index = run.deckState.hand.findIndex((entry) => entry.instanceId === card.instanceId)
  if (index >= 0) {
    const [removed] = run.deckState.hand.splice(index, 1)
    run.deckState.discardPile.push(removed)
  }
}

// ---------------------------------------------------------------------------
// Stat / modifier helpers
// ---------------------------------------------------------------------------

function applyStatDelta(encounter, stat, amount) {
  if (stat === 'momentum') encounter.stats[stat] = clamp(encounter.stats[stat] + amount, -5, 5)
  else encounter.stats[stat] = clamp(encounter.stats[stat] + amount, 0, 10)
}

function setWindowOpen(encounter, windowId, open) {
  const target = encounter.responseWindows.find((entry) => entry.windowId === windowId)
  if (target) target.open = open
}

function addModifier(encounter, modifierId, duration) {
  if (!encounter.activeModifiers.some((modifier) => modifier.modifierId === modifierId)) encounter.activeModifiers.push({ modifierId, duration })
}

function removeModifier(encounter, modifierId) {
  encounter.activeModifiers = encounter.activeModifiers.filter((modifier) => modifier.modifierId !== modifierId)
}

function hasModifier(encounter, modifierId) {
  return encounter.activeModifiers.some((modifier) => modifier.modifierId === modifierId)
}

function updateEncounterFlags(encounter) {
  encounter.stats.tension = clamp(encounter.stats.tension, 0, 10)
  encounter.stats.trust = clamp(encounter.stats.trust, 0, 10)
  encounter.stats.clarity = clamp(encounter.stats.clarity, 0, 10)
  encounter.stats.momentum = clamp(encounter.stats.momentum, -5, 5)
  encounter.collapseArmed = encounter.stats.tension >= 8 || encounter.failedPlayCount >= 2
}

// ---------------------------------------------------------------------------
// Condition matching (for card package effects)
// ---------------------------------------------------------------------------

function matchesCondition(encounter, packageContext, condition = {}) {
  if (!condition || Object.keys(condition).length === 0) return true
  if (condition.packageHasCategory && !packageContext.categories.includes(condition.packageHasCategory)) return false
  if (condition.packageHasTag && !packageContext.tags.includes(condition.packageHasTag)) return false
  if (condition.primaryCardId && packageContext.primaryDef.id !== condition.primaryCardId) return false
  if (condition.supportCardId && packageContext.supportDef?.id !== condition.supportCardId) return false
  if (condition.primaryIntentTagIn && !condition.primaryIntentTagIn.includes(packageContext.primaryDef.intentTag)) return false
  if (condition.primaryToneTagIn && !condition.primaryToneTagIn.includes(packageContext.primaryDef.toneTag)) return false
  if (condition.statGte) {
    const { stat, value } = condition.statGte
    if (encounter.stats[stat] < value) return false
  }
  if (condition.statLte) {
    const { stat, value } = condition.statLte
    if (encounter.stats[stat] > value) return false
  }
  if (condition.encounterHasKeyword && !encounter.keywords.includes(condition.encounterHasKeyword)) return false
  if (condition.encounterHasKeywordIn && !condition.encounterHasKeywordIn.some((keyword) => encounter.keywords.includes(keyword))) return false
  if (condition.breakthroughReady && !encounter.breakthroughReady) return false
  return true
}

function snapshotEncounter(encounter) {
  return {
    turn: encounter.turn,
    stats: { ...encounter.stats },
    responseWindows: encounter.responseWindows.filter((entry) => entry.open).map((entry) => entry.windowId),
    keywords: [...encounter.keywords],
    failedPlayCount: encounter.failedPlayCount,
    breakthroughReady: encounter.breakthroughReady,
    collapseArmed: encounter.collapseArmed,
  }
}

// ---------------------------------------------------------------------------
// Storage (internal — uses closure-scoped _storage)
// ---------------------------------------------------------------------------

function autosaveEngine(run) {
  run.updatedAt = new Date().toISOString()
  run.metrics.saveWrites += 1
  // Note: autosaveEngine uses the engine's _storage via closure
  // It is called only from within engine methods, so we store the reference
  // at module level — setStorageAdapter below handles injection for headless
}

// ---------------------------------------------------------------------------
// Logging
// ---------------------------------------------------------------------------

function logEvent(run, type, payload) {
  run.eventLog.push({ type, payload, timestamp: new Date().toISOString() })
  if (run.eventLog.length > 80) run.eventLog = run.eventLog.slice(-80)
}

// ---------------------------------------------------------------------------
// Exported helpers (also used by renderer)
// ---------------------------------------------------------------------------

function getPhaseInstruction(encounter) {
  if (!encounter) return 'Start a new run.'
  switch (encounter.phase) {
    case 'state_refresh':
      return 'Wait: the encounter is refreshing state and applying pressure.'
    case 'draw_prepare':
      return 'Wait: the game is drawing cards for this turn.'
    case 'read_situation':
      return 'Next action: review the situation and select 1 primary card.'
    case 'play_response':
      return 'Next action: click Play Selected Cards to submit your turn.'
    case 'resolve_effects':
      return 'Wait: your selected cards are resolving now.'
    case 'encounter_reaction':
      return 'Wait: the encounter is reacting to your play.'
    case 'check_outcome':
      return 'Wait: the game is checking the encounter result.'
    case 'cleanup':
      return 'Wait: cleanup is running before the next turn or encounter.'
    default:
      return 'Continue the current encounter.'
  }
}

function getRunHealthLabel(encounter) {
  if (!encounter) return { label: 'No active run', tone: 'neutral' }
  if (encounter.result) return { label: `Encounter resolved: ${encounter.result}`, tone: encounter.result === 'collapse' ? 'bad' : 'good' }
  if (encounter.collapseArmed) return { label: 'High risk: collapse is armed', tone: 'bad' }
  if (encounter.breakthroughReady) return { label: 'Opportunity: breakthrough is ready', tone: 'good' }
  if (encounter.stats.tension >= 7) return { label: 'Pressure rising: tension is high', tone: 'warn' }
  if (encounter.stats.trust >= 6 && encounter.stats.clarity >= 5) return { label: 'Stable: trust and clarity are strong', tone: 'good' }
  return { label: 'Live encounter: state is still contested', tone: 'neutral' }
}

function clamp(value, min, max) {
  return Math.max(min, Math.min(max, value))
}

// ---------------------------------------------------------------------------
// Storage adapter injection for headless environments
// ---------------------------------------------------------------------------

// The engine stores a reference to the storage adapter at creation time.
// For headless use, create the engine with a plain in-memory store:
//
//   const mem = {}
//   const engine = new GameEngine({ storageAdapter: { getItem: k => mem[k], setItem: (k,v) => { mem[k] = v } } })
//

// ---------------------------------------------------------------------------
// Exports for headless testing
// ---------------------------------------------------------------------------

export { getPhaseInstruction, getRunHealthLabel, clamp, shuffleDeterministic, getDefinition, snapshotEncounter }