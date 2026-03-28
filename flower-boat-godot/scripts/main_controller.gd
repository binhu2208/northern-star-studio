# Flower Boat — Main Controller
# Entry point for the game scene
# Wires together the UI layer and game state

extends Node2D

var game_state: Node
var inventory: Node
var dialogue: Node

@onready var ui_layer: CanvasLayer = $UI

var current_screen: Node = null

func _ready() -> void:
	game_state = get_node("/root/game_state")
	inventory = get_node("/root/inventory")
	dialogue = get_node("/root/dialogue_bus")
	
	# Wire up game state signals
	game_state.phase_changed.connect(_on_phase_changed)
	game_state.game_reset.connect(_on_game_reset)
	
	# Wire up dialogue bus signals
	dialogue.ui_weather_selected.connect(_on_weather_selected)
	dialogue.ui_stock_confirmed.connect(_on_stock_confirmed)
	dialogue.ui_flower_toggled.connect(_on_flower_toggled)
	dialogue.ui_route_selected.connect(_on_route_selected)
	dialogue.ui_expectation_set.connect(_on_expectation_set)
	dialogue.ui_flower_suggested.connect(_on_flower_suggested)
	dialogue.ui_next_stop_requested.connect(_on_next_stop)
	dialogue.ui_new_game_requested.connect(_on_new_game)
	
	print("Main: system ready")
	_show_screen("title")

func _on_phase_changed(phase: String) -> void:
	match phase:
		"title": _show_screen("title")
		"weather_select": _show_screen("weather_select")
		"route_map": _show_screen("route_map")
		"stock_select": _show_screen("stock_select")
		"planning": _show_screen("planning")
		"encounter": _show_screen("encounter")
		"summary": _show_screen("summary")

func _show_screen(screen_name: String) -> void:
	if current_screen:
		current_screen.queue_free()
		current_screen = null
	
	# Map phase/screen names to scene files
	var scene_map: Dictionary = {
		"title": "title_screen",
		"weather_select": "weather_select",
		"route_map": "route_map",
		"stock_select": "stock_select",
		"planning": "planning_phase",
		"encounter": "encounter",
		"summary": "summary",
	}
	var resolved_name: String = scene_map.get(screen_name, screen_name)
	var scene_path: String = "res://scenes/ui/" + resolved_name + ".tscn"
	if ResourceLoader.exists(scene_path):
		var new_screen = load(scene_path).instantiate()
		ui_layer.add_child(new_screen)
		current_screen = new_screen
	else:
		print("Main: scene not found: ", scene_path)

# ─── Dialogue bus handlers ────────────────────────────────────────────────────

func _on_weather_selected(weather: String) -> void:
	game_state.set_weather(weather)
	game_state.set_phase("route_map")

func _on_route_selected(route: String) -> void:
	game_state.current_route = route
	game_state.set_phase("stock_select")

func _on_flower_toggled(flower_id: String) -> void:
	inventory.toggle_flower(flower_id)

func _on_stock_confirmed() -> void:
	if inventory.confirm_stock():
		game_state.set_phase("planning")

func _on_expectation_set(stop_id: String, customer_id: String) -> void:
	game_state.planned_expectations[stop_id] = customer_id

func _on_flower_suggested(flower_id: String) -> void:
	var encounter := get_node_or_null("/root/encounter_system")
	if encounter:
		var outcome = encounter.suggest_flower(flower_id)

func _on_next_stop() -> void:
	game_state.next_stop()
	if game_state.current_phase != "summary":
		game_state.set_phase("encounter")

func _on_game_reset() -> void:
	inventory.clear_stock()
	_show_screen("title")

func _on_new_game() -> void:
	game_state.reset_session()
