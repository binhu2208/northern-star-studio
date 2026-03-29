## Canal Controller
## Handles the sailing phase: boat movement, dock approach, customer encounters
## Part of canal.tscn

class_name CanalController
extends Node2D

signal dock_reached(dock_index: int)
signal encounter_started(dock_index: int)

@export var current_dock: int = 0

func _ready() -> void:
    # Set initial sky based on weather
    _update_sky_for_weather()

func _update_sky_for_weather() -> void:
    var weather = GameState.current_weather
    var sky_map = {
        "sunshine": "res://sprites/environment/sky_sunny.png",
        "rain": "res://sprites/environment/sky_rain.png",
        "fog": "res://sprites/environment/sky_fog.png",
        "golden_hour": "res://sprites/environment/sky_golden.png",
    }
    var sky_path = sky_map.get(weather, sky_map["sunshine"])
    $SkyLayer.texture = load(sky_path)
    $WaterShimmer.set_weather(weather)

func start_next_encounter() -> void:
    var stop = GameState.get_current_stop()
    encounter_started.emit(stop)
    var customer = $EncounterSystem.start_encounter(stop)
    # Show customer sprite
    $CustomerSpawn.visible = true
    # Transition to encounter UI
    get_tree().change_scene_to_file("res://scenes/ui/encounter.tscn")

func _on_boat_dock_reached(dock_idx: int) -> void:
    current_dock = dock_idx
    dock_reached.emit(dock_idx)
    # Small delay then start encounter
    await get_tree().create_timer(0.5).timeout
    start_next_encounter()
