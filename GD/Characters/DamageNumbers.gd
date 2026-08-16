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
	number.global_position  = position
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.2
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y , 0.4
	).set_ease(Tween.EASE_IN).set_delay(0.2)
	tween.tween_property(
		number,"scale", Vector2.ZERO, 0.2
		).set_ease(Tween.EASE_IN).set_delay(0.4)
		
	await tween.finished
	if is_instance_valid(number):
		number.queue_free()
	
