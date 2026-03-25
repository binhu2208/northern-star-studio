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
  }

  /** Remove all event listeners and clean up. */
  destroy() {
    this._engine.off('run_created', this._boundRender)
    this._engine.off('run_loaded', this._boundRender)
    this._engine.off('play_resolved', this._boundRender)
    this._engine.off('selection_changed', this._boundRender)
    this._engine.off('phase_changed', this._boundRender)
    this._engine.off('saved', this._boundRender)
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

    // --- Run state surface ---
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
        ${btDef ? `<p>Surfaced breakthrough: ${btDef.id} — ${btDef.name}</p>` : ''}
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

    // --- Event log ---
    this._el('eventLog').innerHTML = [...run.eventLog].reverse().map((entry) => `<div class="log-entry"><strong>${entry.type}</strong><div>${entry.timestamp}</div><pre>${JSON.stringify(entry.payload, null, 2)}</pre></div>`).join('')

    // --- State dump ---
    this._el('stateDump').textContent = JSON.stringify(run, null, 2)
  }

  _renderRunStateSurface(run, encounter) {
    const health = getRunHealthLabel(encounter)
    const openWindows = encounter.responseWindows.filter((entry) => entry.open).map((entry) => entry.windowId)
    const nextStep = getPhaseInstruction(encounter)
    const remainingEncounters = run.encounterOrder.length - (run.encounterIndex + 1)
    const historySummary = run.resultHistory.length
      ? run.resultHistory.map((item) => `${item.name}: ${item.result}`).join(' • ')
      : 'No encounters resolved yet.'

    this._el('runStateSurface').innerHTML = `
      <div class="info-block run-state-surface ${health.tone}">
        <h3>Readable Run State</h3>
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
