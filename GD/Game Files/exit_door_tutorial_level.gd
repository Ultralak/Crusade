extends StaticBody2D
class_name Door


@export var animation_player: AnimationPlayer

enum DOORPOSITION{up,down}

@export var door_position : DOORPOSITION
var speed_scale_open : float = randf_range(1,1.7)
var speed_scale_close : float = randf_range(0.6,0.8)

func open()->void:
	animation_player.speed_scale = speed_scale_open
	animation_player.play("open")
	
func close() -> void:
	animation_player.speed_scale = speed_scale_close
	animation_player.play_backwards("open")
