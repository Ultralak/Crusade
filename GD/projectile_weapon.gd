@icon("uid://etwv8bj0u7l7")
extends Node2D
class_name ProjectileWeapon

@onready var muzzle: Marker2D = $muzzle
@onready var fire_rate_timer: Timer = $FireRateTimer

@export var bullet := preload("res://Characters/goblin/PlayerBullet.tscn")
@export var fire_rate : float
@export var damage_amount : float
@export var bullet_velocity : float
@export var weapon_bloom : float 
@export var knockback_force : float


var gun_direction : Vector2
var weapon_user : CharacterBody2D
var bullet_setup : bool = false
var can_shoot : bool  = true
var mouse_direction : Vector2
var weapon_pivot : Marker2D 
var slot_index : int

# Checks if is in state so that weapon can work
var in_state : bool

func _physics_process(_delta: float) -> void:
	rotate_gun()
			
func setup_gun_paladin(direction : Vector2, user : CharacterBody2D, pivot : Marker2D, slot : int)->void:
	gun_direction = direction
	weapon_user = user
	slot_index = slot
	weapon_pivot = pivot
	bullet_setup = true

func setup_gun_enemy()->void:
	#for enemies
	pass

func shoot()->void:
	if !bullet_setup:
		return
	var bulletInstance := bullet.instantiate() as BasicProjectile
	
	bulletInstance.global_position = muzzle.global_position
	
	bulletInstance.damage_amount = damage_amount
	bulletInstance.projectile_direction = gun_direction
	bulletInstance.projectile_velocity = bullet_velocity
	
	bulletInstance.knockback_dir = gun_direction
	bulletInstance.knockback_force = knockback_force
	
	weapon_user.add_child(bulletInstance)
	bulletInstance.is_shot = true
	bullet_setup = false
	
	can_shoot = false
	
	var frequency : float = 1/fire_rate
	
	fire_rate_timer.wait_time = frequency
	fire_rate_timer.one_shot = true
	fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true

func rotate_gun()->void:
	if weapon_user is Character:
		mouse_direction  = (get_global_mouse_position() - weapon_pivot.global_position).normalized()
		if weapon_user.can_turn:
			weapon_pivot.rotation = mouse_direction.angle()
			
