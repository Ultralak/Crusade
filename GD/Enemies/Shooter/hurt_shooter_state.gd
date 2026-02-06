extends NodeState

@export_category("Hurt shooter state")

@export var hurt_timer : Timer
@export var state_machine_enemy: NodeFiniteStateMachine
@export var test_enemy: CharacterBody2D 


var hurt_time : float 
var dash_speed : float 
var dash_friction : float

var player : CharacterBody2D = null
var player_pos : float
var direction : int 

func enter():
	player = PlayerManager.player
	if !player:
		return
		
		
	dash_friction = player.dash_friction
	dash_speed = player.dash_speed
	hurt_time = player.hurt_time
	player_pos = PlayerManager.get_player_position().x
	direction = 1 if player_pos < test_enemy.global_position.x else -1
	
	test_enemy.velocity.x  += direction * dash_speed
	
	animation_player.play("hit_flash")
	
	hurt_timer.start(hurt_time)
	
	

func on_physics_process(_delta : float):
	test_enemy.velocity.x = move_toward(test_enemy.velocity.x , 0 , dash_friction)
	test_enemy.move_and_slide()

func exit():
	animation_player.stop()
	
