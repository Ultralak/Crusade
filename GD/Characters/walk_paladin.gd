extends NodeState

@export_category("Walk Paladin State")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node
@export var velocity_component : Node2D
func on_process(_delta : float):
	velocity_component.get_input()
	if velocity_component.move_direction.length() < 1 : 
		transition.emit("idle")
	elif Input.is_action_pressed("primary_attack"):
		transition.emit("primary_attack")
		
	
func on_physics_process(_delta : float):
	pass
func enter():
	velocity_component.get_input()
	animation_player.play("run")

func exit():
	animation_player.stop()
