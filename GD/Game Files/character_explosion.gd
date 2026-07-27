extends AnimatedSprite2D

func _ready() -> void:
	animation_time = sprite_frames.get_frame_count("dead")/sprite_frames.get_animation_speed("dead")
func _on_animation_finished() -> void:
		if get_parent() is not CharacterBody2D:
			queue_free()

var animation_time : float
