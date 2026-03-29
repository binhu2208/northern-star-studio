## Encounter UI Controller
## Handles customer encounter interactions
## Shows customer, flower cards, records outcome

extends CanvasLayer

var encounter_system: Node
var customer_data: Dictionary = {}
var outcome_recorded: bool = false

func _ready() -> void:
    encounter_system = get_node("/root/encounter_system")
    
    # Set background sky based on weather
    var weather = GameState.current_weather
    var sky_map = {
        "sunshine": "res://sprites/environment/sky_sunny.png",
        "rain": "res://sprites/environment/sky_rain.png",
        "fog": "res://sprites/environment/sky_fog.png",
        "golden_hour": "res://sprites/environment/sky_golden.png",
    }
    var sky_path = sky_map.get(weather, sky_map["sunshine"])
    $Background.texture = load(sky_path)
    
    # Start encounter
    var stop = GameState.get_current_stop()
    customer_data = encounter_system.start_encounter(stop)
    
    # Update UI with customer info
    $CustomerLabel.text = customer_data.get("name", "Customer")
    
    # Show customer sprite
    var customer_id = customer_data.get("id", "regular")
    var sprite_path = "res://sprites/characters/customer_%s.png" % customer_id
    if ResourceLoader.exists(sprite_path):
        $CustomerSprite.texture = load(sprite_path)
    
    # Setup flower card buttons
    var stock = Inventory.get_stock()
    var card_btns = [$FlowerCards/Card1, $FlowerCards/Card2, $FlowerCards/Card3]
    for i in range(3):
        if i < stock.size() and stock[i] != "":
            card_btns[i].text = _get_flower_emoji(stock[i])
            card_btns[i].pressed.connect(_on_flower_selected.bind(stock[i]))
        else:
            card_btns[i].disabled = true

func _get_flower_emoji(flower_id: String) -> String:
    var emoji_map = {
        "sunflower": "🌻",
        "lavender": "💜",
        "wildflower": "🌼",
        "lily": "💐",
        "rose": "🌹",
        "chrysanthemum": "🌸",
        "freesia": "🌺",
    }
    return emoji_map.get(flower_id, "❓")

func _on_flower_selected(flower_id: String) -> void:
    if outcome_recorded:
        return
    outcome_recorded = true
    
    # Disable cards
    $FlowerCards/Card1.disabled = true
    $FlowerCards/Card2.disabled = true
    $FlowerCards/Card3.disabled = true
    
    # Calculate outcome
    var outcome = encounter_system.suggest_flower(flower_id)
    var reaction = encounter_system.get_reaction_text(outcome)
    
    # Show reaction
    $ReactionLabel.text = reaction
    $NextBtn.visible = true

func _on_continue_pressed() -> void:
    # Move to next stop or summary
    GameState.next_stop()
    
    if GameState.get_current_stop() >= GameState.get_num_stops():
        # Journey complete
        get_tree().change_scene_to_file("res://scenes/ui/summary.tscn")
        GameState.set_phase("summary")
    else:
        # Next dock
        get_tree().change_scene_to_file("res://scenes/world/canal.tscn")
        GameState.set_phase("sailing")
