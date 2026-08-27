extends StaticBody2D
class_name Door


@export var animation_player: AnimationPlayer

enum DOORPOSITION{up,down}

@export var door_position : DOORPOSITION
var speed_scale_open : float = randf_range(1,1.7)
var speed_scale_close : float = randf_range(1.1,1.5)

func open()->void:
	animation_player.speed_scale = speed_scale_open
	animation_player.call_deferred("play","open")
	print("doors opened")
	
func close() -> void:
	animation_player.speed_scale = speed_scale_close
	animation_player.call_deferred("play","close")
	print("doors closed")
