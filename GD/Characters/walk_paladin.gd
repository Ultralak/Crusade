extends NodeState

@export_category("Walk Paladin State")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node

func on_process(_delta : float):
	
	if !get_parent().get_parent().get_input() : 
		transition.emit("idle")
	else:
		get_parent().get_parent().get_input()
	
func on_physics_process(_delta : float):
	pass
func enter():
	get_parent().get_parent().get_input()
	animation_player.play("run")

func exit():
	animation_player.stop()
