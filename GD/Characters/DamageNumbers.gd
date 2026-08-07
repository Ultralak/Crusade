extends Node
var DamageNumberScene = preload("uid://ducvcgqy1jlk8")

func display_number(value : float, position : Vector2, is_critical : bool = false):
	var number = DamageNumberScene.instantiate() as Label
	

	var color = "#FFFFFF"
	if is_critical:
		color = "#B22"
	if value == 0:
		color = "#FFFFFF80"
		
	number.setup_damage_labels(value, color)
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
	
