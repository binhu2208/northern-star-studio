## Customer Controller
## Handles customer spawning, reactions, and departure
## 3 reaction states: idle, happy, disappointed

class_name Customer
extends Node2D

signal reaction_finished
signal customer_left

@export var customer_type: String = "regular"
@export var reaction_duration: float = 1.5

var current_reaction: int = 0  # 0=idle, 1=happy, 2=disappointed
var sprites: Dictionary = {}

func _ready() -> void:
    # Load customer sprite sheet — 192x64 = 3 frames x 64px each
    var sprite_path = "res://sprites/characters/customer_%s.png" % customer_type
    var sprite = $Body
    if ResourceLoader.exists(sprite_path):
        sprite.texture = load(sprite_path)
    else:
        push_warning("Customer sprite not found: %s" % sprite_path)

func spawn_at(position: Vector2) -> void:
    global_position = position
    visible = true
    current_reaction = 0
    play_reaction(0)

func play_reaction(reaction_idx: int) -> void:
    """
    reaction_idx: 0=idle, 1=happy, 2=disappointed
    Each customer sprite sheet has 3 frames side-by-side at 64px each
    """
    current_reaction = reaction_idx
    var frame_offset = reaction_idx * 64
    # Note: In Godot 2D, we'll use AnimationPlayer to cycle frames
    # For now, just show the correct frame region
    $Body.region_rect = Rect2(frame_offset, 0, 64, 64)
    $Body.region_enabled = true

func trigger_happy() -> void:
    play_reaction(1)
    $ReactionFlash.modulate = Color(1.0, 1.0, 0.8, 0.5)
    $ReactionFlash.visible = true
    await get_tree().create_timer(reaction_duration).timeout
    $ReactionFlash.visible = false
    reaction_finished.emit()

func trigger_disappointed() -> void:
    play_reaction(2)
    $ReactionFlash.modulate = Color(0.7, 0.7, 0.8, 0.5)
    $ReactionFlash.visible = true
    await get_tree().create_timer(reaction_duration).timeout
    $ReactionFlash.visible = false
    reaction_finished.emit()

func leave() -> void:
    visible = false
    customer_left.emit()
