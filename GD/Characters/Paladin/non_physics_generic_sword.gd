extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func flip_sprites_v(value : bool)->void:
	for child in get_children():
		if child is Sprite2D:
			child.flip_v = value

func flip_sprites_h(value : bool)->void:
	for child in get_children():
		if child is Sprite2D:
			child.flip_h = value
