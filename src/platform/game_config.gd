class_name GameConfig
extends Resource

## Centralized gameplay and input configuration.
##
## This is intentionally lightweight: it keeps platform-sensitive values
## and semantic action names out of gameplay scripts so future ports can
## swap bindings or tune behavior in one place.

@export var starting_hand_size: int = 5
@export var max_turns_per_round: int = 10
@export var time_limit_seconds: int = 60

@export var action_confirm: StringName = &"ui_accept"
@export var action_cancel: StringName = &"ui_cancel"
@export var action_pause: StringName = &"ui_focus_next"

## Lightweight hotfix scaffolding.
## These dictionaries are intentionally generic so small launch-week fixes can
## ship as config/resource changes instead of deeper code edits.
@export var feature_toggles: Dictionary = {}
@export var card_overrides: Dictionary = {}
@export var damage_overrides: Dictionary = {}

func is_feature_enabled(feature_name: String, default_value: bool = true) -> bool:
	return bool(feature_toggles.get(feature_name, default_value))

func get_card_override(card_id: String) -> Dictionary:
	var override_value = card_overrides.get(card_id, {})
	if override_value is Dictionary:
		return override_value
	return {}

func get_damage_override(key: String) -> Dictionary:
	var override_value = damage_overrides.get(key, {})
	if override_value is Dictionary:
		return override_value
	return {}

static func create_default() -> GameConfig:
	return GameConfig.new()
