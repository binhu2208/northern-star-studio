// Flower Boat — Digital Prototype Data
// All flower, route, weather, and customer content

export const flowers = [
  { id: 'sunflower',    name: 'Sunflower',       keyword: 'Warmth',   association: 'Warmth, joy, celebration' },
  { id: 'lavender',     name: 'Lavender',        keyword: 'Calm',     association: 'Calm, relaxation, comfort' },
  { id: 'wildflower',   name: 'Wildflower Mix',  keyword: 'Surprise', association: 'Nostalgia, freedom, surprise' },
  { id: 'lily',         name: 'White Lily',      keyword: 'Renewal',  association: 'Renewal, sincerity, grief' },
]

// NOTE: afternoon and evening routes deferred — their stops include
// market_dock and garden_gate which have no customer data yet.
// Morning route is the clean prototype baseline.
export const routes = [
  {
    id: 'morning',
    name: 'Morning Run',
    description: 'Quiet, early customers',
    stops: ['quiet_pier', 'corner_house', 'cafe_dock', 'old_bridge'],
  },
]

export const weather = [
  { id: 'sunshine', name: 'Sunshine', description: 'Warm and bright' },
  { id: 'rain',     name: 'Rain',     description: 'Grey and soft' },
]

export const stopDescriptions = {
  quiet_pier:   'A small wooden dock, morning light on the water.',
  corner_house: 'A narrow house wedged between two walls, a window box with dead flowers.',
  cafe_dock:    'A café with outdoor seating by the water. Steam rises from cups.',
  old_bridge:   'An old stone bridge. People stop here to look at the river.',
  market_dock:  'A busy market dock. Boats are unloading for the day.',
  garden_gate:  'A tucked-away garden path. Someone left the gate open.',
}

export const customers = [
  {
    id: 'hurry',
    stop: 'quiet_pier',
    whatTheySay: '"I just need something quick. I\'m running late."',
    subtext: 'They feel guilty for not putting more thought into it.',
    cue: 'Checking their watch. Standing on one foot.',
    rightFlower: 'sunflower',
    reactions: {
      right:   'Warmth — they brighten immediately. "This is perfect."',
      literal: 'They take it. "Thanks." A beat too fast.',
      wrong:   'They accept it, but something doesn\'t land.',
    },
  },
  {
    id: 'griever',
    stop: 'corner_house',
    whatTheySay: '"I don\'t know what I\'m looking for. Just... something."',
    subtext: 'They are not really looking for flowers. They are looking for a reason to pause.',
    cue: 'Standing very still. Not scanning the display.',
    rightFlower: 'lavender',
    reactions: {
      right:   'Renewal — they stop. Look at it. "Thank you." Quiet. That was enough.',
      literal: '"Okay." They take one. Not wrong, just... literal.',
      wrong:   'They take it but their hands stay still. Something didn\'t connect.',
    },
  },
  {
    id: 'stuck',
    stop: 'cafe_dock',
    whatTheySay: '"Is there something for someone who can\'t decide?"',
    subtext: 'They are not asking about flowers. They are asking about themselves.',
    cue: 'Looking past the flowers. Seated but not resting.',
    rightFlower: 'wildflower',
    reactions: {
      right:   'Surprise — they laugh, startled. "How did you know?" Something shifted.',
      literal: '"Hmm." They pick one. Unsure. It wasn\'t nothing but it wasn\'t right either.',
      wrong:   'They nod politely. Take one. It doesn\'t quite land.',
    },
  },
  {
    id: 'present',
    stop: 'old_bridge',
    whatTheySay: '"I come here every week. Just to see the river."',
    subtext: 'They are not lonely. They are full. They want to mark the moment.',
    cue: 'Leaning on the railing. A small smile. Not waiting for anything.',
    rightFlower: 'lily',
    reactions: {
      right:   'Calm — they take it slowly. "This is just right." Content.',
      literal: '"Thanks." Pleasant. But the moment passes without catching.',
      wrong:   'They accept it. Something is slightly off. Not wrong, just not right.',
    },
  },
]
