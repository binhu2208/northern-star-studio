## Boat Controller
## Handles player-controlled boat movement along the canal
## Smooth easing between dock positions

class_name Boat
extends Node2D

signal dock_reached(dock_index: int)
signal moving_changed(is_moving: bool)

enum State { IDLE, MOVING }

@export var dock_positions: Array[Vector2] = [
    Vector2(400, 400),  # Dock 1
    Vector2(600, 400),  # Dock 2
    Vector2(800, 400),  # Dock 3
    Vector2(1000, 400), # Dock 4
]
@export var move_speed: float = 200.0  # pixels per second
@export var ease_duration: float = 0.8  # seconds for smooth ease

var current_dock: int = 0
var state: State = State.IDLE
var target_position: Vector2
var move_progress: float = 0.0

func _ready() -> void:
    global_position = dock_positions[current_dock]
    state = State.IDLE

func move_to_dock(dock_index: int) -> void:
    if dock_index < 0 or dock_index >= dock_positions.size():
        return
    if dock_index == current_dock:
        return
    if state == State.MOVING:
        return
    
    target_position = dock_positions[dock_index]
    state = State.MOVING
    move_progress = 0.0
    moving_changed.emit(true)

func _process(delta: float) -> void:
    if state == State.MOVING:
        move_progress += delta / ease_duration
        
        if move_progress >= 1.0:
            move_progress = 1.0
            global_position = target_position
            # Find which dock we reached
            for i in range(dock_positions.size()):
                if dock_positions[i] == target_position:
                    current_dock = i
                    break
            state = State.IDLE
            moving_changed.emit(false)
            dock_reached.emit(current_dock)
        else:
            # Smooth ease (ease-in-out)
            var t = ease(move_progress, 1.5)
            var start_pos = dock_positions[current_dock]
            global_position = start_pos.lerp(target_position, t)

func get_current_dock() -> int:
    return current_dock

func get_state() -> State:
    return state
