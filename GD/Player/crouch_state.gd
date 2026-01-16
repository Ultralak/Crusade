extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var collision_normal : CollisionShape2D	
@export var collision_crouch : CollisionShape2D	
@export_category("Crouch_state")


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
		transition.emit("jump")
		return
		
	if !GameInputEvents.crouch_input():
		transition.emit("idle")
		return
		
func enter():
	animated_sprite_2d.play("crouch")
	collision_normal.disabled = true
	collision_crouch.disabled  = false
	
func exit():
	animated_sprite_2d.play_backwards("crouch")
	collision_normal.disabled = false
	collision_crouch.disabled  = true
	animated_sprite_2d.stop()
	
