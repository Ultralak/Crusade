extends Node2D
class_name CoinComponent

@export var floating_text_scene: FloatingText

func collect_coins(amount: int) -> void:
	if amount <= 0:
		return

	PlayerManager.add_coins(amount)
	_spawn_floating_text(amount)

func _spawn_floating_text(amount: int) -> void:
	if not floating_text_scene:
		push_error("FloatingText scene is missing on CoinComponent in " + get_parent().name)
		return

	var popup = floating_text_scene
	
	# 1. Pass data values directly to the instance variables
	popup.setup(damage,global_position)
