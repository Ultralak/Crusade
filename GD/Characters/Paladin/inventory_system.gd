extends Node2D
class_name InventorySystem


@export var FSM : NodeFiniteStateMachine
@export var player : Paladin
var player_backpack : Dictionary[String,ProjectileWeapon]
var active_weapon : Weapon
var count : int = 1

func _ready() -> void:
	GlobalSignals.player_picked_up_weapon.connect(pick_up_weapon)
	for child in get_children():
		if child is Weapon:
			var Slot : String = "Slot %s" % [count]
			player_backpack.set(Slot,child)
			print("%s in %s" % [child.name,Slot])
			
			child.interactable_zone.interaction_disable()
			child.interactable_zone.disable_interact_area()
			child.slot_index = Slot
			count += 1
			if count == 3:
				break
			


func get_weapon(index : String):
	return player_backpack.get(index)

func pick_up_weapon(new_weapon_data : WeaponData)->void:
	if !active_weapon:
		# do sth
		return 
	drop_active_weapon()
	var new_weapon : Weapon = load(new_weapon_data.weapon_scene_path).instantiate() as Weapon
	new_weapon.interactable_zone.interaction_disable()
	new_weapon.interactable_zone.disable_interact_area()
	new_weapon.weapon_data = new_weapon_data
	new_weapon.slot_index = active_weapon.slot_index
	player_backpack.set(active_weapon.slot_index,new_weapon)
	
	active_weapon.queue_free()
	
	active_weapon = new_weapon
	add_child(new_weapon)
	FSM.force_transition_to(active_weapon.slot_index)
	

func drop_active_weapon():
	var dropped_weapon : Weapon = load(active_weapon.weapon_data.weapon_scene_path).instantiate() as Node2D
	get_tree().current_scene.add_child(dropped_weapon)
	dropped_weapon.weapon_data = active_weapon.weapon_data
	dropped_weapon.global_position = player.global_position
	dropped_weapon.interactable_zone.enable_interact_area()
	dropped_weapon.interactable_zone.interaction_disable()

	
