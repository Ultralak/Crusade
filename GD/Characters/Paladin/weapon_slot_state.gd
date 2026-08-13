extends NodeState


@export_category("Primary Attack Paladin State")
@export var characterbody2d : CharacterBody2D
@export var velocity_component : Node2D
@export var Inventory : InventorySystem
@export var slot_index : int = 0

var weapon : Node2D

#frame by frame
func on_process(_delta : float):
	velocity_component.get_input()
	if velocity_component.move_direction.length() > 0 :  
		animation_player.play("run")
	else:
		animation_player.play("idle")

func enter():
	velocity_component.speed_modifier = 0.9
	
	weapon = Inventory.get_weapon(slot_index)
	if weapon :
		weapon.in_state = true
	if weapon is MeleeWeapon:
		characterbody2d.can_turn = false

	
func exit():
	if weapon:
		weapon.in_state = false
	weapon = null
	characterbody2d.can_turn = true
	velocity_component.speed_modifier = 1.0
	animation_player.stop()
	
func melee_setup(weapon : MeleeWeapon)->void:
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
