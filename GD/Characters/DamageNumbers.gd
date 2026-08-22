extends Node
var DamageNumberScene = preload("uid://ducvcgqy1jlk8")

func display_number(value : float, position : Vector2, is_critical : bool = false):
	var number = DamageNumberScene.instantiate() as Label
	var font_outline_color : Color

	var color = Color("#FFFFFF")
	if is_critical:
		font_outline_color = Color("#FF6347")
	elif value == 0:
		font_outline_color = Color("#00FF00")
	else:
		font_outline_color = Color(0.18, 0.824, 0.871, 1.0)
	number.setup_damage_labels(value, color, font_outline_color)
	call_deferred("add_child", number)
	
	await number.resized
	
	if !is_instance_valid(number):
		return
	number.global_position = position
	number.pivot_offset = Vector2(number.size / 2)
	
	var random_angle : float = randf_range(-PI / 4, PI / 4)
	var jump_vector : Vector2 = Vector2.UP.rotated(random_angle) * randf_range(20.0, 35.0)
	var start_pos : Vector2 = number.position
	var peak_pos : Vector2 = start_pos + jump_vector
	var land_pos : Vector2 = peak_pos + Vector2(jump_vector.x * 0.5, 15.0)
	
	var tween = get_tree().create_tween().set_parallel(true)
	
	tween.tween_property(number, "position", peak_pos, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(number, "position", land_pos, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD).set_delay(0.2)
	
	tween.tween_property(number, "scale", Vector2.ZERO, 0.15).set_ease(Tween.EASE_IN).set_delay(0.35)
		
	await tween.finished
	if is_instance_valid(number):
		number.queue_free()
