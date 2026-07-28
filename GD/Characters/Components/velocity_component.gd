extends Node2D
class_name VelocityComponent
# Lowered max speed and raised acceleration for a snappier feel
const FRICTION : float = 0.15
@export var Acceleration : int = 1000
@export var Max_speed : int = 300     
@export var player : CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

var move_direction: Vector2 = Vector2.ZERO
var move_velocity : Vector2 = Vector2.ZERO
var speed_modifier : float = 1.0


func _physics_process(delta: float) -> void:
	get_input()
	move(delta)
	get_parent().velocity = move_velocity

func move(delta: float) -> void:
	move_direction = move_direction.normalized()
	if move_direction != Vector2.ZERO:
		move_velocity += move_direction * Acceleration * delta 
		move_velocity = move_velocity.limit_length(Max_speed) * speed_modifier
	else:
		move_velocity = lerp(move_velocity, Vector2.ZERO, FRICTION) * speed_modifier
		if move_velocity.length() < 1:
			move_velocity = Vector2.ZERO
	
func get_input() -> void:
	move_direction = Input.get_vector("move_left","move_right","move_up","move_down")
