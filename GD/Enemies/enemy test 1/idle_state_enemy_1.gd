extends NodeState

@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D
@export var start_speed : float = 50
@export var max_speed : float = 50

@onready var state_machine_controller: Node = $"../../stateMachineController"

signal player_still_in


func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass

func enter():
	if state_machine_controller.player_still_in_area_2d:
		player_still_in.emit() 
	animatedsprite2d.play("idle")
	pass


func exit():
	animatedsprite2d.stop()
	
	

		
