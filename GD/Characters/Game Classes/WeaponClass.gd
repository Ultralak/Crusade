extends Node2D
class_name Weapon



var NORMAL_DAMAGE_AMOUNT : float
var critical_hit_done : bool = false
@export var weapon_data : WeaponData
@export var interactable_zone : Interactable
@export var purchase_component : PurchaseComponent
var is_normal_damage_setup : bool = false
var slot_index : String
var damage : float  = 0.0
func setup_normal_damage()->void:
	if !is_normal_damage_setup and weapon_data:
		NORMAL_DAMAGE_AMOUNT = weapon_data.damage_amount
		damage = NORMAL_DAMAGE_AMOUNT
		print("from shoot function damage : %s" % NORMAL_DAMAGE_AMOUNT)
		is_normal_damage_setup = true


func critical_hit()->void:
	critical_return()
	var random : float = randf_range(0,100)
	clampf(weapon_data.critical_hit_chance,0,100)
	if random <= weapon_data.critical_hit_chance:
		damage *= weapon_data.critical_hit_damage_multiplier
		critical_hit_done = true
	else:
		damage = NORMAL_DAMAGE_AMOUNT



func critical_return()->void:
	if critical_hit_done:
		critical_hit_done = false
		damage = NORMAL_DAMAGE_AMOUNT
	
