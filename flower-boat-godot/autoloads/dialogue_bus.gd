# Flower Boat — Dialogue Bus (Autoload)
# Decoupled event bus for UI ↔ game logic communication
# Keeps scenes independent and testable

extends Node

# ─── UI → Game signals ────────────────────────────────────────────────────────
signal ui_weather_selected(weather: String)
signal ui_flower_toggled(flower_id: String)
signal ui_stock_confirmed()
signal ui_route_selected(route: String)
signal ui_expectation_set(stop_id: String, customer_id: String)
signal ui_flower_suggested(flower_id: String)
signal ui_next_stop_requested()
signal ui_previous_stop_requested()
signal ui_new_game_requested()

# ─── Game → UI signals ────────────────────────────────────────────────────────
signal show_weather_select()
signal show_route_map()
signal show_stock_select()
signal show_planning_phase()
signal show_encounter(stop_index: int, customer_data: Dictionary)
signal show_summary(outcomes: Array)
signal update_stock_display(stock: Array)
signal update_weather_icon(weather: String)
signal play_sound(sfx_name: String)
signal transition_fade(duration: float)
