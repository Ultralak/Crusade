extends Node2D
class_name NavigationComponent

@export var movement_speed = 25
@export var navigation_agent_2d : NavigationAgent2D
@export var hurt_state : NodeState
@export var enemy : CharacterBody2D
@export var avoidance : bool = true
@export var avoidance_radius  :float = 7.0
@export var debug : bool = false
var is_active  :bool = true
var new_velocity : Vector2
var target_direction : Vector2
var target : Node2D = null

func _ready() -> void:
	navigation_agent_2d.avoidance_enabled = avoidance
	navigation_agent_2d.radius = avoidance_radius
	navigation_agent_2d.debug_enabled = debug
	# Wait for the navigation map to sync before doing anything
	await get_tree().physics_frame
	target = get_tree().get_nodes_in_group("PLAYER")[0]
	
func recalculate_path() -> void:
	# 1. Dynamically update the target position every frame so the path recalculates
	if target:
		navigation_agent_2d.target_position = target.global_position
		

	
	if hurt_state.is_setup : 
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
		# 4. Set velocity and move
		target_direction = current_agent_position.direction_to(next_path_position)
		new_velocity = target_direction * movement_speed

func navigate_safe() -> void:
	if navigation_agent_2d.is_navigation_finished() :
		
			#we reached enemy and not being hit
		new_velocity = Vector2.ZERO
	else :
		#we have not reached enemy and not being hit
		# 3. Calculate movement direction
		var current_agent_position = global_position
		var next_path_position = navigation_agent_2d.get_next_path_position()
		# 4. Set velocity and move
		target_direction = current_agent_position.direction_to(next_path_position)
		new_velocity = target_direction * movement_speed
		navigation_agent_2d.set_velocity(new_velocity)

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
	
