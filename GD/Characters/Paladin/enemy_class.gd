extends Character
class_name Enemy
signal enemy_killed(body : CharacterBody2D)
@export var damage_amount : float  = 4
@export var max_health : float  = 10.0
@export var debug_text_enabled : bool
@export var debug_text : Label

func _ready() -> void:
	debug_text.visible = debug_text_enabled

func emit_is_dead()->void:
	enemy_killed.emit(self)
