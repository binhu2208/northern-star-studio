## Water Shimmer
## Animated water surface for the canal
## 4-frame shimmer cycle matching cozy unhurried aesthetic

class_name WaterShimmer
extends Node2D

@export var weather: String = "sunshine"

var frames_sunny = [
    Color("#8FA8A8"), Color("#95B0B0"), Color("#8A9FA0"), Color("#90AAA8")
]
var frames_rain = [
    Color("#708090"), Color("#758595"), Color("#6B808A"), Color("#748898")
]
var frames_golden = [
    Color("#C8A860"), Color("#D0B070"), Color("#C5A065"), Color("#CDA975")
]
var frames_fog = [
    Color("#A8A8A8"), Color("#B0B0B0"), Color("#A5A5A5"), Color("#AAAAAA")
]

var current_frame := 0
var frame_timer := 0.0
var frame_duration := 0.6  # slow, gentle — matches cozy unhurried feel

func _ready() -> void:
    set_weather(weather)

func _process(delta: float) -> void:
    frame_timer += delta
    if frame_timer >= frame_duration:
        frame_timer = 0.0
        current_frame = (current_frame + 1) % 4
        update_water_color()

func set_weather(w: String) -> void:
    weather = w
    current_frame = 0
    frame_timer = 0.0
    update_water_color()

func update_water_color() -> void:
    var palette: Array
    match weather:
        "sunshine":  palette = frames_sunny
        "rain":       palette = frames_rain
        "golden":     palette = frames_golden
        "fog":        palette = frames_fog
        _:            palette = frames_sunny
    
    if current_frame < palette.size():
        modulate = palette[current_frame]
