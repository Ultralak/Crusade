@icon("res://Art/enemies/goblin/goblin_idle_anim_f0.png")
extends Enemy
@export_category("Goblin variables")

var player : CharacterBody2D
@export var sprite : AnimatedSprite2D
func _ready() -> void:
	player = PlayerManager.player
	
func _process(_delta: float) -> void:
	var direction_to_player : Vector2 = global_position.direction_to(player.global_position)
	if direction_to_player.x >= 0:
		sprite.flip_h = false
	if direction_to_player.x < 0:
		sprite.flip_h = true
