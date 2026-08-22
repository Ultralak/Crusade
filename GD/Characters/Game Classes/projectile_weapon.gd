@icon("uid://etwv8bj0u7l7")
extends Weapon
class_name ProjectileWeapon

@onready var muzzle: Marker2D = $"non physics/muzzle"
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var non_physics: Node2D = $"non physics"
@onready var weapon_skin: Sprite2D = $"non physics/weapon skin"


var gun_direction : Vector2
var weapon_user : CharacterBody2D
var bullet_setup : bool = false
var can_shoot : bool  = true
var mouse_direction : Vector2
var weapon_pivot : Marker2D 

var recoil_tween: Tween

func _ready() -> void:
	assign_weapon_sprite()
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

func setup_gun_enemy(direction : Vector2, user : CharacterBody2D, pivot : Marker2D, slot : String = "Slot 1")->void:
	gun_direction = direction
	weapon_user = user
	slot_index = slot
	weapon_pivot = pivot
	global_position  = pivot.global_position
	bullet_setup = true

func shoot()->void:
	setup_normal_damage()
	if !bullet_setup or !can_shoot or !is_normal_damage_setup:
		return
	var bulletInstance := weapon_data.bullet_scene.instantiate() as BasicProjectile
	
	bulletInstance.global_position = muzzle.global_position
	
	bulletInstance.z_index = 20
	
	bulletInstance.knockback_dir = gun_direction
	bulletInstance.knockback_force = weapon_data.knockback_force
	
	bulletInstance.damage_amount = weapon_data.damage_amount
	bulletInstance.penetration = weapon_data.penetration
	bulletInstance.projectile_direction = gun_direction
	
	handle_weapon_bloom()
	bulletInstance.is_critical_damage = critical_hit_done
	
	bulletInstance.projectile_velocity = weapon_data.bullet_velocity
	bulletInstance.rotation = gun_direction.angle()
	bulletInstance.weapon_shot_out_off = self
	
	if weapon_user.is_in_group("ENEMY"):
		bulletInstance.layer_damage_player()
	elif weapon_user.is_in_group("PLAYER"):
		bulletInstance.layer_damage_enemy()
	
	#print("Weapon : %s" % [damage_amount])
	get_tree().current_scene.add_child(bulletInstance)
	bulletInstance.is_shot = true
	
	apply_weapon_recoil()
	
	bullet_setup = false
	can_shoot = false
	
	var frequency : float = 1/(weapon_data.fire_rate * 1.0)
	
	fire_rate_timer.wait_time = frequency
	fire_rate_timer.one_shot = true
	fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true

func rotate_gun()->void:
	if weapon_user.is_in_group("PLAYER"):
		mouse_direction  = weapon_user.mouse_direction
		if weapon_user.can_turn:
			flip_gun(mouse_direction)
	elif weapon_user is Enemy:
		flip_gun(gun_direction)
		
		
func flip_gun(vector : Vector2)->void:
	non_physics.rotation = vector.angle()
	if vector.x < 0:
		weapon_skin.flip_v = true
		muzzle.position.y = abs(muzzle.position.y)
	else:
		muzzle.position.y = -abs(muzzle.position.y)
		weapon_skin.flip_v = false
	
	
func handle_weapon_bloom()->void:
	var mid : float = (weapon_data.weapon_bloom)/2.0
	var weapon_cone : float = randf_range(-mid, mid)
	gun_direction = gun_direction.rotated(deg_to_rad(weapon_cone))
	
func assign_weapon_sprite()->void:
	if weapon_data:
		weapon_skin.texture = weapon_data.weapon_sprite




func apply_weapon_recoil() -> void:
	if !weapon_data:
		return
		
	if recoil_tween and recoil_tween.is_running():
		recoil_tween.kill()
	
	weapon_skin.position.x = -weapon_data.recoil_distance
	
	recoil_tween = create_tween()
	recoil_tween.tween_property(
		weapon_skin, 
		"position:x", 
		0.0, 
		weapon_data.recoil_duration
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
