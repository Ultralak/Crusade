extends NodeState
@export_category("aim melee state")
@export var characterbody2d : CharacterBody2D
@export var animation_player : AnimationPlayer
@export var state_machine: NodeFiniteStateMachine
@export var sprite_2d : Sprite2D
@export var danger  : Label
@export var gun_sprite  : Sprite2D
@export var timer : Timer

var previous_direction : int = -2
signal direction_changed
var direction : int = -2

func on_process(_delta : float):
	pass
func on_physics_process(_delta : float):
	pass
	
func enter():
	previous_direction = characterbody2d.direction
	var player_pos : Vector2 = PlayerManager.get_player_position()
	sprite_2d.flip_h  = true if player_pos.x < characterbody2d.global_position.x else false
	direction = -1 if sprite_2d.flip_h else 1
	
	if previous_direction != direction:
		previous_direction = direction
		
		gun_sprite.position.x *= -1
		gun_sprite.flip_h = sprite_2d.flip_h
		
		direction_changed.emit()
		characterbody2d.update_direction()
	
	characterbody2d.velocity.x = 0
	timer.start(0.75)
	animation_player.play("Idle")
	danger.show()
	
func exit():
	danger.visible = false
	animation_player.stop()
	
	
	
