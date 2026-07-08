extends NodeState

@export_category("Idle Paladin State")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node

func on_process(_delta : float):
	
	if get_parent().get_parent().get_input() : 
		transition.emit("run")
	else:
		get_parent().get_parent().get_input()
		
	
func on_physics_process(_delta : float):
	pass
func enter():
	characterbody2d.move_velocity = Vector2.ZERO
	animation_player.play("idle")

func exit():
	animation_player.stop()
