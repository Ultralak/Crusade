extends NodeState

@export_category("Hurt shooter state")


@export var state_machine_enemy: NodeFiniteStateMachine
@export var test_enemy: CharacterBody2D 


var hurt_time : float 
var dash_speed : float 
var dash_friction : float

var main_player : CharacterBody2D = null
var player_pos : float
var direction : int 

func enter():
	main_player = PlayerManager.player
	if !main_player:
		return
		
		
	dash_friction = main_player.dash_friction
	dash_speed = main_player.dash_speed
	hurt_time = main_player.hurt_time
	player_pos = PlayerManager.get_player_position().x
	direction = 1 if player_pos < test_enemy.global_position.x else -1
	
	test_enemy.velocity.x  += direction * dash_speed
	
	animation_player.play("hit_flash")
	
	await get_tree().create_timer(hurt_time).timeout
	
	state_machine_enemy.transition_to("idle")
	
	

func on_physics_process(_delta : float):
	test_enemy.velocity.x = move_toward(test_enemy.velocity.x , 0 , dash_friction)
	test_enemy.move_and_slide()

func exit():
	animation_player.stop()
	
	
