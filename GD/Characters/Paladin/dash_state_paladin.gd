extends NodeState

@export var player : CharacterBody2D
@export var velocity_component : VelocityComponent
@export var FSM : NodeFiniteStateMachine
@export var FRICTION : float = 0.01
@export var Dash_Effect : CPUParticles2D


var dash_time : float
var dash_direction : Vector2
var dash_speed : float
var timer : Timer

@onready var player_hurtbox: Area2D = $"../../player_hurtbox"

func enter():
	
	animation_player.play("dash")
	
	player_hurtbox.set_collision_layer_value(4,false)
	# HACK : May remove dashing when stationary
	
	
	if velocity_component.move_direction.length() != 0:
		dash_direction = velocity_component.move_direction
	else:
		dash_direction = player.mouse_direction
	
	dash_speed = player.dash_speed 
	dash_time = player.dashTime
	player.velocity = dash_direction * dash_speed
	
	timer_setup()
	
	if dash_direction.x >= 0:
		Dash_Effect.scale.x = -1
	else:
		Dash_Effect.scale.x = 1
	Dash_Effect.restart()
	Dash_Effect.emitting = true
	
func on_timer_timeout()->void:
	FSM.transition_to("idle")
	
func exit():
	Dash_Effect.emitting = false
	
	player_hurtbox.set_collision_layer_value(4,true)
	
	player.velocity = Vector2.ZERO
	
	animation_player.stop()

func on_physics_process(_delta : float):
	if !timer.is_stopped() and timer.time_left > timer.wait_time/2:
		player.velocity = dash_direction * dash_speed
	else:
		player.velocity.move_toward(Vector2.ZERO,FRICTION)
	player.move_and_slide()

func timer_setup()->void:
	timer  = Timer.new()
	timer.wait_time = dash_time
	timer.one_shot = true
	timer.timeout.connect(on_timer_timeout)
	add_child(timer)
	timer.start()
	
