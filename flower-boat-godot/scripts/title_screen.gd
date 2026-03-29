## Title Screen Controller
## Handles start/quit buttons and transitions

extends CanvasLayer

func _ready() -> void:
    $CenterContainer/VBox/StartButton.pressed.connect(_on_start_pressed)
    $CenterContainer/VBox/QuitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
    GameState.reset_session()
    get_tree().change_scene_to_file("res://scenes/ui/weather_select.tscn")
    GameState.set_phase("weather_select")

func _on_quit_pressed() -> void:
    get_tree().quit()
