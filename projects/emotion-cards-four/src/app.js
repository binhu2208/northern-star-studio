/**
 * app.js — thin UI shell.
 *
 * Responsibilities (only):
 * - Instantiate GameEngine with a browser storage adapter
 * - Instantiate UIRenderer and wire it to the engine
 * - Wire DOM events to engine actions
 * - Initialize (check for saved run on load)
 *
 * All game logic lives in engine.js. All DOM rendering lives in renderer.js.
 */

import { GameEngine } from './engine.js'
import { UIRenderer } from './renderer.js'

const SAVE_KEY = 'emotion-cards-four-prototype-save-v1'

// ---------------------------------------------------------------------------
// Storage adapter (browser localStorage)
// ---------------------------------------------------------------------------

const storage = {
  getItem: (key) => localStorage.getItem(key),
  setItem: (key, value) => {
    if (value === null) {
      localStorage.removeItem(key)
    } else {
      localStorage.setItem(key, value)
    }
  },
}

// ---------------------------------------------------------------------------
// Engine + Renderer
// ---------------------------------------------------------------------------

const engine = new GameEngine({ storageAdapter: storage, saveKey: SAVE_KEY })
const renderer = new UIRenderer(engine, {
  newRunBtn: 'new-run-btn',
  resumeRunBtn: 'resume-run-btn',
  clearSaveBtn: 'clear-save-btn',
  submitPlayBtn: 'submit-play-btn',
  advanceBtn: 'advance-btn',
  exportSaveBtn: 'export-save-btn',
  runStatusPill: 'run-status-pill',
  phasePill: 'phase-pill',
  handMeta: 'hand-meta',
  runOverview: 'run-overview',
  runStateSurface: 'run-state-surface',
  carryForward: 'carry-forward',
  resultHistory: 'result-history',
  encounterOverview: 'encounter-overview',
  visibleCues: 'visible-cues',
  responseWindows: 'response-windows',
  lastResolution: 'last-resolution',
  selectionState: 'selection-state',
  handCards: 'hand-cards',
  playFeedback: 'play-feedback',
  eventLog: 'event-log',
  stateDump: 'state-dump',
  saveOutput: 'save-output',
  rewardChoices: 'reward-choices',
})

// ---------------------------------------------------------------------------
// Event handlers
// ---------------------------------------------------------------------------

document.getElementById('new-run-btn').addEventListener('click', () => {
  engine.createRun()
  renderer.setFeedback('New deterministic run created.')
  renderer.render()
})

document.getElementById('resume-run-btn').addEventListener('click', () => {
  const run = engine.loadRun()
  if (!run) {
    renderer.setFeedback('No saved run found.', true)
    return
  }
  renderer.setFeedback('Saved run restored.')
  renderer.render()
})

document.getElementById('clear-save-btn').addEventListener('click', () => {
  engine.clearSave()
  renderer.setFeedback('Saved run cleared.')
  renderer.render()
})

document.getElementById('submit-play-btn').addEventListener('click', () => {
  const result = engine.submitPlay()
  if (!result.ok) {
    renderer.setFeedback(result.feedback, true)
  }
  renderer.render()
})

document.getElementById('advance-btn').addEventListener('click', () => {
  const result = engine.advancePhase()
  if (!result.ok && result.feedback) {
    renderer.setFeedback(result.feedback, true)
  }
  renderer.render()
})

document.getElementById('export-save-btn').addEventListener('click', () => {
  const run = engine.getRun()
  if (run) renderer.exportSaveToTextarea(run)
})

// Delegated card click (hand cards area)
document.getElementById('hand-cards').addEventListener('click', (event) => {
  const button = event.target.closest('.pick-card-btn')
  if (!button) return
  engine.toggleSelection(button.dataset.instanceId)
  renderer.render()
})

// Delegated reward choice click (reward choices panel)
document.getElementById('reward-choices').addEventListener('click', (event) => {
  const button = event.target.closest('.claim-reward-btn')
  if (!button) return

  const rewardId = button.dataset.rewardId
  const action = button.dataset.action

  if (!rewardId || !action) return

  if (action === 'pass') {
    // Claim reward with no card added (pass)
    const result = engine.claimReward(rewardId, {})
    if (!result.ok) {
      renderer.setFeedback(result.feedback, true)
    } else {
      renderer.setFeedback('Reward passed.')
    }
  } else if (action === 'add_starter') {
    // Claim reward and add a starter card to hand
    // For now, use a default card from the starter deck as the added card.
    // A full implementation would show a card picker UI.
    const result = engine.claimReward(rewardId, { addCardId: 'E-001' })
    if (!result.ok) {
      renderer.setFeedback(result.feedback, true)
    } else {
      renderer.setFeedback(`Reward claimed: added E-001 to hand.`)
    }
  }

  renderer.render()
})

// ---------------------------------------------------------------------------
// Initial load
// ---------------------------------------------------------------------------

const savedRun = engine.loadRun()
if (savedRun) {
  // Engine already loaded and stored the run
  renderer.render()
} else {
  renderer.render()
}
