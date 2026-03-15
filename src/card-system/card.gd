class_name Card
extends Resource

enum CardType { ATTACK, DEFENSE, EMOTION }
enum EmotionType { JOY, SADNESS, ANGER, FEAR, LOVE, CONFUSION }

@export var id: String
@export var name: String
@export var description: String
@export var card_type: CardType
@export var emotion_type: EmotionType
@export var cost: int = 1
@export var value: int = 0
@export var art_path: String

func _init(p_id: String = "", p_name: String = "", p_description: String = ""):
	id = p_id
	name = p_name
	_description = p_description
