// Flower Boat — Digital Prototype App (bundled, no ES modules)
// State machine + UI rendering

// ─── Data (inlined from data.js) ──────────────────────────────────────────────

const flowers = [
  { id: 'sunflower', name: 'Sunflower', affinities: { sunshine: 5, rain: 1 } },
  { id: 'lavender', name: 'Lavender', affinities: { sunshine: 2, rain: 4 } },
  { id: 'wildflower', name: 'Wildflower', affinities: { sunshine: 3, rain: 3 } },
  { id: 'whitelily', name: 'White Lily', affinities: { sunshine: 2, rain: 4 } },
  { id: 'rose', name: 'Rose', affinities: { sunshine: 4, rain: 2 } },
  { id: 'chrysanthemum', name: 'Chrysanthemum', affinities: { sunshine: 3, rain: 3 } },
  { id: 'freesia', name: 'Freesia', affinities: { sunshine: 4, rain: 2 } },
]

const weather = [
  { id: 'sunshine', name: 'Sunshine', icon: '☀️' },
  { id: 'rain', name: 'Rain', icon: '🌧️' },
]

const routes = {
  morning: {
    stops: [
      { id: 's1', name: 'Canal Corner', description: 'A quiet bend where the water narrows.' },
      { id: 's2', name: 'Market Bridge', description: 'Wooden planks creak underfoot. The smell of fresh bread.' },
      { id: 's3', name: 'Garden Lock', description: "A small lock rises from the canal's edge." },
      { id: 's4', name: 'Old Pier', description: 'Weathered boards. A bench facing the water.' },
    ]
  }
}

const customers = {
  sunshine: [
    { id: 'c1', name: 'The Hurry', need: 'something cheerful but not heavy', hint: 'I\'m in a rush, but I want to feel good.' },
    { id: 'c2', name: 'The Gatherer', need: 'something for a sunny picnic', hint: 'Stocking up for an afternoon outside.' },
    { id: 'c3', name: 'The Observer', need: 'something quiet and warm', hint: 'Just watching the world go by.' },
    { id: 'c4', name: 'The Student', need: 'something to focus with', hint: 'Mind\'s elsewhere. Need to think.' },
  ],
  rain: [
    { id: 'c5', name: 'The Griever', need: 'something soft and comforting', hint: 'Today is heavy. I need something to hold onto.' },
    { id: 'c6', name: 'The Dreamer', need: 'something gentle and blue', hint: 'Rain makes me nostalgic.' },
    { id: 'c7', name: 'The Worker', need: 'something practical and bright', hint: 'Even rain days have things to do.' },
    { id: 'c8', name: 'The Drifter', need: 'something unexpected', hint: 'Not sure what I\'m looking for. Surprise me.' },
  ]
}

const stopDescriptions = routes.morning.stops.reduce((acc, s) => { acc[s.id] = s.description; return acc }, {})

// ─── State ────────────────────────────────────────────────────────────────────

const PHASES = Object.freeze({
  DEPARTURE:      'departure',
  ROUTE_MAP:      'route_map',
  PLANNING:       'planning',
  STOCK_SELECTION:'stock_selection',
  ENCOUNTER:      'encounter',
  END_SUMMARY:    'end_summary',
})

const state = {
  phase:          PHASES.DEPARTURE,
  selectedWeather: null,
  selectedRoute:  null,
  stock:          [],
  plannedExpectations: {},
  currentStop:    0,
  encounterState: 'reading',
  selectedFlower: null,
  outcomes:       [],
  encounterIndex: 1,
}

let currentRoute = null

// ─── DOM helpers ──────────────────────────────────────────────────────────────

function el(id) {
  const e = document.getElementById(id)
  if (!e) throw new Error(`Element #${id} not found`)
  return e
}

function hide(id)  { el(id).style.display = 'none' }
function show(id)  { el(id).style.display = '' }
function clear(id) { el(id).innerHTML = '' }

function flowerName(id) {
  return flowers.find((f) => f.id === id)?.name ?? id
}

function flowerKeyword(id) {
  const f = flowers.find((f) => f.id === id)
  if (!f) return ''
  const kw = []
  if (f.affinities.sunshine >= 4) kw.push('warm')
  if (f.affinities.rain >= 4) kw.push('cool')
  if (kw.length === 0) kw.push('neutral')
  return kw.join(', ')
}

function flowerFit(flowerId, customerId) {
  const f = flowers.find((f) => f.id === flowerId)
  const w = state.selectedWeather
  if (!f || !w) return 'neutral'
  const aff = f.affinities[w] ?? 3
  if (aff >= 4) return 'good'
  if (aff <= 2) return 'poor'
  return 'neutral'
}

function fitLabel(fit) {
  return { good: 'Fits well ✓', neutral: 'Neutral', poor: 'Doesn\'t fit ✗' }[fit]
}

function currentWeather() {
  return weather.find((w) => w.id === state.selectedWeather)
}

function currentStop() {
  if (!currentRoute) return null
  return currentRoute.stops[state.currentStop]
}

function currentCustomer() {
  const w = state.selectedWeather
  const wCustomers = customers[w] ?? []
  const stop = currentStop()
  if (!stop) return null
  const seed = state.currentStop + (state.encounterIndex * 10)
  return wCustomers[seed % wCustomers.length]
}

// ─── Render ───────────────────────────────────────────────────────────────────

function renderDeparture() {
  clear('screen-content')
  const title = document.createElement('h2')
  title.textContent = 'Flower Boat'
  el('screen-content').appendChild(title)

  const sub = document.createElement('p')
  sub.textContent = 'Choose your weather'
  el('screen-content').appendChild(sub)

  const weatherRow = document.createElement('div')
  weather.forEach((w) => {
    const btn = document.createElement('button')
    btn.className = 'weather-btn'
    btn.textContent = `${w.icon} ${w.name}`
    btn.addEventListener('click', () => selectWeather(w.id))
    weatherRow.appendChild(btn)
  })
  el('screen-content').appendChild(weatherRow)
}

function selectWeather(weatherId) {
  state.selectedWeather = weatherId
  state.phase = PHASES.ROUTE_MAP
  renderRouteMap()
}

function renderRouteMap() {
  clear('screen-content')
  const w = currentWeather()
  const sub = document.createElement('p')
  sub.textContent = `${w.icon} ${w.name} — Morning Route`
  el('screen-content').appendChild(sub)

  const stopList = document.createElement('div')
  stopList.className = 'route-list'
  routes.morning.stops.forEach((stop, i) => {
    const div = document.createElement('div')
    div.className = 'route-stop'
    div.textContent = `${i + 1}. ${stop.name}`
    stopList.appendChild(div)
  })
  el('screen-content').appendChild(stopList)

  const sailBtn = document.createElement('button')
  sailBtn.className = 'action-btn'
  sailBtn.textContent = 'Set Sail'
  sailBtn.addEventListener('click', goToStockSelection)
  el('screen-content').appendChild(sailBtn)
}

function goToStockSelection() {
  state.phase = PHASES.STOCK_SELECTION
  renderStockSelection()
}

function renderStockSelection() {
  clear('screen-content')
  const title = document.createElement('h2')
  title.textContent = 'Choose Your Flowers'
  el('screen-content').appendChild(title)

  const sub = document.createElement('p')
  sub.textContent = 'Pick up to 3'
  el('screen-content').appendChild(sub)

  const grid = document.createElement('div')
  grid.className = 'flower-grid'
  flowers.forEach((f) => {
    const card = document.createElement('div')
    card.className = `flower-card ${state.stock.includes(f.id) ? 'selected' : ''}`
    card.dataset.id = f.id

    const sunIcon = f.affinities.sunshine >= 3 ? ' ☀️' : ''
    const rainIcon = f.affinities.rain >= 3 ? ' 🌧️' : ''
    card.innerHTML = `<strong>${f.name}</strong><br>Sun:${f.affinities.sunshine} Rain:${f.affinities.rain}${sunIcon}${rainIcon}`

    card.addEventListener('click', () => toggleFlower(f.id))
    grid.appendChild(card)
  })
  el('screen-content').appendChild(grid)

  const selected = document.createElement('p')
  selected.id = 'stock-count'
  selected.textContent = `${state.stock.length}/3 selected`
  el('screen-content').appendChild(selected)

  const confirmBtn = document.createElement('button')
  confirmBtn.className = 'action-btn'
  confirmBtn.textContent = 'Confirm Stock'
  confirmBtn.addEventListener('click', goToPlanning)
  el('screen-content').appendChild(confirmBtn)
}

function toggleFlower(flowerId) {
  const idx = state.stock.indexOf(flowerId)
  if (idx >= 0) {
    state.stock.splice(idx, 1)
  } else if (state.stock.length < 3) {
    state.stock.push(flowerId)
  }
  renderStockSelection()
}

function goToPlanning() {
  state.phase = PHASES.PLANNING
  renderPlanning()
}

function renderPlanning() {
  clear('screen-content')
  const title = document.createElement('h2')
  title.textContent = 'Before You Sail'
  el('screen-content').appendChild(title)

  const sub = document.createElement('p')
  sub.textContent = 'What do you expect at each stop?'
  el('screen-content').appendChild(sub)

  const w = currentWeather()
  const wCustomers = customers[w?.id] ?? []

  const grid = document.createElement('div')
  currentRoute?.stops.forEach((stop, i) => {
    const row = document.createElement('div')
    row.className = 'planning-row'

    const label = document.createElement('span')
    label.textContent = `${i + 1}. ${stop.name}`
    row.appendChild(label)

    const select = document.createElement('select')
    select.dataset.stopId = stop.id
    const defaultOpt = document.createElement('option')
    defaultOpt.value = ''
    defaultOpt.textContent = '— unknown —'
    select.appendChild(defaultOpt)
    wCustomers.forEach((c) => {
      const opt = document.createElement('option')
      opt.value = c.id
      opt.textContent = c.name
      select.appendChild(opt)
    })
    select.addEventListener('change', (e) => {
      state.plannedExpectations[stop.id] = e.target.value
    })
    row.appendChild(select)
    grid.appendChild(row)
  })
  el('screen-content').appendChild(grid)

  const confirmBtn = document.createElement('button')
  confirmBtn.className = 'action-btn'
  confirmBtn.textContent = 'Set Sail with These Flowers'
  confirmBtn.addEventListener('click', startEncounters)
  el('screen-content').appendChild(confirmBtn)
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
  const stop = currentStop()
  const customer = currentCustomer()
  if (!stop || !customer) {
    endSummary()
    return
  }

  const w = currentWeather()
  const stopCustomer = customers[w?.id]?.[state.currentStop % 4]

  const header = document.createElement('div')
  header.className = 'encounter-header'
  header.innerHTML = `<span>🌸 ${stop.name}</span><span>${w?.icon} ${w?.name}</span>`
  el('screen-content').appendChild(header)

  const desc = document.createElement('p')
  desc.className = 'stop-desc'
  desc.textContent = stopDescriptions[stop.id] ?? ''
  el('screen-content').appendChild(desc)

  const card = document.createElement('div')
  card.className = 'customer-card'
  card.innerHTML = `<h3>${stopCustomer?.name ?? '???'}</h3><p class="hint">"${stopCustomer?.hint ?? ''}"</p>`
  el('screen-content').appendChild(card)

  const flowerGrid = document.createElement('div')
  flowerGrid.className = 'flower-grid'
  state.stock.forEach((fid) => {
    const f = flowers.find((f) => f.id === fid)
    const fit = flowerFit(fid, stopCustomer?.id)
    const card = document.createElement('div')
    card.className = `flower-card selectable ${fit}`
    card.dataset.id = fid
    card.innerHTML = `<strong>${f?.name}</strong><br><small>${fitLabel(fit)}</small>`
    card.addEventListener('click', () => suggestFlower(fid, fit))
    flowerGrid.appendChild(card)
  })
  el('screen-content').appendChild(flowerGrid)

  const nav = document.createElement('div')
  nav.className = 'encounter-nav'
  if (state.currentStop > 0) {
    const prev = document.createElement('button')
    prev.textContent = '← Previous'
    prev.addEventListener('click', prevStop)
    nav.appendChild(prev)
  }
  const next = document.createElement('button')
  next.textContent = state.currentStop < 3 ? 'Next →' : 'Finish'
  next.addEventListener('click', nextStop)
  nav.appendChild(next)
  el('screen-content').appendChild(nav)
}

function suggestFlower(flowerId, fit) {
  const stop = currentStop()
  const w = currentWeather()
  const stopCustomer = customers[w?.id]?.[state.currentStop % 4]
  state.outcomes.push({
    stop: stop?.id,
    customerId: stopCustomer?.id,
    suggested: flowerId,
    actual: stopCustomer?.id,
    fit,
  })
  document.querySelectorAll('.flower-card.selectable').forEach((c) => {
    c.classList.remove('selected')
    if (c.dataset.id === flowerId) c.classList.add('selected')
  })
}

function nextStop() {
  if (state.currentStop < 3) {
    state.currentStop++
    renderEncounter()
  } else {
    endSummary()
  }
}

function prevStop() {
  if (state.currentStop > 0) {
    state.currentStop--
    renderEncounter()
  }
}

function endSummary() {
  state.phase = PHASES.END_SUMMARY
  clear('screen-content')
  const title = document.createElement('h2')
  title.textContent = 'Journey Complete'
  el('screen-content').appendChild(title)

  const w = currentWeather()
  state.outcomes.forEach((o, i) => {
    const stop = currentRoute?.stops[i]
    const f = flowers.find((f) => f.id === o.suggested)
    const div = document.createElement('div')
    div.className = 'outcome-row'
    div.innerHTML = `<strong>${i + 1}. ${stop?.name}</strong> — ${f?.name} (${fitLabel(o.fit)})`
    el('screen-content').appendChild(div)
  })

  const btns = document.createElement('div')
  btns.className = 'action-group'
  const again = document.createElement('button')
  again.textContent = 'Sail Again'
  again.addEventListener('click', () => {
    state.stock = []
    state.outcomes = []
    state.currentStop = 0
    state.encounterIndex = 1
    state.phase = PHASES.DEPARTURE
    renderDeparture()
  })
  btns.appendChild(again)
  el('screen-content').appendChild(btns)
}

function render() {
  switch (state.phase) {
    case PHASES.DEPARTURE:       renderDeparture();       break
    case PHASES.ROUTE_MAP:       renderRouteMap();        break
    case PHASES.PLANNING:        renderPlanning();         break
    case PHASES.STOCK_SELECTION: renderStockSelection();   break
    case PHASES.ENCOUNTER:       renderEncounter();        break
    case PHASES.END_SUMMARY:     endSummary();             break
  }
}

function init() {
  currentRoute = routes.morning
  render()
}

init()
