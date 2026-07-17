extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var enemy : CharacterBody2D
@export var Navigationagent2d : NavigationAgent2D
@export var Navigation_component : Node2D
@export var animation_player : AnimationPlayer
@export var health_component : HealthComponent
@export var timer : Timer
@export var player_still_velocity : float = 20
@export var potential_to_wait_time : float = 0.2
@export var target_desired_distance : float
var target : CharacterBody2D 
var setup : bool = false
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if !setup : 
		target = Navigation_component.target
		target_desired_distance = Navigationagent2d.target_desired_distance
		setup = true
	
	match node_finite_state_machine.current_node_state_name:
		"idle":
			if !player_is_still() or !close_to_player():
				timer.stop()

func _on_navigation_agent_2d_target_reached() -> void:
	timer.wait_time = potential_to_wait_time
	timer.one_shot = true
	timer.start()
	 
	# when player reached. start timer and if player doesn't move within a certain treshold
	# enter into attack state.
	# if the player moves stop timer and restarts once you reach player again


func player_is_still() -> bool:
	return target.velocity.length() <= player_still_velocity
	
func close_to_player() -> bool: 
	return enemy.global_position.distance_to(target.global_position) <= target_desired_distance
	

func _on_potential_to_attack_timer_timeout() -> void:
	if node_finite_state_machine.current_node_state_name == "idle":
		node_finite_state_machine.transition_to("prepare")
		
