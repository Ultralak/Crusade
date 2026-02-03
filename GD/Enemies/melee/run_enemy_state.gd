extends NodeState

@export_category("run melee state")
@export var characterbody2d : CharacterBody2D
@export var animation_player : AnimationPlayer

@export var state_machine_controller: Node
@export var sprite_2d : Sprite2D
@export var raycast_floor: RayCast2D
var player_pos : Vector2
var direction : int 
var previous_direction : int
var acceleration : float
var speed : float

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
		
	if state_machine_controller.is_dead:
		return
	player_pos = PlayerManager.get_player_position()
	
	
	if !raycast_floor.is_colliding() :
		characterbody2d.velocity.x = 0
	else:
		characterbody2d.velocity.x = move_toward(characterbody2d.velocity.x, speed * direction , delta * acceleration)
	characterbody2d.move_and_slide()
	direction = 1 if player_pos.x > characterbody2d.global_position.x else -1
	if previous_direction != direction:
		characterbody2d.update_direction()
		previous_direction = direction
	sprite_2d.flip_h = player_pos.x > characterbody2d.global_position.x
	raycast_floor.position.x = abs(raycast_floor.position.x) * direction

func enter():
	previous_direction = characterbody2d.direction
	speed = characterbody2d.speed
	acceleration = characterbody2d.acceleration
	
	animation_player.play("run")
	player_pos = PlayerManager.get_player_position()
	direction = 1 if player_pos.x > characterbody2d.global_position.x else -1
	if previous_direction != direction:
		characterbody2d.update_direction()
		previous_direction = direction
func exit():
	animation_player.stop()


# enemy runs 
# when player enters hitbox the enemy transitions to attack
