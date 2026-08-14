extends Node2D
class_name InventorySystem

var player_backpack : Dictionary[String,Node2D]

var count : int = 1
func _ready() -> void:
	for child in get_children():
		if child is ProjectileWeapon or child is MeleeWeapon:
			var Slot : String = "Slot %s" % [count]
			player_backpack.set(Slot,child)
			print("%s in %s" % [child.name,Slot])
			count += 1
			if count == 3:
				break
				
			child.slot_index = Slot
	GlobalSignals.player_picked_up_weapon.connect(add_weapon_backpack_slot_available)
			
			
func add_weapon_backpack_slot_available()->void:
	# techically for when player picks up weapon. need concept of active weapon
	# for now just add in available slot
	for child in get_children():
		if child is ProjectileWeapon or child is MeleeWeapon:
			for i in range(player_backpack.size()):
				var Slot : String = "Slot %s" % [i + 1]
				if player_backpack.get(Slot):
					continue
				
	
func remove_weapon_backpack(weapon : Node2D)->void:
	if player_backpack.has(weapon):
		player_backpack.erase(weapon)
		count -= 1
		# add extra stuff

func get_weapon(index : String):
	return player_backpack.get(index)


	
