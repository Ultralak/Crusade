extends Node2D
class_name InventorySystem



var player_backpack : Dictionary[int,PackedScene]
var count : int = 0
func _ready() -> void:
	for child in get_children():
		if child is ProjectileWeapon or child is MeleeWeapon:
			player_backpack.set(count % 2,child)
			count += 1
			child.slot_index = count
	GlobalSignals.player_picked_up_weapon.connect(add_weapon_backpack)
			
			
func add_weapon_backpack()->void:
	for child in get_children():
		if child is ProjectileWeapon or child is MeleeWeapon:
			if !player_backpack.values().has(child):
				player_backpack.set(count % 2, child)
				count += 1
	
func remove_weapon_backpack(weapon : Node2D)->void:
	if player_backpack.has(weapon):
		player_backpack.erase(weapon)
		count -= 1
		# add extra stuff

func get_weapon(index : int):
	return player_backpack.get(index)


	
	
	
	
	
	
	
	
	
	
	
	pass
