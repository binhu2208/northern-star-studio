## Weather System
## Manages weather states and transitions for the canal
## 4 weather types: sunshine, rain, fog, golden_hour

class_name WeatherSystem
extends Node2D

signal weather_changed(new_weather: String)

@export var current_weather: String = "sunshine"

var weather_ids = ["sunshine", "rain", "fog", "golden_hour"]

func _ready() -> void:
    pass

func set_weather(w: String) -> void:
    if w not in weather_ids:
        push_warning("Unknown weather type: %s" % w)
        return
    current_weather = w
    weather_changed.emit(w)

func get_weather() -> String:
    return current_weather

func cycle_weather() -> void:
    var idx = weather_ids.find(current_weather)
    idx = (idx + 1) % weather_ids.size()
    set_weather(weather_ids[idx])
