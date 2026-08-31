extends NodeState

@export var entity : Enemy
@export var navigation_component : NavigationComponent
@export var navAgent : NavigationAgent2D

func enter():
	entity.start_waddle()
	navigation_component.enable_navigation()
	navigation_component.recalculate_path()

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	navigation_component.recalculate_path()
	entity.velocity = navigation_component.new_velocity
	entity.move_and_slide()
	if navAgent.is_navigation_finished():
		entity.approach_finished = true
	
func exit():
	entity.stop_waddle()
	navigation_component.disable_navigation()
