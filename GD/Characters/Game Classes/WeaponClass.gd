extends Node2D
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
var player_can_pickup : bool = false
var is_on_ground : bool = true
var is_in_player_sight : bool = false
func _ready() -> void:
	interact_icon.visible = false
	NORMAL_DAMAGE_AMOUNT = damage_amount

func critical_hit()->void:
	critical_return()
	var random : float = randf_range(0,100)
	clampf(critical_hit_chance,0,100)
	if random <= critical_hit_chance:
		damage_amount *= critical_hit_damage_multiplier
		critical_hit_done = true

func interaction_enable()->void:
	# the player can now click to pick weapon and weapon on floor
	if is_on_ground:
		interact_icon.show()
		player_can_pickup = true
	
func interaction_disable()->void:
	if is_on_ground:
		interact_icon.visible = false
		player_can_pickup = false

func disable_interact_area()->void:
	interact_region.monitorable = false
	interact_region.monitoring = false

func enable_interact_area()->void:
	interact_region.monitorable = true
	interact_region.monitoring = true

func critical_return()->void:
	if critical_hit_done:
		critical_hit_done = false
		damage_amount = NORMAL_DAMAGE_AMOUNT
	
func weapon_picked_up()->void:
	if !interact_region.is_queued_for_deletion():
		interact_region.queue_free()
