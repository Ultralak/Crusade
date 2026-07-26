extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	pass # Replace with function body.



func open_door()->void:
	animation_player.play("open")
	
func close_door() -> void:
	animation_player.play_backwards("open")
