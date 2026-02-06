extends NodeState
@export_category("idle melee state")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node
@export var acceleration : float = 500
@export var speed : float = 600




func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass
func enter():
	characterbody2d.velocity.x = 0
	animation_player.play("idle")


func exit():
	animation_player.stop()
	
	
