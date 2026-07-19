extends NodeState

@export var player : CharacterBody2D
@export var friction : float = 50
var knk_direction : Vector2
var  knk_force : float
var is_setup  : bool = false

func enter():
	
	if is_setup:
		player.velocity = knk_direction * knk_force
		player.can_turn = false
	else:
		print("knockback not received")
		
func exit():
	is_setup = false
	player.can_turn = true
	
	
func on_physics_process(_delta: float) -> void:
	player.velocity.move_toward(Vector2.ZERO, friction)
	player.move_and_slide()

func set_knockback(direction : Vector2, force : float) -> void:
	knk_direction = direction
	knk_force = force
	is_setup = true
