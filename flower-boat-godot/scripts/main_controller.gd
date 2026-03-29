## Main Controller
## Root-level game orchestrator
## Manages scene transitions and game flow using GameState autoload

class_name MainController
extends Node2D

@export var current_state: int = 0

func _ready() -> void:
    # Initialize — start at title screen
    get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")

func transition_to_scene(scene_path: String) -> void:
    get_tree().change_scene_to_file(scene_path)

# ─── Scene navigation helpers ──────────────────────────────────────────────────
# These are called by UI buttons and game events

func go_to_weather_select() -> void:
    transition_to_scene("res://scenes/ui/weather_select.tscn")
    GameState.set_phase("weather_select")

func go_to_route_map() -> void:
    transition_to_scene("res://scenes/ui/route_map.tscn")
    GameState.set_phase("route_map")

func go_to_planning() -> void:
    transition_to_scene("res://scenes/ui/planning_phase.tscn")
    GameState.set_phase("planning")

func go_to_sailing() -> void:
    transition_to_scene("res://scenes/world/canal.tscn")
    GameState.set_phase("sailing")

func go_to_encounter() -> void:
    transition_to_scene("res://scenes/ui/encounter.tscn")
    GameState.set_phase("encounter")

func go_to_summary() -> void:
    transition_to_scene("res://scenes/ui/summary.tscn")
    GameState.set_phase("summary")

func go_to_title() -> void:
    transition_to_scene("res://scenes/ui/title_screen.tscn")
    GameState.set_phase("title")
    GameState.reset_session()

func handle_back() -> void:
    match GameState.current_phase:
        "weather_select":  go_to_title()
        "route_map":      go_to_weather_select()
        "planning":       go_to_route_map()
        "sailing":        go_to_planning()
