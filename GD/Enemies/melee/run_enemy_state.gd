extends NodeState

@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D
@export var acceleration : float = 400
@export var speed : float = 500
@export var state_machine_controller: Node


var player_pos : Vector2
var direction : int 


func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	if state_machine_controller.is_dead:
		return
	player_pos = PlayerManager.get_player_position()
	
	characterbody2d.velocity.x = move_toward(characterbody2d.velocity.x, speed * direction , delta * acceleration)
	characterbody2d.move_and_slide()
	
	direction = 1 if player_pos.x > characterbody2d.global_position.x else -1
	animatedsprite2d.flip_h = player_pos.x > characterbody2d.global_position.x


func enter():
	animatedsprite2d.play("run")
	player_pos = PlayerManager.get_player_position()
	direction = 1 if player_pos.x > characterbody2d.global_position.x else -1

func exit():
	animatedsprite2d.stop()


# enemy runs 
# when player enters hitbox the enemy transitions to attack
