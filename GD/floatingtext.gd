extends Node2D
class_name FloatingText

@onready var label: Label = $Label

var amount: int = 0
var spawn_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Position and format text on frame 1 as it enters the scene
	global_position = spawn_position
	label.text = "+%d" % amount
	_animate_and_free()

func _animate_and_free() -> void:
	var tween = create_tween().set_parallel(true)
	
	# Float upward by 40 pixels
	tween.tween_property(self, "global_position:y", global_position.y - 40.0, 0.65)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
	# Fade transparency to 0
	tween.tween_property(self, "modulate:a", 0.0, 0.65)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		
	# Automatically clean up node from memory
	tween.chain().tween_callback(queue_free)
