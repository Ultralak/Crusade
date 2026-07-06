extends NodeState
@export_category("idle melee state")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node



func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	if state_machine_controller.is_dead:
		return
	pass

func enter():
	characterbody2d.velocity.x = 0
	animation_player.play("idle")
	pass


func exit():
	animation_player.stop()
	
	

		
