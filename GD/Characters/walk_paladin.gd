extends NodeState

@export_category("Walk Paladin State")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node
@export var velocity_component : Node2D


func on_physics_process(_delta : float):
	pass
func enter():
	animation_player.play("run")

func exit():
	animation_player.stop()
