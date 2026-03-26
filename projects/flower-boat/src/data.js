// Flower Boat — Digital Prototype Data
// All flower, route, weather, and customer content

export const flowers = [
  { id: 'sunflower',    name: 'Sunflower',        keyword: 'Warmth',     association: 'Warmth, joy, celebration',       affinities: { sunshine: 3, rain: 1 } },
  { id: 'lavender',     name: 'Lavender',         keyword: 'Calm',       association: 'Calm, relaxation, comfort',   affinities: { sunshine: 1, rain: 3 } },
  { id: 'wildflower',   name: 'Wildflower Mix',    keyword: 'Surprise',   association: 'Nostalgia, freedom, surprise', affinities: { sunshine: 3, rain: 1 } },
  { id: 'lily',         name: 'White Lily',        keyword: 'Renewal',    association: 'Renewal, sincerity, grief',   affinities: { sunshine: 1, rain: 3 } },
  { id: 'rose',         name: 'Rose',              keyword: 'Love',       association: 'Deep affection, gratitude, apology', affinities: { sunshine: 2, rain: 2 } },
  { id: 'chrysanthemum',name: 'Chrysanthemum',     keyword: 'Longevity',  association: 'Recovery, rest, getting better', affinities: { sunshine: 2, rain: 2 } },
  { id: 'freesia',      name: 'Freesia',           keyword: 'Innocence', association: 'New beginnings, lightness, trust', affinities: { sunshine: 2, rain: 1 } },
]

export const routes = [
  {
    id: 'morning',
    name: 'Morning Run',
    description: 'Quiet, early customers',
    stops: ['quiet_pier', 'corner_house', 'cafe_dock', 'old_bridge'],
  },
  {
    id: 'afternoon',
    name: 'Afternoon Route',
    description: 'Busier, more variety',
    stops: ['market_dock', 'garden_gate', 'old_bridge', 'cafe_dock'],
  },
  {
    id: 'evening',
    name: 'Evening Cruise',
    description: 'Reflective, quieter',
    stops: ['garden_gate', 'quiet_pier', 'old_bridge', 'corner_house'],
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
    weather: 'sunshine',
    whatTheySay: '"I just need something quick. I\'m running late."',
    subtext: 'They feel guilty for not putting more thought into it.',
    cue: 'Checking their watch. Standing on one foot.',
    // coreNeed: 'warmth' — satisfied by sunflower or lily
    weatherRightFlower: 'sunflower',
    reactions: {
      right:     'Warmth — they brighten immediately. "This is perfect."',
      rightLow:  'They take it. It\'s warm but... not quite what they hoped. "Thanks." A beat too fast.',
      literal:   'They take it. "Thanks." A beat too fast.',
      wrong:     'They accept it, but something doesn\'t land.',
    },
  },
  {
    id: 'griever',
    stop: 'corner_house',
    weather: 'rain',
    whatTheySay: '"I don\'t know what I\'m looking for. Just... something."',
    subtext: 'They are not really looking for flowers. They are looking for a reason to pause.',
    cue: 'Standing very still. Not scanning the display.',
    // coreNeed: 'comfort' — satisfied by lavender or lily
    weatherRightFlower: 'lavender',
    reactions: {
      right:     'Renewal — they stop. Look at it. "Thank you." Quiet. That was enough.',
      rightLow:  'They take it. It\'s quiet but not quite the comfort they needed. "Okay." A pause.',
      literal:   '"Okay." They take one. Not wrong, just... literal.',
      wrong:     'They take it but their hands stay still. Something didn\'t connect.',
    },
  },
  {
    id: 'stuck',
    stop: 'cafe_dock',
    weather: 'both',
    whatTheySay: '"Is there something for someone who can\'t decide?"',
    subtext: 'They are not asking about flowers. They are asking about themselves.',
    cue: 'Looking past the flowers. Seated but not resting.',
    // coreNeed: 'freedom' — satisfied by wildflower or sunflower
    weatherRightFlower: 'wildflower',
    reactions: {
      right:     'Surprise — they laugh, startled. "How did you know?" Something shifted.',
      rightLow:  'They take it. Something nudges. "Hmm." Not quite the permission they needed.',
      literal:   '"Hmm." They pick one. Unsure. It wasn\'t nothing but it wasn\'t right either.',
      wrong:     'They nod politely. Take one. It doesn\'t quite land.',
    },
  },
  {
    id: 'present',
    stop: 'old_bridge',
    weather: 'both',
    whatTheySay: '"I come here every week. Just to see the river."',
    subtext: 'They are not lonely. They are full. They want to mark the moment.',
    cue: 'Leaning on the railing. A small smile. Not waiting for anything.',
    // coreNeed: 'renewal' — satisfied by lily or lavender
    weatherRightFlower: 'lily',
    reactions: {
      right:     'Calm — they take it slowly. "This is just right." Content.',
      rightLow:  'They take it. It\'s pleasant but... the moment passes without quite catching.',
      literal:   '"Thanks." Pleasant. But the moment passes without catching.',
      wrong:     'They accept it. Something is slightly off. Not wrong, just not right.',
    },
  },
  {
    id: 'celebrator',
    stop: 'market_dock',
    weather: 'sunshine',
    whatTheySay: '"I just found out! I wanted to mark it."',
    subtext: 'They want to celebrate with someone. The flower is the gesture, not the gift.',
    cue: 'Animated. Can\'t sit still. Eyes bright.',
    // coreNeed: 'joy' — satisfied by sunflower or wildflower
    weatherRightFlower: 'sunflower',
    reactions: {
      right:     'Pure joy — they light up. "This is exactly it!" A perfect gesture.',
      rightLow:  'They take it, happy. "This works!" But something\'s slightly off.',
      literal:   '"Thanks!" They\'re happy enough. It registers.',
      wrong:     'They accept it. The gesture lands but not the feeling.',
    },
  },
  {
    id: 'overstimulated',
    stop: 'garden_gate',
    weather: 'rain',
    whatTheySay: '"It\'s been... a lot today. I just need to breathe."',
    subtext: 'They\'re overwhelmed. The world is too loud. They need quiet.',
    cue: 'Shoulders up, eyes scanning, not resting anywhere.',
    // coreNeed: 'calm' — satisfied by lavender or lily
    weatherRightFlower: 'lavender',
    reactions: {
      right:     'The tension drops. They breathe. "Yes. Thank you." Quiet relief.',
      rightLow:  'They take it. "Okay." Something eases, but not fully.',
      literal:   '"Okay." They take one. A pause. It helps a little.',
      wrong:     'They accept it but don\'t settle. Still too loud inside.',
    },
  },
]
