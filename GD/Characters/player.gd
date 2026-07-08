@icon("res://Art/heroes/knight/knight_idle_anim_f0.png")
extends CharacterBody2D
class_name Character

const FRICTION : float = 0.0001
@export var Acceleration : int = 400
@export var Max_speed : int = 10000

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var move_direction: Vector2 = Vector2.ZERO
var move_velocity : Vector2 = Vector2.ZERO
#move the movement handling somewhere else or add debugging nonsense

func _physics_process(_delta: float) -> void:
	velocity = move_velocity * _delta
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	move_and_slide()
	
func move() -> void:
	move_direction = move_direction.normalized()
	move_velocity += move_direction * Acceleration
	move_velocity = move_velocity.limit_length(Max_speed)
