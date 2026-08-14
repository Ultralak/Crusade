extends NodeState


@export_category("Primary Attack Paladin State")
@export var characterbody2d : CharacterBody2D
@export var velocity_component : Node2D
@export var Inventory : InventorySystem
@export var slot_index : String = "Slot 1"
@export var weapon_pivot : Marker2D
var weapon : Node2D
var weapon_direction : Vector2

#frame by frame
func on_process(_delta : float):
	weapon_direction  = characterbody2d.mouse_direction
	velocity_component.get_input()
	
	
	if velocity_component.move_direction.length() > 0 :  
		animation_player.play("run")
	else:
		animation_player.play("idle")
		
	if weapon is MeleeWeapon:
		melee_setup(weapon)
	elif weapon is ProjectileWeapon:
		projectile_setup(weapon)

func enter():
	weapon_direction  = characterbody2d.mouse_direction
	velocity_component.speed_modifier = 0.9
	
	weapon = Inventory.get_weapon(slot_index)
	if weapon :
		weapon.in_state = true
	if weapon is MeleeWeapon:
		characterbody2d.can_turn = false
		melee_setup(weapon)
	elif weapon is ProjectileWeapon:
		projectile_setup(weapon)
	weapon.show()

	
func exit():
	if weapon:
		weapon.in_state = false
	weapon.visible = false
	weapon = null
	characterbody2d.can_turn = true
	velocity_component.speed_modifier = 1.0
	animation_player.stop()
	
func melee_setup(paladin_weapon : MeleeWeapon)->void:
	paladin_weapon.setup_weapon_paladin(weapon_direction,characterbody2d,weapon_pivot,slot_index)
	
func projectile_setup(paladin_weapon : ProjectileWeapon)->void:
	paladin_weapon.setup_gun_paladin(weapon_direction,characterbody2d,weapon_pivot,slot_index)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
