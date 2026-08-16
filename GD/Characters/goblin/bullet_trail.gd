extends Node2D

const max_trail_count : int = 50
@export var entity : BasicProjectile
@export var line : Line2D

func _process(_delta: float) -> void:
	if line.points.size() >= max_trail_count:
		line.remove_point(0)
	line.add_point(entity.global_position)
