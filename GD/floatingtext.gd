extends Node2D
class_name FloatingText

@onready var label: Label = $Label

func setup(amount: int, spawn_position: Vector2) -> void:
	global_position = spawn_position
	label.text = "+%d" % amount
	
	# Start animations as soon as it enters the scene
	_animate_and_free()

func _animate_and_free() -> void:
	var tween = create_tween().set_parallel(true)
	
	# Float upward by 40 pixels
	tween.tween_property(self, "global_position:y", global_position.y - 40.0, 0.65)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
	# Fade out alpha transparency
	tween.tween_property(self, "modulate:a", 0.0, 0.65)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		
	# Delete node when tween completes
	tween.chain().tween_callback(queue_free)
