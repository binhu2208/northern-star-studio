# Flower Boat — Inventory (Autoload)
# Manages the 3-slot flower stock

extends Node

signal stock_changed(current_stock: Array)
signal slot_filled(slot_index: int, flower_id: String)
signal slot_cleared(slot_index: int)
signal stock_full()
signal stock_confirmed()

const MAX_SLOTS: int = 3

var slots: Array = ["", "", ""]  # 3 slots, each holds a flower id or ""

func _ready() -> void:
	print("Inventory: initialized with ", MAX_SLOTS, " slots")

func add_flower(flower_id: String) -> bool:
	# Returns true if flower was added, false if stock full or already in
	if slots.has(flower_id):
		return false  # already in stock
	var empty_idx := slots.find("")
	if empty_idx == -1:
		stock_full.emit()
		return false
	slots[empty_idx] = flower_id
	slot_filled.emit(empty_idx, flower_id)
	stock_changed.emit(slots)
	return true

func remove_flower(flower_id: String) -> void:
	var idx := slots.find(flower_id)
	if idx >= 0:
		slots[idx] = ""
		slot_cleared.emit(idx)
		stock_changed.emit(slots)

func toggle_flower(flower_id: String) -> bool:
	if slots.has(flower_id):
		remove_flower(flower_id)
		return false
	return add_flower(flower_id)

func clear_stock() -> void:
	slots = ["", "", ""]
	stock_changed.emit(slots)

func get_stock() -> Array:
	return slots.duplicate()

func is_full() -> bool:
	return slots.has("") == false

func confirm_stock() -> bool:
	# All 3 slots must be filled
	if slots.has(""):
		return false
	stock_confirmed.emit()
	return true

func get_flower_count() -> int:
	return slots.filter(func(s): return s != "").size()
