# Water Shimmer — 4-frame animated water tiles
# Gentle canal water animation, matches cozy unhurried aesthetic
# Frames: 4 slight variations of the water color to create shimmer

extends Node2D

@export var weather: String = "sunshine"

var frames := {
    "sunshine": [Color("#8FA8A8"), Color("#95B0B0"), Color("#8A9FA0"), Color("#90AAA")],
    "rain":    [Color("#708090"), Color("#758595"), Color("#6B808A"), Color("#748898")],
    "golden":  [Color("#C8A860"), Color("#D0B070"), Color("#C5A065"), Color("#CDA975")],
}

var current_frame := 0
var frame_timer := 0.0
var frame_duration := 0.6  # seconds per frame — slow, gentle

func _ready() -> void:
    modulate = frames.get(weather, frames["sunshine"])[0]

func _process(delta: float) -> void:
    frame_timer += delta
    if frame_timer >= frame_duration:
        frame_timer = 0.0
        current_frame = (current_frame + 1) % 4
        modulate = frames.get(weather, frames["sunshine"])[current_frame]

func set_weather(w: String) -> void:
    weather = w
    modulate = frames.get(weather, frames["sunshine"])[current_frame]
