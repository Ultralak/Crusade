extends NodeState

@export_category("Hurt melee state")
@export var hurt_time : float = 0.2
var dash_speed : float = 500
var dash_friction : float = 200
@export var state_machine_enemy: NodeFiniteStateMachine
@export var test_enemy: CharacterBody2D 
@export var animation_player : AnimationPlayer


var player_pos : float
var direction : int 
func enter():

	player_pos = PlayerManager.get_player_position().x
	dash_speed = PlayerManager.player.dash_speed
	dash_friction = PlayerManager.player.dash_friction
	direction = 1 if player_pos < test_enemy.global_position.x else -1
	
	test_enemy.velocity.x  += direction * dash_speed
	animation_player.play("hit_flash")
	await get_tree().create_timer(hurt_time).timeout
	
	state_machine_enemy.transition_to("idle")

func on_physics_process(_delta : float):
	test_enemy.velocity.x = move_toward(test_enemy.velocity.x , 0 , dash_friction)
	test_enemy.move_and_slide()
