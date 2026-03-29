## Summary Screen
## Shows journey outcomes, allows replay or return to menu

extends CanvasLayer

func _ready() -> void:
    $VBox/Btns/AgainBtn.pressed.connect(_on_again)
    $VBox/Btns/MenuBtn.pressed.connect(_on_menu)
    
    # Populate outcomes from GameState
    _populate_outcomes()

func _populate_outcomes() -> void:
    var outcomes = GameState.outcomes
    for outcome in outcomes:
        var label = Label.new()
        label.text = "Stop %d: %s" % [outcome.get("stop", 0), outcome.get("result", "—")]
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        $VBox/OutcomesList.add_child(label)

func _on_again() -> void:
    GameState.reset_session()
    get_tree().change_scene_to_file("res://scenes/ui/weather_select.tscn")
    GameState.set_phase("weather_select")

func _on_menu() -> void:
    GameState.reset_session()
    get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
    GameState.set_phase("title")
