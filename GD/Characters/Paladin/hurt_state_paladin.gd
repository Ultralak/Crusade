extends NodeState

@export var player : CharacterBody2D
@export var FSM : NodeFiniteStateMachine
@export var friction : float = 50
@export var hurt_time : float = 0.2

var knk_direction : Vector2
var  knk_force : float
var is_setup  : bool = false
@export var hurt_timer : Timer
func enter():
	
	
	if is_setup:
		player.velocity = knk_direction * knk_force
		player.can_turn = false
		animation_player.play("hurt")
		
		hurt_timer.one_shot = true
		hurt_timer.wait_time = hurt_time
		hurt_timer.start()
		
	else:
		print("knockback not received")
		
func exit():
	is_setup = false
	player.can_turn = true
	animation_player.stop()
	
	
func on_physics_process(_delta: float) -> void:
	player.velocity.move_toward(Vector2.ZERO, friction )
	player.move_and_slide()

func set_knockback(direction : Vector2, force : float) -> void:
	knk_direction = direction
	knk_force = force
	is_setup = true
	#print(" Force : %s Direction : %s" % [knk_force,knk_direction])


func _on_hurt_timer_timeout() -> void:
	FSM.transition_to("idle")
	
