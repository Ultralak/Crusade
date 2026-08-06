extends NodeState


@export_category("Primary Attack Paladin State")
@export var characterbody2d : CharacterBody2D
@export var weapon_animation_player : AnimationPlayer
@export var velocity_component : Node2D
#frame by frame
func on_process(_delta : float):
	velocity_component.get_input()
	if velocity_component.move_direction.length() > 0 :  
		animation_player.play("run")
	else:
		animation_player.play("idle")
	#physics frame

	#when you enter the scene
func enter():
	velocity_component.speed_modifier = 0.9
	characterbody2d.can_turn = false
	weapon_animation_player.play("attack")
func exit():
	characterbody2d.can_turn = true
	velocity_component.speed_modifier = 1.0
	animation_player.stop()

func _on_sword_anim_animation_finished(_anim_name: StringName) -> void:
	if velocity_component.move_direction.length() > 0 : 
		transition.emit("run")
	else:
		transition.emit("idle")
