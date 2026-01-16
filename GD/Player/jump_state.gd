extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

@export_category("Jump_State")
@export var jump_height : float  = -250
@export var jump_horizontal_speed : int = 200
@export var max_jump_horizontal_speed : int = 200
@export var max_jump_count : int = 2
@export var jump_gravity : int  = 1000




var current_jump_count : int



func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction  = GameInputEvents.movement_input()
	character_body_2d.velocity.y += jump_gravity * delta


	#multiple jumps
	if !character_body_2d.is_on_floor() and GameInputEvents.jump_input() and current_jump_count != max_jump_count:
		character_body_2d.velocity.y = jump_height
		current_jump_count += 1

	
	if !character_body_2d.is_on_floor() :
		if direction != 0:
			animated_sprite_2d.flip_h = false if direction > 0 else true
			character_body_2d.velocity.x += direction * jump_horizontal_speed
			character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
		else:
			character_body_2d.velocity.x = 0
	character_body_2d.move_and_slide()
	
	
	#transitioning states
	#fall state
	if character_body_2d.velocity.y > 0:
		transition.emit("fall")
	
	#idle states
	if character_body_2d.is_on_floor():
		transition.emit("idle")
		
	
	if GameInputEvents.slash_input():
		transition.emit("slash")
		return
		
func enter():

	animated_sprite_2d.play("jump")
	if character_body_2d.is_on_floor():
		current_jump_count = 0
		character_body_2d.velocity.y = jump_height
		current_jump_count += 1	
	
func exit():

	animated_sprite_2d.stop()
