extends Area2D
class_name ObjectInteraction

var active_interact_weapon : Weapon
var active_weapon : Weapon
@export var Inventory : InventorySystem
@export var player : Character


func _process(_delta: float) -> void:
	set_closest_weapon()
	if player_pickup_input():
		set_active_weapon()
		
	for child in get_overlapping_areas():
		child.get_parent().interaction_disable()
		active_interact_weapon.is_in_player_sight = false
	if active_interact_weapon:
		active_interact_weapon.interaction_enable()
		active_interact_weapon.is_in_player_sight = true
	
	
func set_closest_weapon()->void:
	var min_distance : float = 1000.0
	active_interact_weapon = null
	for child in get_overlapping_areas():
		if child.get_parent() is Weapon:
			var distance_to_player : float = child.get_parent().global_position.distance_to(player.global_position)
			if distance_to_player <= min_distance:
				min_distance = distance_to_player
				active_interact_weapon = child.get_parent()

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Weapon:
		var weapon := area.get_parent()
		weapon.interaction_disable()
		weapon.is_in_player_sight = false
		print("Weapon : %s is out range" % [weapon.name] )

func player_pickup_input()->bool:
	return Input.is_action_just_pressed("interact") and active_interact_weapon
	
func set_active_weapon()->void:
	active_weapon = Inventory.active_weapon

func drop_active_weapon()->void:
	if !active_weapon:
		return
	active_weapon.reparent(get_tree().current_scene)
	active_weapon.global_position = player.global_position
	
func pickup_new_weapon()->void:
	if !active_interact_weapon or !active_weapon:
		return
	active_weapon = active_interact_weapon
	
	
