extends Node2D

@export var interactable: Interactable
@export_file("*.tscn") var second_level_path: String

func _ready() -> void:
	if interactable:
		interactable.interacted.connect(transition)
	else:
		push_error("Interactable resource/node is missing on " + name)

func transition() -> void:
	if second_level_path != "":
		# Ensure the game tree is unpaused so Level 2 physics run normally
		get_tree().paused = false
		get_tree().change_scene_to_file(second_level_path)
	else:
		push_error("Second level path is not set in the Inspector on " + name)
