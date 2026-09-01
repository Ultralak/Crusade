extends Node2D
class_name CoinComponent

@export var floating_text_scene: PackedScene = preload("res://Game Components/Scenes/floatngText.tscn")

func collect_coins(amount: int) -> void:
	if amount <= 0:
		return

	PlayerManager.add_coins(amount)
	_spawn_floating_text(amount)

func _spawn_floating_text(amount: int) -> void:
	if not floating_text_scene:
		push_error("FloatingText scene is missing on CoinComponent in " + get_parent().name)
		return

	var popup = floating_text_scene.instantiate() as FloatingText
	
	# 1. Pass data values directly to the instance variables
	popup.amount = amount
	popup.spawn_position = global_position
	popup.z_index = 100 # High Z-index ensures rendering above ground tilemaps
	
	# 2. Add to scene tree, triggering _ready() with the updated data
	get_tree().current_scene.add_child(popup)
