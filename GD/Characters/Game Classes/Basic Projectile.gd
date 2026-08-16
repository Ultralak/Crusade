@icon("res://Art/enemies/goblin/goblin_knife.png")
extends CharacterBody2D
class_name BasicProjectile

@export var disappear: Timer 
@export var attack_box : Area2D 

@export var disapear_time : float = 2
@export var sprite2d : Sprite2D

var penetration : int = 1

var weapon_shot_out_off : Weapon
var knockback_dir : Vector2
var knockback_force : float
var damage_amount : float
var is_critical_damage : bool = false

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
	
func layer_damage_enemy()->void:
	attack_box.set_collision_mask_value(5,true)
	attack_box.set_collision_mask_value(4,false) 
func layer_damage_player()->void:
	attack_box.set_collision_mask_value(4,true)
	attack_box.set_collision_mask_value(5,false)
