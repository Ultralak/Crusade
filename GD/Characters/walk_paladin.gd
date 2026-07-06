extends NodeState

@export_category("Walk Paladin State")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass
func enter():
	animation_player.play("move")

func exit():
	animation_player.stop()
