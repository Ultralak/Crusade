extends NodeState

@export var characterbody2d : CharacterBody2D
@export var healthcomponent : HealthComponent
@export var node_finite_state_machine : NodeFiniteStateMachine
@export var Navigation_component : Node2D
@export var timer : Timer
@export var time : float = 1.000

@export var friction = 50
var knk_direction : Vector2
var knk_force : float

var is_setup : bool = false

func enter():
	timer.one_shot = true
	timer.wait_time = time
	timer.start()
	
	characterbody2d.velocity = knk_direction * knk_force
	animation_player.play("hit")

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	characterbody2d.velocity = characterbody2d.velocity.move_toward(Vector2.ZERO,friction * delta)
	characterbody2d.move_and_slide()
	
func exit():
	pass

func set_knockback(direction : Vector2, force : float):
	knk_direction = direction
	knk_force = force
	is_setup = true
	print("hurt state : is_setup = true")

func _on_hurt_timer_timeout() -> void:
	is_setup = false
	print("hurt state : is_setup = false")
	node_finite_state_machine.transition_to("idle")
	
	#if healthcomponent.health <= 0:
		#node_finite_state_machine.transition_to("dead")
	#else:
		#node_finite_state_machine.transition_to("chase")
