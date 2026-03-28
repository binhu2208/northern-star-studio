# Flower Boat — State Machine
# Reusable state machine for UI screens and game phases
# Usage: extend and override _enter_state() and _exit_state()

class_name StateMachine
extends Node

signal state_changed(from_state: String, to_state: String)

@export var initial_state: String = ""
var current_state: String = ""
var states: Dictionary = {}  # state_name → State object

func _ready() -> void:
	if initial_state != "":
		set_state(initial_state)

func add_state(name: String, state_node: Node) -> void:
	states[name] = state_node
	add_child(state_node)
	state_node.state_machine = self
	state_node._ready()
	state_node.visible = false

func set_state(name: String) -> void:
	if not states.has(name):
		push_error("StateMachine: unknown state '", name, "'")
		return
	if current_state != "" and states.has(current_state):
		var old := states[current_state]
		old.visible = false
		old._exit_state(name)
	
	var new_state := states[name]
	new_state.visible = true
	var old_state := current_state
	current_state = name
	new_state._enter_state(old_state)
	state_changed.emit(old_state, name)

func get_state() -> String:
	return current_state

# ─── Base State ───────────────────────────────────────────────────────────────

class State:
	var state_machine: StateMachine
	
	func _ready() -> void:
		pass  # Override in subclass
	
	func _enter_state(_from: String) -> void:
		pass  # Override in subclass
	
	func _exit_state(_to: String) -> void:
		pass  # Override in subclass
	
	func _process(_delta: float) -> void:
		pass
	
	func _physics_process(_delta: float) -> void:
		pass
	
	func _input(_event: InputEvent) -> void:
		pass
