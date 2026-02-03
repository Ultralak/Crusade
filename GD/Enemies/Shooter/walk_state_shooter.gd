extends NodeState
@export_category("walk melee state")
@export var characterbody2d : CharacterBody2D
@export var animation_player : AnimationPlayer
@export var raycast_floor : RayCast2D
@export var state_machine_controller: Node
@export var acceleration : float = 200
@export var sprite_2d : Sprite2D

var speed : int

signal direction_changed
var direction : int 

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	if !raycast_floor.is_colliding() or characterbody2d.is_on_wall():
		direction_changed.emit()
		direction *= -1
		characterbody2d.update_direction()
		characterbody2d.velocity.x = 0
		sprite_2d.flip_h = !sprite_2d.flip_h	
	else:
		characterbody2d.velocity.x = move_toward(characterbody2d.velocity.x, speed * direction, acceleration * _delta)
func enter():
	direction = characterbody2d.direction
	characterbody2d.velocity.x = 0
	speed  = characterbody2d.walk_speed
	animation_player.play("run")
	pass


func exit():
	animation_player.stop()
	
	

		
