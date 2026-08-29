@icon("uid://dior6ofoq1cca")
extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var enemy : CharacterBody2D
@export var Navigationagent2d : NavigationAgent2D
@export var Navigation_component : Node2D
@export var animation_player : AnimationPlayer
@export var health_component : HealthComponent
@export var timer : Timer
@export var line_2d : Line2D
@export var player_still_velocity : float = 20
@export var potential_to_wait_time : float = 0.2
@export var target_desired_distance : float
@export var player_acceptable_distance : float = 100
@export_flags_2d_physics var line_of_sight_mask : int = 1
@export var show_debug_code : bool = false

var target : Paladin 
var setup : bool = false
var cooldown_attack_timer : float = randf_range(2,3.5)


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	cooldown_attack_timer -= _delta
	if !setup: 
		if PlayerManager.player and Navigation_component.target:
			target = PlayerManager.player
			node_finite_state_machine.transition_to("chase")
			target_desired_distance = Navigationagent2d.target_desired_distance
			setup = true

	match node_finite_state_machine.current_node_state_name:
		"chase":
			if cooldown_attack_timer <= 0:
				if player_is_still() and close_to_player(player_acceptable_distance) and has_line_of_sight():
					if !timer.is_stopped():
						timer.stop()
					node_finite_state_machine.transition_to("prepare")

			if (!player_is_still() or !close_to_player(target_desired_distance) or !has_line_of_sight()) and !timer.is_stopped():
				timer.stop()
				if show_debug_code:
					print("%s : Conditions failed (Movement/Distance/LOS). Attack timer stopped" % [get_parent().name])

	if cooldown_attack_timer <= 0:
		cooldown_attack_timer = randf_range(0.5,1.5)

	update_debug_line()


func _on_navigation_agent_2d_target_reached() -> void:
	timer.wait_time = potential_to_wait_time
	timer.one_shot = true
	if timer.is_stopped() and has_line_of_sight():
		timer.start()
		if show_debug_code:
			print("%s : Potential attack timer started" % [get_parent().name])


func player_is_still() -> bool:
	if target:
		return target.velocity.length() <= player_still_velocity
	return true


func close_to_player(accepted_distance : float) -> bool: 
	if target:
		return enemy.global_position.distance_to(target.player_center.global_position) <= accepted_distance
	return false


func has_line_of_sight() -> bool:
	if not target or not enemy:
		return false

	var space_state = enemy.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		enemy.global_position,
		target.player_center.global_position,
		line_of_sight_mask,
		[enemy.get_rid()]
	)

	var result = space_state.intersect_ray(query)

	if result.is_empty():
		return true

	if result.collider == target:
		return true

	return false


func update_debug_line() -> void:
	if not line_2d:
		return

	if not show_debug_code or not target or not enemy:
		line_2d.clear_points()
		return

	line_2d.clear_points()
	line_2d.add_point(Vector2.ZERO)

	var space_state = enemy.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		enemy.global_position,
		target.player_center.global_position,
		line_of_sight_mask,
		[enemy.get_rid()]
	)
	var result = space_state.intersect_ray(query)

	if result.is_empty():
		line_2d.default_color = Color.GREEN
		line_2d.add_point(enemy.to_local(target.player_center.global_position))
	elif result.collider == target:
		line_2d.default_color = Color.GREEN
		line_2d.add_point(enemy.to_local(target.player_center.global_position))
	else:
		line_2d.default_color = Color.RED
		line_2d.add_point(enemy.to_local(result.position))


func _on_potential_to_attack_timer_timeout() -> void:
	if show_debug_code:
		print("%s : potential attack timer timed out" % [get_parent().name])
	if node_finite_state_machine.current_node_state_name == "chase":
		if has_line_of_sight():
			node_finite_state_machine.transition_to("prepare")
