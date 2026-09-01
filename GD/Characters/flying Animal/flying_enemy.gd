@icon("res://Art/enemies/flying creature/fly_anim_f3.png")
extends Enemy

@export_category("Flying Enemy variables")
@export var detection_radius : float = 50
@export var max_chase_distance : float = 1000
var knockback_dir : Vector2
@export var knockback_force : float
@export var sprite_animated : AnimatedSprite2D
var player : Paladin 

func _ready() -> void:
	player = PlayerManager.player
	
func _process(_delta: float) -> void:
	var direction_to_player = global_position.direction_to(player.global_position)
	if player:
		if direction_to_player.x > 0:
			sprite_animated.flip_h = false

		if direction_to_player.x < 0:
			sprite_animated.flip_h = true





	
