@icon("res://Art/enemies/goblin/goblin_knife.png")
extends CharacterBody2D
class_name BasicProjectile

@onready var disappear: Timer = $disappear

@export var disapear_time : float = 2
@export var sprite2d : Sprite2D

var penetration : int = 1


var knockback_dir : Vector2
var knockback_force : float
var damage_amount : float

var is_shot : bool  = false
var projectile_velocity : float
var projectile_direction : Vector2

func _ready() -> void:
	disappear.wait_time = disapear_time
	disappear.one_shot = true
	disappear.start()
	disappear.timeout.connect(on_timeout)
	
func on_timeout()->void:
	call_deferred("queue_free")

func _physics_process(_delta: float) -> void:
	if is_shot and projectile_velocity:
		velocity = projectile_direction * projectile_velocity
		move_and_slide()
	# this is just for this special case
	sprite2d.rotation = projectile_direction.angle_to_point(Vector2.ZERO) + deg_to_rad(45)
