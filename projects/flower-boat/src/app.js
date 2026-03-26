// Flower Boat — Digital Prototype App
// State machine + UI rendering

import { flowers, routes, weather, stopDescriptions, customers } from './data.js'

// ─── State ────────────────────────────────────────────────────────────────────

const PHASES = Object.freeze({
  DEPARTURE:      'departure',
  STOCK_SELECTION:'stock_selection',
  ROUTE_MAP:      'route_map',
  ENCOUNTER:      'encounter',
  END_SUMMARY:    'end_summary',
})

const state = {
  phase:          PHASES.DEPARTURE,
  selectedWeather: null,
  selectedRoute:  null,
  stock:          [],          // array of flower ids (max 3)
  currentStop:    0,           // 0-3 index into route.stops
  encounterState: 'reading',   // 'reading' | 'outcome'
  selectedFlower: null,        // flower id chosen this encounter
  outcomes:       [],          // array of { stop, customerId, suggested, actual, fit }
  encounterIndex: 0,          // 1-4 for display
}

let currentRoute = null

// ─── DOM helpers ─────────────────────────────────────────────────────────────

function el(id) {
  const e = document.getElementById(id)
  if (!e) throw new Error(`Element #${id} not found`)
  return e
}

function hide(id)  { el(id).style.display = 'none' }
function show(id)  { el(id).style.display = '' }
function clear(id) { el(id).innerHTML = '' }

// ─── Render helpers ───────────────────────────────────────────────────────────

function flowerName(id) {
  return flowers.find((f) => f.id === id)?.name ?? id
}

function flowerKeyword(id) {
  return flowers.find((f) => f.id === id)?.keyword ?? ''
}

function getCustomerForStop(stopId) {
  return customers.find((c) => c.stop === stopId && (c.weather === state.selectedWeather || c.weather === 'both'))
}

function getStopName(stopId) {
  const names = {
    quiet_pier:   'The Quiet Pier',
    corner_house: 'The Corner House',
    cafe_dock:    'The Café Dock',
    old_bridge:   'The Old Bridge',
    market_dock:  'The Market Dock',
    garden_gate:  'The Garden Gate',
  }
  return names[stopId] ?? stopId
}

function getStopDesc(stopId) {
  return stopDescriptions[stopId] ?? ''
}

// ─── Screen renderers ────────────────────────────────────────────────────────

function renderDeparture() {
  clear('screen-content')

  const h2 = document.createElement('h2')
  h2.textContent = 'Your Boat, Your Route'
  el('screen-content').appendChild(h2)

  // Weather
  const weatherLabel = document.createElement('p')
  weatherLabel.className = 'section-label'
  weatherLabel.textContent = 'Choose the weather'
  el('screen-content').appendChild(weatherLabel)

  const weatherRow = document.createElement('div')
  weatherRow.className = 'choice-row'
  weather.forEach((w) => {
    const btn = document.createElement('button')
    btn.className = 'choice-btn weather-btn'
    btn.dataset.weatherId = w.id
    btn.innerHTML = `<span class="choice-icon">${w.id === 'sunshine' ? '☀️' : '🌧️'}</span><strong>${w.name}</strong><span class="choice-desc">${w.description}</span>`
    btn.addEventListener('click', () => selectWeather(w.id))
    weatherRow.appendChild(btn)
  })
  el('screen-content').appendChild(weatherRow)

  // Route
  const routeLabel = document.createElement('p')
  routeLabel.className = 'section-label'
  routeLabel.textContent = 'Choose your route'
  el('screen-content').appendChild(routeLabel)

  const routeRow = document.createElement('div')
  routeRow.className = 'choice-row'
  routes.forEach((r) => {
    const btn = document.createElement('button')
    btn.className = 'choice-btn route-btn'
    btn.dataset.routeId = r.id
    btn.innerHTML = `<strong>${r.name}</strong><span class="choice-desc">${r.description}</span>`
    btn.addEventListener('click', () => selectRoute(r.id))
    routeRow.appendChild(btn)
  })
  el('screen-content').appendChild(routeRow)

  // Set Sail
  const sailBtn = document.createElement('button')
  sailBtn.id = 'sail-btn'
  sailBtn.className = 'action-btn'
  sailBtn.disabled = true
  sailBtn.textContent = 'Set Sail'
  sailBtn.addEventListener('click', goToStockSelection)
  el('screen-content').appendChild(sailBtn)
}

function selectWeather(id) {
  state.selectedWeather = id
  document.querySelectorAll('.weather-btn').forEach((b) => {
    b.classList.toggle('selected', b.dataset.weatherId === id)
  })
  updateSailButton()
}

function selectRoute(id) {
  state.selectedRoute = id
  currentRoute = routes.find((r) => r.id === id)
  document.querySelectorAll('.route-btn').forEach((b) => {
    b.classList.toggle('selected', b.dataset.routeId === id)
  })
  updateSailButton()
}

function updateSailButton() {
  const btn = document.getElementById('sail-btn')
  if (btn) {
    btn.disabled = !(state.selectedWeather && state.selectedRoute)
  }
}

function goToStockSelection() {
  state.phase = PHASES.STOCK_SELECTION
  renderStockSelection()
}

function renderStockSelection() {
  clear('screen-content')

  // Stock slots
  const slotsDiv = document.createElement('div')
  slotsDiv.className = 'stock-slots'
  for (let i = 0; i < 3; i++) {
    const slot = document.createElement('div')
    slot.className = 'stock-slot'
    slot.id = `slot-${i}`
    slot.innerHTML = '<span class="slot-empty">?</span>'
    slotsDiv.appendChild(slot)
  }
  el('screen-content').appendChild(slotsDiv)

  const hint = document.createElement('p')
  hint.className = 'section-label'
  hint.textContent = 'Choose 3 flowers to stock'
  el('screen-content').appendChild(hint)

  const cardsRow = document.createElement('div')
  cardsRow.className = 'flower-cards-row'
  flowers.forEach((f) => {
    const card = document.createElement('div')
    card.className = 'flower-card'
    card.dataset.flowerId = f.id
    card.innerHTML = `<strong>${f.name}</strong><span class="flower-keyword">${f.keyword}</span><span class="flower-assoc">${f.association}</span>`
    card.addEventListener('click', () => toggleFlower(f.id))
    cardsRow.appendChild(card)
  })
  el('screen-content').appendChild(cardsRow)

  const confirmBtn = document.createElement('button')
  confirmBtn.id = 'confirm-stock-btn'
  confirmBtn.className = 'action-btn'
  confirmBtn.disabled = true
  confirmBtn.textContent = 'Confirm Stock'
  confirmBtn.addEventListener('click', goToRouteMap)
  el('screen-content').appendChild(confirmBtn)

  updateStockUI()
}

function toggleFlower(id) {
  const idx = state.stock.indexOf(id)
  if (idx >= 0) {
    state.stock.splice(idx, 1)
  } else if (state.stock.length < 3) {
    state.stock.push(id)
  }
  updateStockUI()
}

function updateStockUI() {
  flowers.forEach((f) => {
    const card = document.querySelector(`.flower-card[data-flower-id="${f.id}"]`)
    if (!card) return
    const inStock = state.stock.includes(f.id)
    card.classList.toggle('selected', inStock)
    card.classList.toggle('unavailable', state.stock.length >= 3 && !inStock)
  })

  for (let i = 0; i < 3; i++) {
    const slot = el(`slot-${i}`)
    if (state.stock[i]) {
      const f = flowers.find((fl) => fl.id === state.stock[i])
      slot.innerHTML = `<strong>${f.name}</strong><span>${f.keyword}</span>`
      slot.classList.add('filled')
      slot.classList.remove('empty')
    } else {
      slot.innerHTML = '<span class="slot-empty">?</span>'
      slot.classList.remove('filled')
      slot.classList.add('empty')
    }
  }

  const btn = document.getElementById('confirm-stock-btn')
  if (btn) btn.disabled = state.stock.length !== 3
}

function goToRouteMap() {
  state.phase = PHASES.ROUTE_MAP
  renderRouteMap()
}

function renderRouteMap() {
  clear('screen-content')

  const h2 = document.createElement('h2')
  h2.textContent = currentRoute.name
  el('screen-content').appendChild(h2)

  const desc = document.createElement('p')
  desc.className = 'route-desc'
  desc.textContent = currentRoute.description
  el('screen-content').appendChild(desc)

  const mapDiv = document.createElement('div')
  mapDiv.className = 'route-map'
  currentRoute.stops.forEach((stopId, i) => {
    const node = document.createElement('div')
    node.className = 'route-node'
    node.innerHTML = `<span class="stop-num">${i + 1}</span><strong>${getStopName(stopId)}</strong><span class="stop-desc">${getStopDesc(stopId)}</span>`
    mapDiv.appendChild(node)
  })
  el('screen-content').appendChild(mapDiv)

  const stockDiv = document.createElement('div')
  stockDiv.className = 'stock-summary'
  stockDiv.innerHTML = '<p><strong>Your flowers:</strong></p>'
  const list = document.createElement('div')
  list.className = 'stock-icons'
  state.stock.forEach((fid) => {
    const f = flowers.find((fl) => fl.id === fid)
    const chip = document.createElement('span')
    chip.className = 'flower-chip'
    chip.textContent = f.name
    list.appendChild(chip)
  })
  stockDiv.appendChild(list)
  el('screen-content').appendChild(stockDiv)

  const beginBtn = document.createElement('button')
  beginBtn.className = 'action-btn'
  beginBtn.textContent = 'Begin Run'
  beginBtn.addEventListener('click', startEncounters)
  el('screen-content').appendChild(beginBtn)
}

function startEncounters() {
  state.currentStop = 0
  state.encounterIndex = 1
  state.outcomes = []
  state.phase = PHASES.ENCOUNTER
  renderEncounter()
}

function renderEncounter() {
  clear('screen-content')

  const stopId = currentRoute.stops[state.currentStop]
  const customer = getCustomerForStop(stopId)

  const header = document.createElement('div')
  header.className = 'encounter-header'
  header.innerHTML = `<h2>${getStopName(stopId)}</h2><p class="stop-desc">${getStopDesc(stopId)}</p>`
  el('screen-content').appendChild(header)

  if (!customer) {
    // No customer at this stop — just a pass-through moment
    const passDiv = document.createElement('div')
    passDiv.className = 'pass-moment'
    passDiv.innerHTML = `<p>No one is here. You drift on.</p>`
    el('screen-content').appendChild(passDiv)
    const contBtn = document.createElement('button')
    contBtn.className = 'action-btn'
    contBtn.textContent = 'Continue'
    contBtn.addEventListener('click', advanceEncounter)
    el('screen-content').appendChild(contBtn)
    state.encounterState = 'pass'
    return
  }

  const card = document.createElement('div')
  card.className = 'customer-card'
  card.innerHTML = `
    <p class="customer-says">${customer.whatTheySay}</p>
    <p class="customer-subtext">${customer.subtext}</p>
    <p class="customer-cue">${customer.cue}</p>
  `
  el('screen-content').appendChild(card)

  const flowerRow = document.createElement('div')
  flowerRow.className = 'suggest-row'
  state.stock.forEach((fid) => {
    const f = flowers.find((fl) => fl.id === fid)
    const btn = document.createElement('button')
    btn.className = 'suggest-btn'
    btn.dataset.flowerId = fid
    btn.textContent = f.name
    btn.addEventListener('click', () => suggestFlower(fid))
    flowerRow.appendChild(btn)
  })

  const letThemChooseBtn = document.createElement('button')
  letThemChooseBtn.className = 'let-them-choose-btn'
  letThemChooseBtn.textContent = 'Let them choose'
  letThemChooseBtn.addEventListener('click', () => suggestFlower(null))
  flowerRow.appendChild(letThemChooseBtn)

  el('screen-content').appendChild(flowerRow)
  state.encounterState = 'reading'
}

function suggestFlower(flowerId) {
  const stopId = currentRoute.stops[state.currentStop]
  const customer = getCustomerForStop(stopId)
  if (!customer) { advanceEncounter(); return }

  state.selectedFlower = flowerId

  // Determine outcome based on weather-affinity
  let fit = 'literal'
  let reaction = ''

  if (flowerId === null) {
    fit = 'literal'
    reaction = customer.reactions.literal
  } else if (flowerId === customer.weatherRightFlower) {
    // Perfect match for this weather
    fit = 'right'
    reaction = customer.reactions.right
  } else {
    // Check affinity of suggested flower in this weather
    const f = flowers.find((fl) => fl.id === flowerId)
    const affinity = f ? f.affinities[state.selectedWeather] : 1
    if (affinity === 3) {
      // High affinity but not the primary — still "right" but weaker
      fit = 'rightLow'
      reaction = customer.reactions.rightLow
    } else {
      // Low affinity — wrong fit
      fit = 'wrong'
      reaction = customer.reactions.wrong
    }
  }

  const outcome = { stop: stopId, customerId: customer.id, suggested: flowerId, fit }
  state.outcomes.push(outcome)
  state.encounterState = 'outcome'

  // Show outcome
  const outcomeDiv = document.createElement('div')
  outcomeDiv.className = `outcome-card outcome-${fit}`
  outcomeDiv.innerHTML = `<p class="reaction-text">${reaction}</p>`
  el('screen-content').appendChild(outcomeDiv)

  const contBtn = document.createElement('button')
  contBtn.className = 'action-btn'
  contBtn.textContent = state.currentStop < currentRoute.stops.length - 1 ? 'Continue' : 'See Results'
  contBtn.addEventListener('click', advanceEncounter)
  el('screen-content').appendChild(contBtn)
}

function advanceEncounter() {
  state.currentStop++
  state.encounterIndex++

  if (state.currentStop >= currentRoute.stops.length) {
    state.phase = PHASES.END_SUMMARY
    renderEndSummary()
  } else {
    renderEncounter()
  }
}

function renderEndSummary() {
  clear('screen-content')

  const h2 = document.createElement('h2')
  h2.textContent = 'Back to Dock'
  el('screen-content').appendChild(h2)

  const helped = state.outcomes.filter((o) => o.fit === 'right' || o.fit === 'rightLow').length
  const total = state.outcomes.length

  const stats = document.createElement('div')
  stats.className = 'summary-stats'
  stats.innerHTML = `
    <p>Customers helped: <strong>${helped} of ${total}</strong></p>
  `
  el('screen-content').appendChild(stats)

  const history = document.createElement('div')
  history.className = 'outcome-history'
  state.outcomes.forEach((o) => {
    const customer = customers.find((c) => c.id === o.customerId)
    const div = document.createElement('div')
    const fitClass = o.fit === 'rightLow' ? 'right' : o.fit
    const fitLabel = o.fit === 'rightLow' ? 'right*' : o.fit
    div.className = `history-item history-${fitClass}`
    const suggestedName = o.suggested ? flowerName(o.suggested) : 'let them choose'
    div.innerHTML = `<strong>${getStopName(o.stop)}</strong>: ${suggestedName} — ${fitLabel}`
    history.appendChild(div)
  })
  el('screen-content').appendChild(history)

  const reflect = document.createElement('p')
  reflect.className = 'reflect-prompt'
  reflect.textContent = 'Did you sell what you expected to sell?'
  el('screen-content').appendChild(reflect)

  const btns = document.createElement('div')
  btns.className = 'summary-btns'

  const againBtn = document.createElement('button')
  againBtn.className = 'action-btn secondary'
  againBtn.textContent = 'Play Again (same route)'
  againBtn.addEventListener('click', () => {
    state.stock = []
    state.currentStop = 0
    state.encounterIndex = 1
    state.outcomes = []
    state.phase = PHASES.STOCK_SELECTION
    renderStockSelection()
  })
  btns.appendChild(againBtn)

  const newBtn = document.createElement('button')
  newBtn.className = 'action-btn'
  newBtn.textContent = 'New Run'
  newBtn.addEventListener('click', () => {
    state.selectedWeather = null
    state.selectedRoute = null
    state.stock = []
    state.currentStop = 0
    state.encounterIndex = 1
    state.outcomes = []
    currentRoute = null
    state.phase = PHASES.DEPARTURE
    renderDeparture()
  })
  btns.appendChild(newBtn)

  el('screen-content').appendChild(btns)
}

// ─── Phase routing ────────────────────────────────────────────────────────────

function render() {
  switch (state.phase) {
    case PHASES.DEPARTURE:       renderDeparture();       break
    case PHASES.STOCK_SELECTION: renderStockSelection();  break
    case PHASES.ROUTE_MAP:       renderRouteMap();        break
    case PHASES.ENCOUNTER:       renderEncounter();       break
    case PHASES.END_SUMMARY:     renderEndSummary();      break
  }
}

// ─── Init ─────────────────────────────────────────────────────────────────────

function init() {
  render()
}

init()
