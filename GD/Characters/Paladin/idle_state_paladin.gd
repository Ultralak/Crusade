extends NodeState

@export_category("Idle Paladin State")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node
@export var velocity_component : Node2D
		

func enter():
	velocity_component.move_velocity = Vector2.ZERO
	animation_player.play("idle")

func exit():
	animation_player.stop()
