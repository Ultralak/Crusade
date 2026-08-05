extends Node2D
class_name NavigationComponent



@export var navigation_agent_2d : NavigationAgent2D
@export var hurt_state : NodeState
@export var enemy : CharacterBody2D
@export var avoidance : bool = true
@export var avoidance_radius  :float = 7.0
@export var debug : bool = false

var movement_speed : float = 25
var ignore_player : bool = false
var position_overide : Vector2 
var is_active  :bool = true
var new_velocity : Vector2
var target_direction : Vector2
var target : Node2D = null

func _ready() -> void:
	
	navigation_agent_2d.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)
	navigation_agent_2d.avoidance_enabled = avoidance
	navigation_agent_2d.radius = avoidance_radius
	navigation_agent_2d.debug_enabled = debug
	movement_speed = enemy.movement_speed
	# Wait for the navigation map to sync before doing anything
	
	await get_tree().physics_frame
	target = PlayerManager.player
	
func recalculate_path() -> void:

	if target:
		if ignore_player and position_overide:
			#navigation_agent_2d.target_position = position_overide
			navigation_agent_2d.target_position = NavigationServer2D.map_get_closest_point(navigation_agent_2d.get_navigation_map(), position_overide)
		else:
			navigation_agent_2d.target_position = target.global_position

	if hurt_state.has_method("is_setup") and hurt_state.is_setup : 
		return
	if navigation_agent_2d.avoidance_enabled:
		navigate_safe()
	else:
		navigate()
	

func navigate() -> void:
	if navigation_agent_2d.is_navigation_finished() :
			new_velocity = Vector2.ZERO
	else:
		var current_agent_position = global_position
		var next_path_position = navigation_agent_2d.get_next_path_position()
		target_direction = current_agent_position.direction_to(next_path_position)
		new_velocity = target_direction * movement_speed

func navigate_safe() -> void:
	if navigation_agent_2d.is_navigation_finished() :
		

		new_velocity = Vector2.ZERO
	else :

		var current_agent_position = global_position
		var next_path_position = navigation_agent_2d.get_next_path_position()
		target_direction = current_agent_position.direction_to(next_path_position)
		navigation_agent_2d.set_velocity(target_direction * movement_speed)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	if !is_active:
		return
	new_velocity = safe_velocity
	
	# depracated . remeber to remove in the future
func disable_navigation():
	is_active = false
	set_physics_process(false)
	enemy.velocity = Vector2.ZERO
	
func enable_navigation():
	is_active = true
	set_physics_process(true)
	
