extends NodeState

@export var animated_sprite_2d: AnimatedSprite2D 
@export var hurt_time : float = 0.2
@export var dash_speed : float = 1000
@export var dash_friction : float = 200
@export var state_machine_enemy: NodeFiniteStateMachine
@export var test_enemy: CharacterBody2D 
@export var hit_flash_anim: AnimationPlayer 


var player_pos : float
var direction : int 
func enter():
	player_pos = PlayerManager.get_player_position().x
	direction = 1 if player_pos < test_enemy.global_position.x else -1
	
	test_enemy.velocity.x  += direction * dash_speed
	animated_sprite_2d.play("idle")
	hit_flash_anim.play("hit")
	
	await get_tree().create_timer(hurt_time).timeout
	
	state_machine_enemy.transition_to("idle")

func on_physics_process(_delta : float):
	test_enemy.velocity.x = move_toward(test_enemy.velocity.x , 0 , dash_friction)
	test_enemy.move_and_slide()
