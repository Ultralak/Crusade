extends NodeState


@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var Jump_node : NodeState
@export var hurt_timer : float = 0.5

@export var knock_back : float = 800
@export var friction : float = 200
var enemy_attacking_player : AnimatedSprite2D  = null
var direction : int
func on_physics_process(_delta : float):
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x , 0 , friction)
	character_body_2d.move_and_slide()
func enter():
	enemy_attacking_player = EnemyManager.attacking_player
	if enemy_attacking_player:
		direction = 1 if enemy_attacking_player.flip_h else -1
	else:
		direction = 1 if animated_sprite_2d.flip_h else -1
		
	character_body_2d.velocity.x += knock_back * direction
	animated_sprite_2d.play("hurt")
	
	await get_tree().create_timer(hurt_timer).timeout
	transition.emit("idle")

	
	
