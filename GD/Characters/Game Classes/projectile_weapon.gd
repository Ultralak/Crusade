@icon("uid://etwv8bj0u7l7")
extends Weapon
class_name ProjectileWeapon

@onready var muzzle: Marker2D = $"non physics/muzzle"

@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var non_physics: Node2D = $"non physics"

@export var bullet := preload("res://Characters/goblin/PlayerBullet.tscn")
@export var fire_rate : float
@export var bullet_velocity : float
@export var weapon_bloom : float 

@export var weapon_sprite : Sprite2D
@export var penetration : int = 1

var gun_direction : Vector2
var weapon_user : CharacterBody2D
var bullet_setup : bool = false
var can_shoot : bool  = true
var mouse_direction : Vector2
var weapon_pivot : Marker2D 
var slot_index : String

# Checks if is in state so that weapon can work
var in_state : bool

func _process(_delta: float) -> void:
	if weapon_pivot :
		rotate_gun()
			
func setup_gun_paladin(direction : Vector2, user : CharacterBody2D, pivot : Marker2D, slot : String)->void:
	gun_direction = direction
	weapon_user = user
	slot_index = slot
	weapon_pivot = pivot
	global_position  = pivot.global_position
	bullet_setup = true
	critical_hit()

func setup_gun_enemy()->void:
	#for enemies
	pass

func shoot()->void:
	if !bullet_setup or !can_shoot:
		return
	var bulletInstance := bullet.instantiate() as BasicProjectile
	
	bulletInstance.global_position = muzzle.global_position
	
	bulletInstance.damage_amount = damage_amount
	bulletInstance.projectile_direction = gun_direction
	bulletInstance.projectile_velocity = bullet_velocity
	
	bulletInstance.knockback_dir = gun_direction
	bulletInstance.knockback_force = knockback_force
	bulletInstance.damage_amount = damage_amount
	bulletInstance.penetration = penetration
	
	print("Weapon : %s" % [damage_amount])
	
	bulletInstance.z_index = 20
	bulletInstance.rotation = gun_direction.angle() + deg_to_rad(90)
	
	get_tree().current_scene.add_child(bulletInstance)
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
		mouse_direction  = weapon_user.mouse_direction
		if weapon_user.can_turn:
			non_physics.rotation = mouse_direction.angle()
			if mouse_direction.x < 0:
				weapon_sprite.flip_v = true
				if muzzle.position.y < 0:
					muzzle.position.y *= -1
			else:
				if muzzle.position.y > 0:
					muzzle.position.y *= -1
				weapon_sprite.flip_v = false
