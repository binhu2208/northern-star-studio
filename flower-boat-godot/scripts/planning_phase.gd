## Planning Phase Screen
## Player selects flowers for each stop before sailing

extends CanvasLayer

const FLOWER_IDS = ["sunflower", "lavender", "wildflower", "lily", "rose", "chrysanthemum", "freesia"]

func _ready() -> void:
    $VBox/ConfirmBtn.pressed.connect(_on_confirm)
    $VBox/BackButton.pressed.connect(_on_back)
    
    # Populate flower dropdowns
    var flowers = Inventory.get_flower_list()
    _populate_dropdown($VBox/StopsContainer/Stop1Row/Stop1Flower, flowers)
    _populate_dropdown($VBox/StopsContainer/Stop2Row/Stop2Flower, flowers)
    _populate_dropdown($VBox/StopsContainer/Stop3Row/Stop3Flower, flowers)
    _populate_dropdown($VBox/StopsContainer/Stop4Row/Stop4Flower, flowers)

func _populate_dropdown(dropdown: OptionButton, items: Array) -> void:
    dropdown.clear()
    for item in items:
        dropdown.add_item(item)

func _on_confirm() -> void:
    # Record flower selections
    GameState.planned_expectations[1] = $VBox/StopsContainer/Stop1Row/Stop1Flower.text
    GameState.planned_expectations[2] = $VBox/StopsContainer/Stop2Row/Stop2Flower.text
    GameState.planned_expectations[3] = $VBox/StopsContainer/Stop3Row/Stop3Flower.text
    GameState.planned_expectations[4] = $VBox/StopsContainer/Stop4Row/Stop4Flower.text
    
    # Transition to sailing / canal scene
    get_tree().change_scene_to_file("res://scenes/world/canal.tscn")
    GameState.set_phase("sailing")

func _on_back() -> void:
    get_tree().change_scene_to_file("res://scenes/ui/route_map.tscn")
    GameState.set_phase("route_map")
