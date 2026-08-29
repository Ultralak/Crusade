extends Node2D
class_name InventorySystem


@export var FSM : NodeFiniteStateMachine
@export var player : Paladin
var player_backpack : Dictionary[String,ProjectileWeapon] = {
	"Slot 1" : null,
	"Slot 2" : null
}
var active_weapon_slot : String
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
			child.purchase_component.delete()
			count += 1
			if count == 3:
				break
	active_weapon_slot = "Slot 1"


func get_weapon(index : String):
	return player_backpack.get(index)

func pick_up_weapon(new_weapon_data : WeaponData)->void:
	if empty_slots():
		add_weapon_to_slot(new_weapon_data,find_first_empty_slot())
	else:
		drop_active_weapon()
		add_weapon_to_slot(new_weapon_data, active_weapon_slot)
	
	
	
func add_weapon_to_slot(weapon_data : WeaponData, Slot : String)->void:
	var new_weapon : Weapon = load(weapon_data.weapon_scene_path).instantiate() as Weapon
	add_child(new_weapon)
	player_backpack.set(Slot,new_weapon)
	
	new_weapon.interactable_zone.interaction_disable()
	new_weapon.interactable_zone.disable_interact_area()
	new_weapon.slot_index = Slot
	new_weapon.purchase_component.delete()
	active_weapon_slot = Slot
	new_weapon.visible = false
	

func drop_active_weapon():
	var active_weapon : Weapon = player_backpack.get(active_weapon_slot)
	var dropped_weapon : Weapon = load(active_weapon.weapon_data.weapon_scene_path).instantiate() as Weapon
	for child in get_children():
		if child == active_weapon:
			remove_child(child)
			child.queue_free()
			break
	player_backpack.set(active_weapon_slot, null)
	get_tree().current_scene.add_child(dropped_weapon)
	
	
	dropped_weapon.interactable_zone.interaction_disable()
	dropped_weapon.interactable_zone.enable_interact_area()
	dropped_weapon.global_position = player.global_position
	dropped_weapon.purchase_component.delete()

	
func empty_slots()->bool:
	for slot in player_backpack.keys():
		if player_backpack.get(slot) == null:
			return true
	return false
	
func find_first_empty_slot()->String:
	for slot in player_backpack.keys():
		if player_backpack.get(slot) == null:
			return slot
	return ""
