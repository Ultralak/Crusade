extends NodeState

@export_category("Idle Flying Animal")
@export var characterBody2d : CharacterBody2D

func _process(_delta: float) -> void:
	pass
func _physics_process(_delta: float) -> void:
	pass
func enter():
	animation_player.play("idle")
	
func exit():
	animation_player.stop()
