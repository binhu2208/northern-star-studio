## Weather Select Screen
## Player picks weather for the day — affects flower affinity

extends CanvasLayer

func _ready() -> void:
    $VBox/WeatherRow1/SunshineBtn.pressed.connect(_on_sunshine)
    $VBox/WeatherRow2/RainBtn.pressed.connect(_on_rain)
    $VBox/WeatherRow2/FogBtn.pressed.connect(_on_fog)
    $VBox/WeatherRow3/GoldenBtn.pressed.connect(_on_golden)
    $VBox/BackButton.pressed.connect(_on_back)

func _on_sunshine() -> void:
    GameState.set_weather("sunshine")
    get_tree().change_scene_to_file("res://scenes/ui/route_map.tscn")
    GameState.set_phase("route_map")

func _on_rain() -> void:
    GameState.set_weather("rain")
    get_tree().change_scene_to_file("res://scenes/ui/route_map.tscn")
    GameState.set_phase("route_map")

func _on_fog() -> void:
    GameState.set_weather("fog")
    get_tree().change_scene_to_file("res://scenes/ui/route_map.tscn")
    GameState.set_phase("route_map")

func _on_golden() -> void:
    GameState.set_weather("golden_hour")
    get_tree().change_scene_to_file("res://scenes/ui/route_map.tscn")
    GameState.set_phase("route_map")

func _on_back() -> void:
    get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
    GameState.set_phase("title")
