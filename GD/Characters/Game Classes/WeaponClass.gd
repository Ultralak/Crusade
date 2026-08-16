extends Node2D
class_name Weapon

@export_range(0,100,0.1,"hide_control","or_greater","suffix:Points") var damage_amount : float
@export_range(0,100) var critical_hit_chance : float = 5
@export_range(0,10,0.1,"or_greater") var critical_hit_damage_multiplier : float = 2
@export_range(0,1000,1,"hide_control","or_greater") var knockback_force : float

var NORMAL_DAMAGE_AMOUNT : float
var critical_hit_done : bool = false

func _ready() -> void:
	
	NORMAL_DAMAGE_AMOUNT = damage_amount

func critical_hit()->void:
	critical_return()
	var random : float = randf_range(0,100)
	clampf(critical_hit_chance,0,100)
	if random <= critical_hit_chance:
		damage_amount *= critical_hit_damage_multiplier
		critical_hit_done = true


func critical_return()->void:
	if critical_hit_done:
		critical_hit_done = false
		damage_amount = NORMAL_DAMAGE_AMOUNT
	
