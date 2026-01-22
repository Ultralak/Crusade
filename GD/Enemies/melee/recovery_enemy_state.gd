extends NodeState
@export var animated_sprite_2d: AnimatedSprite2D 
@export var recovery_time : float = 1
@export var state_machine_enemy: NodeFiniteStateMachine 
@export var test_enemy: CharacterBody2D 

func enter():
	animated_sprite_2d.play("idle")
	
	await get_tree().create_timer(recovery_time).timeout
	
	state_machine_enemy.transition_to("idle")

func on_physics_process(_delta : float):
	test_enemy.velocity.x = 0
	test_enemy.move_and_slide()
