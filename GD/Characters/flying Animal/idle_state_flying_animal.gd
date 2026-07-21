extends NodeState

@export_category("Idle Flying Animal")
@export var characterBody2d : CharacterBody2D
@export var Navigation_component : Node2D
func on_process(_delta: float) -> void:
	pass
func on_physics_process(_delta: float) -> void:
	pass
func enter():
	animation_player.play("idle")
	Navigation_component.disable_navigation()
	
func exit():
	animation_player.stop()
	Navigation_component.enable_navigation()
