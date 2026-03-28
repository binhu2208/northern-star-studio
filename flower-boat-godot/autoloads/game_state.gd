# Flower Boat — Game State (Autoload)
# Singleton — persists across all scenes
# Manages: weather, route, phase, encounter state

extends Node

signal phase_changed(new_phase: String)
signal weather_changed(new_weather: String)
signal encounter_started(stop_index: int)
signal encounter_resolved(outcome: Dictionary)
signal game_reset()

const PHASES := {
	"TITLE": "title",
	"WEATHER_SELECT": "weather_select", 
	"ROUTE_MAP": "route_map",
	"STOCK_SELECT": "stock_select",
	"PLANNING": "planning",
	"ENCOUNTER": "encounter",
	"SUMMARY": "summary",
}

const WEATHERS := {
	"SUNSHINE": "sunshine",
	"RAIN": "rain",
	"FOG": "fog",
	"GOLDEN_HOUR": "golden_hour",
}

var current_phase: String = PHASES.TITLE
var current_weather: String = ""
var current_route: String = "morning"

var current_stop_index: int = 0
var encounter_index: int = 1
var outcomes: Array = []

var planned_expectations: Dictionary = {}  # stop_id → expected_customer_id

func _ready() -> void:
	print("GameState: initialized")

func set_phase(phase: String) -> void:
	if PHASES.values().has(phase):
		current_phase = phase
		phase_changed.emit(phase)
		print("GameState: phase → ", phase)
	else:
		push_error("GameState: invalid phase ", phase)

func set_weather(weather: String) -> void:
	if WEATHERS.values().has(weather):
		current_weather = weather
		weather_changed.emit(weather)
		print("GameState: weather → ", weather)
	else:
		push_error("GameState: invalid weather ", weather)

func get_num_stops() -> int:
	match current_route:
		"morning": return 4
		"afternoon": return 4
		"evening": return 4
	return 4

func get_current_stop() -> int:
	return current_stop_index

func next_stop() -> void:
	current_stop_index += 1
	encounter_index += 1
	if current_stop_index >= get_num_stops():
		set_phase(PHASES.SUMMARY)

func record_outcome(outcome: Dictionary) -> void:
	outcomes.append(outcome)
	encounter_resolved.emit(outcome)

func reset_session() -> void:
	current_phase = PHASES.TITLE
	current_weather = ""
	current_route = "morning"
	current_stop_index = 0
	encounter_index = 1
	outcomes.clear()
	planned_expectations.clear()
	game_reset.emit()
	print("GameState: session reset")

# ─── Flower fit calculation ────────────────────────────────────────────────────

func get_flower_fit(flower_id: String, weather: String) -> int:
	# Returns 1-3 affinity
	var data := _get_flower_data(flower_id)
	if data.is_empty():
		return 2  # neutral
	return data.get(weather, 2)

func _get_flower_data(flower_id: String) -> Dictionary:
	var flowers := {
		"sunflower":     {"sunshine": 3, "rain": 1},
		"lavender":      {"sunshine": 1, "rain": 3},
		"wildflower":    {"sunshine": 3, "rain": 1},
		"lily":          {"sunshine": 1, "rain": 3},
		"rose":          {"sunshine": 2, "rain": 2},
		"chrysanthemum": {"sunshine": 2, "rain": 2},
		"freesia":       {"sunshine": 2, "rain": 1},
	}
	return flowers.get(flower_id, {})

func get_fit_label(flower_id: String, weather: String) -> String:
	var fit := get_flower_fit(flower_id, weather)
	match fit:
		3: return "Fits well ✓"
		2: return "Neutral"
		1: return "Doesn't fit ✗"
	return "Neutral"
