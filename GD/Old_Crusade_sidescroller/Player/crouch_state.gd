extends NodeState

@export var character_body_2d : CharacterBody2D	
@export_category("Crouch_state")

signal passthrough

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	
	if not character_body_2d.is_on_floor():
		transition.emit("fall")
		return

	if GameInputEvents.slash_input():
		transition.emit("slash")
		return

	if GameInputEvents.jump_input():
		character_body_2d.set_collision_mask_value(4 , false)
		passthrough.emit()
		transition.emit("fall")
		return
		
	if !GameInputEvents.crouch_input():
		transition.emit("idle")
		return
		
func enter():
	animation_player.speed_scale = 2
	animation_player.play("crouch")

	
func exit():
	animation_player.speed_scale = 1
	animation_player.stop()
	
