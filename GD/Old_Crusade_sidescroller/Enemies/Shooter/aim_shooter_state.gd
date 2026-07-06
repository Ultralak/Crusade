extends NodeState
@export_category("aim melee state")
@export var characterbody2d : CharacterBody2D
@export var state_machine: NodeFiniteStateMachine

@export var danger  : Label
@export var gun_sprite  : Sprite2D
@export var timer : Timer


signal direction_changed
var direction : int = -2

func on_process(_delta : float):
	pass
func on_physics_process(_delta : float):
	pass
	
func enter():
	var player_pos : Vector2 = PlayerManager.get_player_position()
	var target_flip = player_pos < characterbody2d.global_position
	
	direction = -1 if target_flip else 1

	if sprite_2d.flip_h != target_flip:
		sprite_2d.flip_h = target_flip
		gun_sprite.flip_h = target_flip
		gun_sprite.position.x *= -1

		
		direction_changed.emit()
		characterbody2d.update_direction()
	
	characterbody2d.velocity.x = 0
	animation_player.play("idle")
	danger.show()
	timer.start(0.75)
	
	
func exit():
	danger.visible = false
	animation_player.stop()
	
	
	
