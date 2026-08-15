extends Node2D
class_name Weapon

@export var damage_amount : float
@export var critical_hit_chance : float = 5
@export var critical_hit_damage_multiplier : float = 2
@export var knockback_force : float

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
	
