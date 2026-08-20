extends Node2D
class_name Weapon



var NORMAL_DAMAGE_AMOUNT : float
var critical_hit_done : bool = false
@export var weapon_data : WeaponData
@export var interactable_zone : Interactable
var slot_index : String
func _ready() -> void:
	NORMAL_DAMAGE_AMOUNT = weapon_data.damage_amount

func critical_hit()->void:
	critical_return()
	var random : float = randf_range(0,100)
	clampf(weapon_data.critical_hit_chance,0,100)
	if random <= weapon_data.critical_hit_chance:
		weapon_data.damage_amount *= weapon_data.critical_hit_damage_multiplier
		critical_hit_done = true



func critical_return()->void:
	if critical_hit_done:
		critical_hit_done = false
		weapon_data.damage_amount = NORMAL_DAMAGE_AMOUNT
	
