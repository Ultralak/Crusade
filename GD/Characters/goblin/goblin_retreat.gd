extends NodeState

@export var entity : Enemy
@export var navigation_component : NavigationComponent
@export var navAgent : NavigationAgent2D
@export var retreat_distance : float = 50
var player : Character

func enter():
	
	player = PlayerManager.player
	var direction_to_player : Vector2 = entity.global_position.direction_to(player.global_position)
	
	animation_player.play("run")
	navigation_component.enable_navigation()
	navigation_component.recalculate_path()
	
	var cone_of_escape : float = randf_range(-80,80)
	var retreat_direction : Vector2 = -direction_to_player
	
	
	navigation_component.position_overide = entity.global_position + retreat_direction.rotated(deg_to_rad(cone_of_escape)).normalized()  * retreat_distance
	navigation_component.ignore_player = true
	

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	navigation_component.recalculate_path()
	entity.velocity = navigation_component.new_velocity
	entity.move_and_slide()
	if navAgent.is_navigation_finished():
		entity.retreat_finished = true
	
func exit():
	navigation_component.ignore_player = false
	animation_player.stop()
	navigation_component.disable_navigation()
