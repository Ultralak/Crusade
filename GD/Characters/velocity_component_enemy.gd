extends Node2D


@export var movement_speed = 50.0
@export var navigation_agent_2d : NavigationAgent2D
var target : Node2D = null
@export var player : CharacterBody2D

func _ready() -> void:
	# Wait for the navigation map to sync before doing anything
	await get_tree().physics_frame
	target = get_tree().get_nodes_in_group("PLAYER_")[0]
	
func _physics_process(_delta: float) -> void:
	# 1. Dynamically update the target position every frame so the path recalculates
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	# 2. Check if we reached the player
	if navigation_agent_2d.is_navigation_finished():
		player.velocity = Vector2.ZERO
		return
	
	# 3. Calculate movement direction
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	
	# 4. Set velocity and move
	player.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	player.move_and_slide()
