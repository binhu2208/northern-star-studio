## Route Map Screen
## Shows 4 stops, transitions to planning phase

extends CanvasLayer

func _ready() -> void:
    $VBox/SailBtn.pressed.connect(_on_sail)
    $VBox/BackButton.pressed.connect(_on_back)
    
    # Update weather label with current weather
    var weather = GameState.get_weather()
    $VBox/TitleLabel.text = "%s Route" % weather.capitalize()

func _on_sail() -> void:
    get_tree().change_scene_to_file("res://scenes/ui/planning_phase.tscn")
    GameState.set_phase("planning")

func _on_back() -> void:
    get_tree().change_scene_to_file("res://scenes/ui/weather_select.tscn")
    GameState.set_phase("weather_select")
