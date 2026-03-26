/**
 * UIRenderer — all DOM rendering, zero game logic.
 *
 * Observes a GameEngine instance and re-renders the DOM whenever the engine
 * emits events or when the public `render()` method is called.
 *
 * The renderer does not own any game state; it only reads from the engine
 * via engine.getRun() and engine.getSelection().
 */

import { getPhaseInstruction, getRunHealthLabel, getDefinition } from './engine.js'

export class UIRenderer {
  /**
   * @param {GameEngine} engine
   * @param {object} selectors  - map of logical names to DOM element ids
   */
  constructor(engine, selectors = {}) {
    this._engine = engine
    this._sel = selectors
    this._boundRender = this.render.bind(this)

    // Subscribe to all engine events for automatic re-render
    engine.on('run_created', this._boundRender)
    engine.on('run_loaded', this._boundRender)
    engine.on('play_resolved', this._boundRender)
    engine.on('selection_changed', this._boundRender)
    engine.on('phase_changed', this._boundRender)
    engine.on('saved', this._boundRender)
    engine.on('reward_claimed', this._boundRender)
  }

  /** Remove all event listeners and clean up. */
  destroy() {
    this._engine.off('run_created', this._boundRender)
    this._engine.off('run_loaded', this._boundRender)
    this._engine.off('play_resolved', this._boundRender)
    this._engine.off('selection_changed', this._boundRender)
    this._engine.off('phase_changed', this._boundRender)
    this._engine.off('saved', this._boundRender)
    this._engine.off('reward_claimed', this._boundRender)
  }

  /** Force a full re-render. Call this after any engine action that doesn't emit a event. */
  render() {
    const run = this._engine.getRun()
    const encounter = run?.currentEncounter ?? null
    const selection = this._engine.getSelection()

    // --- Button states ---
    const saveKey = 'emotion-cards-four-prototype-save-v1'
    this._button('newRunBtn').disabled = !!run
    this._button('resumeRunBtn').disabled = !localStorage.getItem(saveKey)
    this._button('submitPlayBtn').disabled = !run || run.status !== 'active' || !['read_situation', 'play_response'].includes(encounter?.phase)
    this._button('advanceBtn').disabled = !run || run.status !== 'active' || !['read_situation'].includes(encounter?.phase)

    // --- Empty / no-run state ---
    if (!run) {
      this._el('runStatusPill').textContent = 'No run loaded'
      this._el('phasePill').textContent = '-'
      this._el('runOverview').innerHTML = '<div class="info-block">Start a new run or resume a saved one.</div>'
      this._el('runStateSurface').innerHTML = ''
      this._el('carryForward').innerHTML = ''
      this._el('resultHistory').innerHTML = ''
      this._el('encounterOverview').innerHTML = '<div class="info-block">No encounter active.</div>'
      this._el('visibleCues').innerHTML = ''
      this._el('responseWindows').innerHTML = ''
      this._el('lastResolution').innerHTML = ''
      this._el('selectionState').textContent = 'No cards selected.'
      this._el('handCards').innerHTML = ''
      this._el('eventLog').innerHTML = ''
      this._el('stateDump').textContent = ''
      this._el('saveOutput').value = ''
      this._el('handMeta').textContent = '0 cards'
      this._el('rewardChoices').innerHTML = ''
      return
    }

    // --- Header pills ---
    this._el('runStatusPill').textContent = `${run.status} • Encounter ${run.encounterIndex + 1}/${run.encounterOrder.length}`
    this._el('phasePill').textContent = encounter.phase
    this._el('handMeta').textContent = `${run.deckState.hand.length} cards • Draw ${run.deckState.drawPile.length} • Discard ${run.deckState.discardPile.length}`

    // --- Run overview mini-grid ---
    this._el('runOverview').innerHTML = `
      <div class="mini-grid">
        <div class="mini-card"><span>Run ID</span><strong>${run.runId}</strong></div>
        <div class="mini-card"><span>Status</span><strong>${run.status}</strong></div>
        <div class="mini-card"><span>Total turns</span><strong>${run.metrics.turnsTaken}</strong></div>
        <div class="mini-card"><span>Poor-fit plays</span><strong>${run.metrics.poorFitPlays}</strong></div>
        <div class="mini-card"><span>Encounter</span><strong>${run.encounterIndex + 1}/${run.encounterOrder.length}</strong></div>
        <div class="mini-card"><span>Phase</span><strong>${encounter.phase}</strong></div>
      </div>`

    // --- Run state surface (includes NAC + breakthrough state) ---
    this._renderRunStateSurface(run, encounter)

    // --- Carry forward ---
    const cf = run.carryForward
    this._el('carryForward').innerHTML = `
      <div class="info-block">
        <h3>Carry Forward</h3>
        <div class="mini-grid">
          <div class="mini-card"><span>Trust</span><strong>${cf.trustModifier >= 0 ? '+' : ''}${cf.trustModifier}</strong></div>
          <div class="mini-card"><span>Tension</span><strong>${cf.tensionModifier >= 0 ? '+' : ''}${cf.tensionModifier}</strong></div>
          <div class="mini-card"><span>Clarity</span><strong>${cf.clarityModifier >= 0 ? '+' : ''}${cf.clarityModifier}</strong></div>
          <div class="mini-card"><span>Momentum</span><strong>${cf.momentumModifier >= 0 ? '+' : ''}${cf.momentumModifier}</strong></div>
        </div>
        <p>Blocked windows: ${cf.blockedResponseTags.join(', ') || 'none'}</p>
        <p>Unlocked breakthroughs: ${cf.unlockedBreakthroughCards.join(', ') || 'none'}</p>
      </div>`

    // --- Result history ---
    this._el('resultHistory').innerHTML = `
      <div class="info-block">
        <h3>Result History</h3>
        <div class="history-list">${run.resultHistory.length
          ? run.resultHistory.map((item) => `<span class="history-item">${item.name}: ${item.result}</span>`).join('')
          : '<span class="history-item">No encounters resolved yet</span>'}</div>
      </div>`

    // --- Encounter overview ---
    const btDef = encounter.surfacedBreakthroughId ? getDefinition(encounter.surfacedBreakthroughId) : null
    this._el('encounterOverview').innerHTML = `
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
        ${btDef ? `<p>Surfaced breakthrough: ${btDef.id} — ${btDef.name} ${encounter.breakthroughPlayable ? '🔓 playable' : '🔒 next turn'}</p>` : ''}
        ${encounter.surfacedBreakthroughId && !encounter.breakthroughPlayable ? `<p class="hint">Breakthrough playable from turn ${encounter.breakthroughSurfaceTurn + 1}.</p>` : ''}
      </div>`

    // --- Visible cues ---
    this._el('visibleCues').innerHTML = `<div class="info-block"><h3>Visible cues</h3><div class="cue-list">${encounter.visibleCues.map((cue) => `<span class="cue">${cue}</span>`).join('')}</div></div>`

    // --- Response windows ---
    this._el('responseWindows').innerHTML = `<div class="info-block"><h3>Response windows</h3><div class="windows">${encounter.responseWindows.map((window) => `<span class="window ${window.open ? 'open' : 'closed'}">${window.windowId}</span>`).join('')}</div></div>`

    // --- Last resolution ---
    const lastPlayer = encounter.lastPlayerAction
    const lastOpposition = encounter.lastOppositionAction
    this._el('lastResolution').innerHTML = `
      <div class="info-block">
        <h3>Last resolution</h3>
        <p>${lastPlayer ? lastPlayer.summaryLines.join(' ') : 'No play resolved yet.'}</p>
        <p>${lastOpposition ? `Opposition: ${lastOpposition.ruleId} — ${lastOpposition.cue}` : 'No opposition reaction yet.'}</p>
        <p>${encounter.result ? `Current result state: ${encounter.result}` : 'Encounter continues.'}</p>
      </div>`

    // --- Selection state ---
    const selPrimary = selection.primary ? getDefinition(run.deckState.hand.find((c) => c.instanceId === selection.primary))?.name : 'none'
    const selSupport = selection.support ? getDefinition(run.deckState.hand.find((c) => c.instanceId === selection.support))?.name : 'none'
    this._el('selectionState').textContent = `Primary: ${selPrimary} • Support: ${selSupport}`

    // --- Hand cards ---
    this._el('handCards').innerHTML = run.deckState.hand.map((card) => {
      const def = getDefinition(card)
      const selectedClass = selection.primary === card.instanceId ? 'selected-primary' : selection.support === card.instanceId ? 'selected-support' : ''
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
        </article>`
    }).join('')

    // --- Reward choices (carry-forward reward panel) ---
    this._renderRewardChoices(run)

    // --- Event log ---
    this._el('eventLog').innerHTML = [...run.eventLog].reverse().map((entry) => `<div class="log-entry"><strong>${entry.type}</strong><div>${entry.timestamp}</div><pre>${JSON.stringify(entry.payload, null, 2)}</pre></div>`).join('')

    // --- State dump ---
    this._el('stateDump').textContent = JSON.stringify(run, null, 2)
  }

  // -------------------------------------------------------------------------
  // NAC — Next-Action Cue
  // -------------------------------------------------------------------------

  /**
   * Determine the NAC state from current encounter signals.
   * Returns { state: 'active'|'neutral'|'noSignal'|'locked', label, hint, icon }
   *
   * NAC states (ART-V1-002):
   * - locked:      encounter is resolving / player cannot act
   * - active:      clear specific next action to recommend
   * - neutral:     readable state, no dominant recommendation
   * - noSignal:    cannot generate useful recommendation (suppressed)
   */
  _getNACState(encounter) {
    const phase = encounter?.phase

    // Locked phases — player cannot act
    const lockedPhases = ['state_refresh', 'draw_prepare', 'resolve_effects', 'encounter_reaction', 'check_outcome', 'cleanup']
    if (!phase || lockedPhases.includes(phase)) {
      return { state: 'locked', label: 'Wait', hint: 'the encounter is resolving', icon: '⏳' }
    }

    const openWindows = encounter.responseWindows.filter((w) => w.open).map((w) => w.windowId)
    const { breakthroughReady, breakthroughPlayable, collapseArmed, stats } = encounter

    // Active recommendation: collapse armed — suggest caution/de-escalation
    if (collapseArmed) {
      if (openWindows.includes('protect')) {
        return { state: 'active', label: 'Protect', hint: 'collapse is armed — a protect card could help', icon: '🛡️' }
      }
      if (openWindows.includes('connect')) {
        return { state: 'active', label: 'Connect', hint: 'collapse is armed — building trust may help', icon: '🤝' }
      }
      return { state: 'active', label: 'Be cautious', hint: 'collapse is armed — consider a protect or stabilize card', icon: '⚠️' }
    }

    // Active recommendation: breakthrough ready and playable
    if (breakthroughReady && breakthroughPlayable) {
      return { state: 'active', label: 'Breakthrough', hint: 'a breakthrough path is open — consider playing it', icon: '✨' }
    }

    // Active recommendation: breakthrough surfaced but not yet playable (next-turn rule)
    if (breakthroughReady && !breakthroughPlayable && encounter.surfacedBreakthroughId) {
      const btDef = getDefinition(encounter.surfacedBreakthroughId)
      return { state: 'neutral', label: 'Breakthrough incoming', hint: `${btDef?.name ?? 'Breakthrough'} unlocked — playable next turn`, icon: '🔓' }
    }

    // Active recommendation: open windows available — suggest based on window type
    if (openWindows.length > 0) {
      if (openWindows.includes('connect') && stats.trust < 6) {
        return { state: 'active', label: 'Open a trust window', hint: 'a connect card fits here and trust is still building', icon: '🤝' }
      }
      if (openWindows.includes('reveal') && stats.clarity < 5) {
        return { state: 'active', label: 'Reveal to clarify', hint: 'a reveal card could help build clarity here', icon: '💡' }
      }
      if (openWindows.includes('repair') && stats.clarity < 5) {
        return { state: 'active', label: 'Repair and clarify', hint: 'a repair card could help here', icon: '🔧' }
      }
      if (openWindows.includes('protect') && stats.tension >= 7) {
        return { state: 'active', label: 'Protect', hint: 'tension is high — a protect card could help de-escalate', icon: '🛡️' }
      }
      if (openWindows.includes('breakthrough')) {
        return { state: 'active', label: 'Breakthrough window open', hint: 'a breakthrough card can be played this turn', icon: '✨' }
      }
      // Generic open window — pick first open
      return { state: 'neutral', label: `${openWindows[0]} available`, hint: 'your turn — choose a card that fits an open window', icon: '🎴' }
    }

    // No signal: no open windows and no urgent state
    return { state: 'noSignal', label: '', hint: '', icon: '' }
  }

  _renderNAC(encounter) {
    const nac = this._getNACState(encounter)
    const stateClass = `nac-${nac.state}`
    const icon = nac.icon ? `<span class="nac-icon">${nac.icon}</span>` : ''
    const label = nac.label ? `<strong class="nac-label">${nac.label}</strong>` : ''
    const hint = nac.hint ? `<span class="nac-hint">${nac.hint}</span>` : ''

    return `
      <div class="nac-component ${stateClass}" aria-label="Next-Action Cue: ${nac.state}">
        ${icon}${label}${hint}
      </div>`
  }

  // -------------------------------------------------------------------------
  // Reward Choices (carry-forward)
  // -------------------------------------------------------------------------

  _renderRewardChoices(run) {
    const rewardData = this._engine.getPendingRewards()
    const { choicesRemaining, pendingRewards } = rewardData

    if (choicesRemaining <= 0) {
      this._el('rewardChoices').innerHTML = ''
      return
    }

    const rewardsHtml = pendingRewards.map((reward) => `
      <div class="reward-item" data-reward-id="${reward.rewardId}">
        <strong>${reward.type}</strong> — ${reward.source}
        ${reward.poolTag ? `<span class="tag">pool: ${reward.poolTag}</span>` : ''}
        <p>Choose ${reward.count} card${reward.count > 1 ? 's' : ''}</p>
        <div class="reward-actions">
          <button class="secondary claim-reward-btn" data-reward-id="${reward.rewardId}" data-action="add_starter">Add starter card</button>
          <button class="secondary claim-reward-btn" data-reward-id="${reward.rewardId}" data-action="pass">Pass (no card)</button>
        </div>
      </div>`).join('')

    this._el('rewardChoices').innerHTML = `
      <div class="info-block reward-choices-panel">
        <h3>⚡ Carry-Forward Rewards <span class="badge">${choicesRemaining} choice${choicesRemaining > 1 ? 's' : ''} remaining</span></h3>
        <p class="hint">These rewards were earned from your last encounter result. Choose now before the next encounter begins.</p>
        <div class="reward-list">${rewardsHtml}</div>
      </div>`
  }

  // -------------------------------------------------------------------------
  // Run state surface
  // -------------------------------------------------------------------------

  _renderRunStateSurface(run, encounter) {
    const health = getRunHealthLabel(encounter)
    const openWindows = encounter.responseWindows.filter((entry) => entry.open).map((entry) => entry.windowId)
    const nextStep = getPhaseInstruction(encounter)
    const remainingEncounters = run.encounterOrder.length - (run.encounterIndex + 1)
    const historySummary = run.resultHistory.length
      ? run.resultHistory.map((item) => `${item.name}: ${item.result}`).join(' • ')
      : 'No encounters resolved yet.'

    // NAC block
    const nacHtml = this._renderNAC(encounter)

    // Breakthrough status strip
    let btStrip = ''
    if (encounter.surfacedBreakthroughId) {
      const btDef = getDefinition(encounter.surfacedBreakthroughId)
      const playableNow = encounter.breakthroughPlayable
      btStrip = `
        <div class="bt-strip ${playableNow ? 'bt-playable' : 'bt-waiting'}">
          <span class="bt-icon">${playableNow ? '✨' : '🔓'}</span>
          <span><strong>Breakthrough:</strong> ${btDef?.name ?? encounter.surfacedBreakthroughId}</span>
          <span class="bt-status">${playableNow ? 'playable now' : `unlocks turn ${encounter.breakthroughSurfaceTurn + 1}`}</span>
        </div>`
    } else if (encounter.breakthroughReady) {
      btStrip = `<div class="bt-strip bt-ready"><span>🔓</span><span>Breakthrough ready — conditions met, awaiting surfacing</span></div>`
    }

    this._el('runStateSurface').innerHTML = `
      <div class="info-block run-state-surface ${health.tone}">
        <h3>Readable Run State</h3>
        ${nacHtml}
        ${btStrip}
        <div class="next-action-callout">
          <span class="next-action-label">Do this next</span>
          <strong>${nextStep}</strong>
        </div>
        <p><strong>Current encounter:</strong> ${encounter.name}</p>
        <p><strong>What's happening:</strong> ${health.label}</p>
        <p><strong>Current step:</strong> ${encounter.phase}</p>
        <p><strong>Open response windows:</strong> ${openWindows.join(', ') || 'none'}</p>
        <p><strong>Remaining encounters after this one:</strong> ${remainingEncounters}</p>
        <p><strong>Run history:</strong> ${historySummary}</p>
      </div>`
  }

  // -------------------------------------------------------------------------
  // Feedback (used by app.js event handlers)
  // -------------------------------------------------------------------------

  setFeedback(message, isError = false) {
    const el = this._el('playFeedback')
    el.textContent = message
    el.className = `feedback ${isError ? 'result-bad' : ''}`
  }

  // -------------------------------------------------------------------------
  // Export save to textarea
  // -------------------------------------------------------------------------

  exportSaveToTextarea(run) {
    this._el('saveOutput').value = JSON.stringify(run, null, 2)
  }

  // -------------------------------------------------------------------------
  // DOM helpers
  // -------------------------------------------------------------------------

  _el(name) {
    const id = this._sel[name] || name
    const el = document.getElementById(id)
    if (!el) console.warn(`[UIRenderer] Element not found: #${id}`)
    return el
  }

  _button(name) {
    return this._el(name)
  }
}
