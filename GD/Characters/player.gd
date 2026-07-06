@icon("res://Art/heroes/knight/knight_idle_anim_f0.png")
extends CharacterBody2D
class_name Character

const FRICTION : float = 0.15
@export var Acceleration : int = 40
@export var Max_speed : int = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var move_direction: Vector2 = Vector2.ZERO
var move_velocity : Vector2 = Vector2.ZERO
#move the movement handling somewhere else or add debugging nonsense

func _physics_process(delta: float) -> void:
	velocity = move_velocity
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	move_and_slide()
	
func move() -> void:
	move_direction = move_direction.normalized()
	velocity += move_direction * Acceleration
	velocity = velocity.limit_length(Max_speed)
