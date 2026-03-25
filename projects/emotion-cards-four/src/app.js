import { CARD_DEFINITIONS, ENCOUNTER_TEMPLATES, PHASES, RESPONSE_WINDOWS, STARTER_DECK, BREAKTHROUGH_SURFACES } from './data.js'

const SAVE_KEY = 'emotion-cards-four-prototype-save-v1'
const MAX_HAND_SIZE = 4
const MAX_TURNS = 6

const cardMap = new Map(CARD_DEFINITIONS.map((card) => [card.id, card]))
const encounterMap = new Map(ENCOUNTER_TEMPLATES.map((encounter) => [encounter.id, encounter]))

const state = {
  run: null,
  selection: { primary: null, support: null },
}

const els = {
  newRunBtn: document.getElementById('new-run-btn'),
  resumeRunBtn: document.getElementById('resume-run-btn'),
  clearSaveBtn: document.getElementById('clear-save-btn'),
  submitPlayBtn: document.getElementById('submit-play-btn'),
  advanceBtn: document.getElementById('advance-btn'),
  exportSaveBtn: document.getElementById('export-save-btn'),
  runStatusPill: document.getElementById('run-status-pill'),
  phasePill: document.getElementById('phase-pill'),
  handMeta: document.getElementById('hand-meta'),
  runOverview: document.getElementById('run-overview'),
  runStateSurface: document.getElementById('run-state-surface'),
  carryForward: document.getElementById('carry-forward'),
  resultHistory: document.getElementById('result-history'),
  encounterOverview: document.getElementById('encounter-overview'),
  visibleCues: document.getElementById('visible-cues'),
  responseWindows: document.getElementById('response-windows'),
  lastResolution: document.getElementById('last-resolution'),
  selectionState: document.getElementById('selection-state'),
  handCards: document.getElementById('hand-cards'),
  playFeedback: document.getElementById('play-feedback'),
  eventLog: document.getElementById('event-log'),
  stateDump: document.getElementById('state-dump'),
  saveOutput: document.getElementById('save-output'),
}

function createRun() {
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
      surfacedBreakthrough: null,
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
  return run
}

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
    responseWindows: RESPONSE_WINDOWS.map((windowId) => ({ windowId, open: template.startingWindows.includes(windowId) && !carryForward.blockedResponseTags.includes(windowId) })),
    visibleCues: [...template.visibleCues],
    activeModifiers: [],
    pressureLevel: 0,
    failedPlayCount: 0,
    breakthroughReady: false,
    collapseArmed: false,
    lastPlayerAction: null,
    lastOppositionAction: null,
    surfacedBreakthroughId: null,
  }
}

function createCardInstance(definitionId) {
  return { instanceId: `${definitionId}-${Math.random().toString(36).slice(2, 8)}`, definitionId }
}

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

function getDefinition(cardOrId) {
  const id = typeof cardOrId === 'string' ? cardOrId : cardOrId.definitionId
  return cardMap.get(id)
}

function getCurrentEncounter(run = state.run) {
  return run?.currentEncounter ?? null
}

function enterPhase(run, phase) {
  const encounter = getCurrentEncounter(run)
  if (!encounter || encounter.status !== 'active') return
  encounter.phase = phase
  logEvent(run, 'phase_entered', { encounterId: encounter.encounterId, turn: encounter.turn, phase })
  if (phase === 'state_refresh') handleStateRefresh(run)
  if (phase === 'draw_prepare') handleDrawPrepare(run)
}

function advancePhase() {
  const run = state.run
  if (!run || run.status !== 'active') return
  const encounter = getCurrentEncounter(run)
  const phase = encounter.phase
  if (phase === 'read_situation') return enterPhase(run, 'play_response')
  if (phase === 'play_response') return setFeedback('Choose a legal primary card before playing, or advance only after submitting a response.', true)
  if (phase === 'resolve_effects' || phase === 'encounter_reaction' || phase === 'check_outcome' || phase === 'cleanup') return
}

function handleStateRefresh(run) {
  const encounter = getCurrentEncounter(run)
  const turn = encounter.turn
  if (turn >= 4 && !hasModifier(encounter, 'no_tension_increase')) {
    applyStatDelta(encounter, 'tension', 1)
    encounter.pressureLevel += 1
  }
  if (hasModifier(encounter, 'deflected_last_turn')) {
    applyStatDelta(encounter, 'clarity', -1)
    removeModifier(encounter, 'deflected_last_turn')
  }
  updateEncounterFlags(encounter)
  autosave(run, 'state_refresh')
  enterPhase(run, 'draw_prepare')
}

function handleDrawPrepare(run) {
  const encounter = getCurrentEncounter(run)
  drawToHand(run, run.deckState.maxHandSize)
  logEvent(run, 'cards_drawn', { encounterId: encounter.encounterId, turn: encounter.turn, hand: run.deckState.hand.map((card) => card.definitionId) })
  enterPhase(run, 'read_situation')
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
    deckState.hand.push(next)
  }
}

function toggleSelection(instanceId) {
  const run = state.run
  if (!run) return
  const card = run.deckState.hand.find((entry) => entry.instanceId === instanceId)
  if (!card) return
  const def = getDefinition(card)
  if (def.deckRole === 'breakthrough') return
  if (def.deckRole === 'primary') {
    state.selection.primary = state.selection.primary === instanceId ? null : instanceId
  } else if (def.deckRole === 'support') {
    state.selection.support = state.selection.support === instanceId ? null : instanceId
  }
  render()
}

function submitPlay() {
  const run = state.run
  if (!run || run.status !== 'active') return
  const encounter = getCurrentEncounter(run)
  if (encounter.phase === 'read_situation') {
    enterPhase(run, 'play_response')
  } else if (encounter.phase !== 'play_response') {
    setFeedback('You can only play cards during the play response phase.', true)
    return
  }
  const primary = run.deckState.hand.find((card) => card.instanceId === state.selection.primary)
  const support = run.deckState.hand.find((card) => card.instanceId === state.selection.support)
  const validation = validatePlay(run, primary, support)
  if (!validation.ok) {
    logEvent(run, 'play_validation_failed', { encounterId: encounter.encounterId, turn: encounter.turn, reason: validation.reason })
    setFeedback(validation.reason, true)
    return
  }
  const packageContext = buildPackageContext(primary, support)
  encounter.lastPlayerAction = resolvePlayerEffects(run, encounter, packageContext)
  enterPhase(run, 'resolve_effects')
  resolveOpposition(run, encounter, packageContext)
  evaluateOutcome(run, encounter)
  cleanupTurn(run, encounter, primary, support)
  state.selection = { primary: null, support: null }
  render()
}

function validatePlay(run, primary, support) {
  const encounter = getCurrentEncounter(run)
  if (!primary) return { ok: false, reason: 'A primary Emotion or Reaction card is required.' }
  const primaryDef = getDefinition(primary)
  if (!['emotion', 'reaction'].includes(primaryDef.category)) return { ok: false, reason: 'Primary card must be an Emotion or Reaction card.' }
  if (support) {
    const supportDef = getDefinition(support)
    if (!['memory', 'shift'].includes(supportDef.category)) return { ok: false, reason: 'Support card must be a Memory or Shift card.' }
  }
  const openWindows = encounter.responseWindows.filter((entry) => entry.open).map((entry) => entry.windowId)
  if (!openWindows.includes(primaryDef.intentTag) && !openWindows.includes('repair') && primaryDef.intentTag !== 'protect') {
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
        break
      default:
        break
    }
  }
}

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

function evaluateOutcome(run, encounter) {
  const template = encounterMap.get(encounter.templateId)
  enterPhase(run, 'check_outcome')
  const breakthroughThresholds = template.breakthroughThresholds
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

  if (encounter.breakthroughReady && !encounter.surfacedBreakthroughId) {
    encounter.surfacedBreakthroughId = BREAKTHROUGH_SURFACES[encounter.encounterId]
    const surfacedId = encounter.surfacedBreakthroughId
    if (!run.carryForward.unlockedBreakthroughCards.includes(surfacedId)) run.carryForward.unlockedBreakthroughCards.push(surfacedId)
    logEvent(run, 'breakthrough_unlocked', { encounterId: encounter.encounterId, turn: encounter.turn, breakthroughId: surfacedId })
  }
  if (collapse) logEvent(run, 'collapse_armed', { encounterId: encounter.encounterId, turn: encounter.turn })
}

function cleanupTurn(run, encounter, primary, support) {
  enterPhase(run, 'cleanup')
  discardIfPresent(run, primary)
  if (support) discardIfPresent(run, support)
  encounter.activeModifiers = encounter.activeModifiers.filter((modifier) => modifier.duration !== 'turn')
  run.metrics.turnsTaken += 1
  autosave(run, 'cleanup')

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
    autosave(run, 'run_completed')
    render()
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

function discardIfPresent(run, card) {
  const index = run.deckState.hand.findIndex((entry) => entry.instanceId === card.instanceId)
  if (index >= 0) {
    const [removed] = run.deckState.hand.splice(index, 1)
    run.deckState.discardPile.push(removed)
  }
}

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

function autosave(run, reason) {
  run.updatedAt = new Date().toISOString()
  run.metrics.saveWrites += 1
  localStorage.setItem(SAVE_KEY, JSON.stringify(run))
  logEvent(run, 'save_written', { reason, encounterId: run.currentEncounter?.encounterId, turn: run.currentEncounter?.turn })
}

function loadRun() {
  const raw = localStorage.getItem(SAVE_KEY)
  if (!raw) return null
  const run = JSON.parse(raw)
  run.metrics.resumes = (run.metrics.resumes || 0) + 1
  logEvent(run, 'save_loaded', { runId: run.runId })
  return run
}

function logEvent(run, type, payload) {
  run.eventLog.push({ type, payload, timestamp: new Date().toISOString() })
  if (run.eventLog.length > 80) run.eventLog = run.eventLog.slice(-80)
}

function setFeedback(message, isError = false) {
  els.playFeedback.textContent = message
  els.playFeedback.className = `feedback ${isError ? 'result-bad' : ''}`
}

function exportSave() {
  if (!state.run) return
  els.saveOutput.value = JSON.stringify(state.run, null, 2)
}

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

function renderRunStateSurface(run, encounter) {
  const health = getRunHealthLabel(encounter)
  const openWindows = encounter.responseWindows.filter((entry) => entry.open).map((entry) => entry.windowId)
  const nextStep = getPhaseInstruction(encounter)
  const remainingEncounters = run.encounterOrder.length - (run.encounterIndex + 1)
  const historySummary = run.resultHistory.length
    ? run.resultHistory.map((item) => `${item.name}: ${item.result}`).join(' • ')
    : 'No encounters resolved yet.'

  els.runStateSurface.innerHTML = `
    <div class="info-block run-state-surface ${health.tone}">
      <h3>Readable Run State</h3>
      <div class="next-action-callout">
        <span class="next-action-label">Do this next</span>
        <strong>${nextStep}</strong>
      </div>
      <p><strong>Current encounter:</strong> ${encounter.name}</p>
      <p><strong>What’s happening:</strong> ${health.label}</p>
      <p><strong>Current step:</strong> ${encounter.phase}</p>
      <p><strong>Open response windows:</strong> ${openWindows.join(', ') || 'none'}</p>
      <p><strong>Remaining encounters after this one:</strong> ${remainingEncounters}</p>
      <p><strong>Run history:</strong> ${historySummary}</p>
    </div>
  `
}

function render() {
  const run = state.run
  const encounter = getCurrentEncounter(run)
  els.resumeRunBtn.disabled = !localStorage.getItem(SAVE_KEY)
  els.submitPlayBtn.disabled = !run || run.status !== 'active' || !['read_situation', 'play_response'].includes(encounter.phase)
  els.advanceBtn.disabled = !run || run.status !== 'active' || !['read_situation'].includes(encounter.phase)

  if (!run) {
    els.runStatusPill.textContent = 'No run loaded'
    els.phasePill.textContent = '-'
    els.runOverview.innerHTML = '<div class="info-block">Start a new run or resume a saved one.</div>'
    els.runStateSurface.innerHTML = ''
    els.carryForward.innerHTML = ''
    els.resultHistory.innerHTML = ''
    els.encounterOverview.innerHTML = '<div class="info-block">No encounter active.</div>'
    els.visibleCues.innerHTML = ''
    els.responseWindows.innerHTML = ''
    els.lastResolution.innerHTML = ''
    els.selectionState.textContent = 'No cards selected.'
    els.handCards.innerHTML = ''
    els.eventLog.innerHTML = ''
    els.stateDump.textContent = ''
    els.saveOutput.value = ''
    els.handMeta.textContent = '0 cards'
    return
  }

  els.runStatusPill.textContent = `${run.status} • Encounter ${run.encounterIndex + 1}/${run.encounterOrder.length}`
  els.phasePill.textContent = encounter.phase
  els.handMeta.textContent = `${run.deckState.hand.length} cards • Draw ${run.deckState.drawPile.length} • Discard ${run.deckState.discardPile.length}`

  els.runOverview.innerHTML = `
    <div class="mini-grid">
      <div class="mini-card"><span>Run ID</span><strong>${run.runId}</strong></div>
      <div class="mini-card"><span>Status</span><strong>${run.status}</strong></div>
      <div class="mini-card"><span>Total turns</span><strong>${run.metrics.turnsTaken}</strong></div>
      <div class="mini-card"><span>Poor-fit plays</span><strong>${run.metrics.poorFitPlays}</strong></div>
      <div class="mini-card"><span>Encounter</span><strong>${run.encounterIndex + 1}/${run.encounterOrder.length}</strong></div>
      <div class="mini-card"><span>Phase</span><strong>${encounter.phase}</strong></div>
    </div>
  `

  renderRunStateSurface(run, encounter)

  els.carryForward.innerHTML = `
    <div class="info-block">
      <h3>Carry Forward</h3>
      <div class="mini-grid">
        <div class="mini-card"><span>Trust</span><strong>${run.carryForward.trustModifier >= 0 ? '+' : ''}${run.carryForward.trustModifier}</strong></div>
        <div class="mini-card"><span>Tension</span><strong>${run.carryForward.tensionModifier >= 0 ? '+' : ''}${run.carryForward.tensionModifier}</strong></div>
        <div class="mini-card"><span>Clarity</span><strong>${run.carryForward.clarityModifier >= 0 ? '+' : ''}${run.carryForward.clarityModifier}</strong></div>
        <div class="mini-card"><span>Momentum</span><strong>${run.carryForward.momentumModifier >= 0 ? '+' : ''}${run.carryForward.momentumModifier}</strong></div>
      </div>
      <p>Blocked windows: ${run.carryForward.blockedResponseTags.join(', ') || 'none'}</p>
      <p>Unlocked breakthroughs: ${run.carryForward.unlockedBreakthroughCards.join(', ') || 'none'}</p>
    </div>
  `

  els.resultHistory.innerHTML = `
    <div class="info-block">
      <h3>Result History</h3>
      <div class="history-list">${run.resultHistory.length ? run.resultHistory.map((item) => `<span class="history-item">${item.name}: ${item.result}</span>`).join('') : '<span class="history-item">No encounters resolved yet</span>'}</div>
    </div>
  `

  els.encounterOverview.innerHTML = `
    <div class="info-block">
      <h3>${encounter.name}</h3>
      <p>${encounter.prompt}</p>
      <div class="stat-grid">
        <div class="stat-card"><span>Tension</span><strong>${encounter.stats.tension}</strong></div>
        <div class="stat-card"><span>Trust</span><strong>${encounter.stats.trust}</strong></div>
        <div class="stat-card"><span>Clarity</span><strong>${encounter.stats.clarity}</strong></div>
        <div class="stat-card"><span>Momentum</span><strong>${encounter.stats.momentum}</strong></div>
      </div>
      <p>Turn ${encounter.turn} • Failed plays ${encounter.failedPlayCount} • Breakthrough ready: ${encounter.breakthroughReady ? 'yes' : 'no'} • Collapse armed: ${encounter.collapseArmed ? 'yes' : 'no'}</p>
      <p>Keywords: ${encounter.keywords.join(', ') || 'none'}</p>
      ${encounter.surfacedBreakthroughId ? `<p>Surfaced breakthrough: ${encounter.surfacedBreakthroughId} — ${getDefinition(encounter.surfacedBreakthroughId).name}</p>` : ''}
    </div>
  `

  els.visibleCues.innerHTML = `<div class="info-block"><h3>Visible cues</h3><div class="cue-list">${encounter.visibleCues.map((cue) => `<span class="cue">${cue}</span>`).join('')}</div></div>`
  els.responseWindows.innerHTML = `<div class="info-block"><h3>Response windows</h3><div class="windows">${encounter.responseWindows.map((window) => `<span class="window ${window.open ? 'open' : 'closed'}">${window.windowId}</span>`).join('')}</div></div>`

  const lastPlayer = encounter.lastPlayerAction
  const lastOpposition = encounter.lastOppositionAction
  els.lastResolution.innerHTML = `
    <div class="info-block">
      <h3>Last resolution</h3>
      <p>${lastPlayer ? lastPlayer.summaryLines.join(' ') : 'No play resolved yet.'}</p>
      <p>${lastOpposition ? `Opposition: ${lastOpposition.ruleId} — ${lastOpposition.cue}` : 'No opposition reaction yet.'}</p>
      <p>${encounter.result ? `Current result state: ${encounter.result}` : 'Encounter continues.'}</p>
    </div>
  `

  els.selectionState.textContent = `Primary: ${state.selection.primary ? getDefinition(run.deckState.hand.find((card) => card.instanceId === state.selection.primary)).name : 'none'} • Support: ${state.selection.support ? getDefinition(run.deckState.hand.find((card) => card.instanceId === state.selection.support)).name : 'none'}`
  els.handCards.innerHTML = run.deckState.hand.map((card) => {
    const def = getDefinition(card)
    const selectedClass = state.selection.primary === card.instanceId ? 'selected-primary' : state.selection.support === card.instanceId ? 'selected-support' : ''
    return `
      <article class="card ${selectedClass}" data-instance-id="${card.instanceId}">
        <header>
          <div>
            <h3>${def.name}</h3>
            <p>${def.category} • ${def.intentTag}</p>
          </div>
          <span class="pill">${def.deckRole}</span>
        </header>
        <p>${def.summaryText}</p>
        <div class="card-tags">${def.tags.slice(0, 4).map((tag) => `<span class="tag">${tag}</span>`).join('')}</div>
        <button class="secondary pick-card-btn" data-instance-id="${card.instanceId}">Select</button>
      </article>
    `
  }).join('')

  els.eventLog.innerHTML = [...run.eventLog].reverse().map((entry) => `<div class="log-entry"><strong>${entry.type}</strong><div>${entry.timestamp}</div><pre>${JSON.stringify(entry.payload, null, 2)}</pre></div>`).join('')
  els.stateDump.textContent = JSON.stringify(run, null, 2)
}

function clamp(value, min, max) {
  return Math.max(min, Math.min(max, value))
}

els.newRunBtn.addEventListener('click', () => {
  state.run = createRun()
  setFeedback('New deterministic run created.')
  render()
})
els.resumeRunBtn.addEventListener('click', () => {
  const run = loadRun()
  if (!run) return setFeedback('No saved run found.', true)
  state.run = run
  setFeedback('Saved run restored.')
  render()
})
els.clearSaveBtn.addEventListener('click', () => {
  localStorage.removeItem(SAVE_KEY)
  if (!state.run) render()
  setFeedback('Saved run cleared.')
})
els.submitPlayBtn.addEventListener('click', submitPlay)
els.advanceBtn.addEventListener('click', advancePhase)
els.exportSaveBtn.addEventListener('click', exportSave)
els.handCards.addEventListener('click', (event) => {
  const button = event.target.closest('.pick-card-btn')
  if (!button) return
  toggleSelection(button.dataset.instanceId)
})

const existing = loadRun()
if (existing) state.run = existing
render()
