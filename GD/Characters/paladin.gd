extends Character
#damage and health script

func _process(delta: float) -> void:
	var mouse_direction : Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
	
func get_input() -> void:
	#Need to change for 3d world only works for top down like soul knight not wizard of legends
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("move_up"):
		move_direction += Vector2.UP
	if Input.is_action_pressed("move_left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		move_direction += Vector2.RIGHT
		
		
		
		
