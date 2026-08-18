extends Node2D
class_name InventorySystem


@export var FSM : NodeFiniteStateMachine
var player_backpack : Dictionary[String,Node2D]
var active_weapon : Weapon
var count : int = 1


func _ready() -> void:
	GlobalSignals.player_picked_up_weapon.connect(pick_up_weapon)
	for child in get_children():
		if child is Weapon:
			var Slot : String = "Slot %s" % [count]
			player_backpack.set(Slot,child)
			print("%s in %s" % [child.name,Slot])
			count += 1
			child.disable_interact_area()
			child.is_on_ground = false
			if count == 3:
				break
			
			child.slot_index = Slot
	GlobalSignals.player_picked_up_weapon.connect(add_weapon_backpack_slot_available)
			
			
func add_weapon_backpack_slot_available()->void:
	# techically for when player picks up weapon. need concept of active weapon
	# for now just add in available slot
	for child in get_children():
		if child is Weapon:
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

func pick_up_weapon(weapon : Weapon)->void:
	for child in get_children():
		if child is Weapon:
			if child.is_in_active_slot:
				child.replace_by(weapon)
				FSM.transition_to("idle")
	
	
