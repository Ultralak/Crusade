extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer



func open()->void:
	animation_player.speed_scale = 1.5
	animation_player.play("open")
	
func close() -> void:
	animation_player.play_backwards("open")
