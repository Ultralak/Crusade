extends CharacterBody2D
class_name Weapon

@export_range(0,100,0.1,"hide_control","or_greater","suffix:Points") var damage_amount : float
@export_range(0,100) var critical_hit_chance : float = 5
@export_range(0,10,0.1,"or_greater") var critical_hit_damage_multiplier : float = 2
@export_range(0,1000,1,"hide_control","or_greater") var knockback_force : float
@export var interact_icon : Node2D
@export var interact_region : Area2D
var NORMAL_DAMAGE_AMOUNT : float
var critical_hit_done : bool = false
var is_in_active_slot : bool = false
var interactable : bool = false
func _ready() -> void:
	
	NORMAL_DAMAGE_AMOUNT = damage_amount

func critical_hit()->void:
	critical_return()
	var random : float = randf_range(0,100)
	clampf(critical_hit_chance,0,100)
	if random <= critical_hit_chance:
		damage_amount *= critical_hit_damage_multiplier
		critical_hit_done = true

func reveal_interact_icon()->void:
	interact_icon.show()
	
func hide_reveal_icon()->void:
	interact_icon.visible = false

func interact_setup()->void:
	reveal_interact_icon()
	interactable = true

func interact_leave()->void:
	hide_reveal_icon()
	interactable = false

func critical_return()->void:
	if critical_hit_done:
		critical_hit_done = false
		damage_amount = NORMAL_DAMAGE_AMOUNT
	
func weapon_picked_up()->void:
	if !interact_region.is_queued_for_deletion():
		interact_region.queue_free()
