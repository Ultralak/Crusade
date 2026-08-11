
@icon("uid://dior6ofoq1cca")
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
@export var player_acceptable_distance : float = 100
@export var show_debug_code : bool  = false
var target : CharacterBody2D 
var setup : bool = false
var cooldown_attack_timer : float = randf_range(2,3.5)
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	cooldown_attack_timer -= _delta
	if !setup : 
		if PlayerManager.player and Navigation_component.target :
			target = PlayerManager.player
			node_finite_state_machine.transition_to("chase")
			target_desired_distance = Navigationagent2d.target_desired_distance
			setup = true
	
	match node_finite_state_machine.current_node_state_name:
		"chase":
			if cooldown_attack_timer<= 0:
				if player_is_still() and close_to_player(player_acceptable_distance):
					if !timer.is_stopped():
						timer.stop()
					node_finite_state_machine.transition_to("prepare")
					
			if (!player_is_still() or !close_to_player(target_desired_distance)) and !timer.is_stopped():
				timer.stop()
				if show_debug_code:
					print("%s : One or more conditions failed . Potentital attack timer stopped" % [get_parent().name])
	if cooldown_attack_timer <= 0:
		cooldown_attack_timer = randf_range(0.5,1.5)
func _on_navigation_agent_2d_target_reached() -> void:
	timer.wait_time = potential_to_wait_time
	timer.one_shot = true
	if timer.is_stopped():
		timer.start()
		if show_debug_code:
			print("%s : Potential attack timer started" % [get_parent().name])
	
	 
	# when player reached. start timer and if player doesn't move within a certain treshold
	# enter into attack state.
	# if the player moves stop timer and restarts once you reach player again


func player_is_still() -> bool:
	if target:
		return target.velocity.length() <= player_still_velocity
	return true
		
func close_to_player(accepted_distance : float) -> bool: 
	if target:
		return enemy.global_position.distance_to(target.global_position) <= accepted_distance
	return false

func _on_potential_to_attack_timer_timeout() -> void:
	if show_debug_code:
		print("%s : potential attack timer timed out so conditions met" % [get_parent().name])
	if node_finite_state_machine.current_node_state_name == "chase":
		node_finite_state_machine.transition_to("prepare")
		
