# Flower Boat — Encounter System
# Manages customer encounters: spawn, dialogue, flower suggestion, outcome

extends Node

var game_state: Node
var inventory: Node
var dialogue: Node

var current_customer: Dictionary = {}
var current_stop: int = 0

# Customer definitions — weather → customer pool
var CUSTOMERS := {
	"sunshine": [
		{"id": "hurry",      "name": "The Hurry",      "fit_flower": "sunflower"},
		{"id": "gather",     "name": "The Gatherer",   "fit_flower": "sunflower"},
		{"id": "observer",    "name": "The Observer",    "fit_flower": "lily"},
		{"id": "student",    "name": "The Student",    "fit_flower": "lavender"},
	],
	"rain": [
		{"id": "griever",    "name": "The Griever",    "fit_flower": "lavender"},
		{"id": "dreamer",    "name": "The Dreamer",    "fit_flower": "lily"},
		{"id": "worker",     "name": "The Worker",     "fit_flower": "chrysanthemum"},
		{"id": "drifter",    "name": "The Drifter",    "fit_flower": "freesia"},
	],
}

var STOP_NAMES := {
	"morning": ["Canal Corner", "Market Bridge", "Garden Lock", "Old Pier"],
	"afternoon": ["Market Dock", "Garden Gate", "Old Bridge", "Cafe Dock"],
	"evening": ["Garden Gate", "Quiet Pier", "Old Bridge", "Corner House"],
}

func _ready() -> void:
	game_state = get_node("/root/game_state")
	inventory = get_node("/root/inventory")
	dialogue = get_node("/root/dialogue_bus")

func start_encounter(stop_index: int) -> Dictionary:
	current_stop = stop_index
	var weather := game_state.current_weather
	var customer_pool: Array = CUSTOMERS.get(weather, CUSTOMERS["sunshine"])
	var customer: Dictionary = customer_pool[stop_index % customer_pool.size()].duplicate()
	customer["stop_name"] = _get_stop_name(stop_index)
	current_customer = customer
	return customer

func _get_stop_name(idx: int) -> String:
	var route := game_state.current_route
	var names: Array = STOP_NAMES.get(route, STOP_NAMES["morning"])
	return names[idx % names.size()]

func suggest_flower(flower_id: String) -> Dictionary:
	var weather := game_state.current_weather
	var fit := game_state.get_flower_fit(flower_id, weather)
	var customer := current_customer
	
	var outcome := {
		"stop": current_stop,
		"customer_id": customer.get("id", ""),
		"stop_name": customer.get("stop_name", ""),
		"suggested": flower_id,
		"fit": fit,
		"correct": flower_id == customer.get("fit_flower", ""),
	}
	
	game_state.record_outcome(outcome)
	return outcome

func get_reaction_text(outcome: Dictionary) -> String:
	var fit: int = outcome.get("fit", 2)
	var correct: bool = outcome.get("correct", false)
	var customer_name: String = current_customer.get("name", "them")
	
	if correct:
		return _get_reaction_right(customer_name)
	match fit:
		3: return _get_reaction_fit_good(customer_name)
		2: return _get_reaction_fit_neutral(customer_name)
		1: return _get_reaction_fit_poor(customer_name)
	return _get_reaction_fit_neutral(customer_name)

func _get_reaction_right(name: String) -> String:
	var reactions := {
		"The Hurry": "Warmth — they brighten immediately. \"This is perfect.\"",
		"The Gatherer": "Joy — they clap their hands. \"This is exactly what I needed.\"",
		"The Observer": "Quiet — they smile gently. \"How did you know?\"",
		"The Student": "Focus — they settle. \"Thank you. This helps.\"",
		"The Griever": "Renewal — they pause. \"Thank you. That was enough.\"",
		"The Dreamer": "Nostalgia — they sigh. \"Yes. This is it.\"",
		"The Worker": "Ease — they breathe. \"Finally. Thank you.\"",
		"The Drifter": "Surprise — they laugh. \"How did you know?\"",
	}
	return reactions.get(name, "They accept it quietly. \"Thank you.\"")

func _get_reaction_fit_good(name: String) -> String:
	return "They take it with a smile. \"This works. Thank you.\""

func _get_reaction_fit_neutral(name: String) -> String:
	return "They accept it politely. \"Thanks.\" A beat too fast."

func _get_reaction_fit_poor(name: String) -> String:
	return "Something doesn\'t land. They nod, but their hands stay still."
