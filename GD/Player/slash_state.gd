extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

@export_category("Slash_state")



func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0 , 100)
	character_body_2d.move_and_slide()
	
	var direction = GameInputEvents.movement_input()
	
	if direction != 0:
		animated_sprite_2d.flip_h = false if direction > 0 else true
	
	

	if !GameInputEvents.slash_input():
		transition.emit("idle")
		return

	if not character_body_2d.is_on_floor():
		transition.emit("fall")
		return

	if GameInputEvents.jump_input():
		transition.emit("jump")
		return
		

func enter():
	
	animated_sprite_2d.play("main_slash")

	
func exit():
	animated_sprite_2d.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	if GameInputEvents.slash_input():
		animated_sprite_2d.play("main_slash")


func _on_animated_sprite_2d_frame_changed() -> void:
	var lunge_direction = -1 if animated_sprite_2d.flip_h else 1
	
	if animated_sprite_2d.frame == 3 or animated_sprite_2d.frame == 9:
		character_body_2d.velocity.x = 300 * lunge_direction
	else:
		pass
		
		
