extends Node2D


@export var movement_speed = 25
@export var navigation_agent_2d : NavigationAgent2D
@export var hurt_state : NodeState
var target : Node2D = null
@export var player : CharacterBody2D
@export var friction : float = 0.1

func _ready() -> void:
	# Wait for the navigation map to sync before doing anything
	await get_tree().physics_frame
	target = get_tree().get_nodes_in_group("PLAYER_")[0]
	
func _physics_process(_delta: float) -> void:
	# 1. Dynamically update the target position every frame so the path recalculates
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	if navigation_agent_2d.is_navigation_finished() :
		if !hurt_state.is_setup:
			#we reached player and not being hit
			player.velocity = Vector2.ZERO
		else:
			# we reached the player and being hit so
			pass
	elif !navigation_agent_2d.is_navigation_finished():
		if !hurt_state.is_setup:
			#we have not reached player and not being hit
			
			# 3. Calculate movement direction
			var current_agent_position = global_position
			var next_path_position = navigation_agent_2d.get_next_path_position()
			
			# 4. Set velocity and move
			var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed
			if player.velocity.length() < new_velocity.length():
				player.velocity = player.velocity.lerp(new_velocity, friction)
			else:
				player.velocity = new_velocity
		else:
			# we reached the player and being hit 
			pass
		
		
	player.move_and_slide()
