extends CollisionShape2D


@export var player : CharacterBody2D
func enable() -> void:
	player.enable_right()
