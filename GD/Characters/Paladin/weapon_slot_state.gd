extends NodeState


@export_category("Primary Attack Paladin State")
@export var characterbody2d : CharacterBody2D
@export var velocity_component : Node2D
@export var Inventory : InventorySystem
@export var slot_index : String = "Slot 1"
@export var weapon_pivot : Marker2D
@export var FSM : NodeFiniteStateMachine

var weapon : Weapon
var weapon_direction : Vector2

	
func on_process(_delta : float):
	weapon_direction  = characterbody2d.mouse_direction
	velocity_component.get_input()
	animation_change_with_weapon()
	setup()

func enter():
	weapon_direction  = characterbody2d.mouse_direction
	velocity_component.speed_modifier = 0.9
	
	weapon = Inventory.get_weapon(slot_index)
	if !weapon:
		FSM.transition_to("idle")
	else:
		weapon.show()
	
	for child in Inventory.player_backpack.values():
		if child:
			if child == weapon:
				continue
			child.visible = false

	if !weapon:
		return
	else:	
		Inventory.active_weapon_slot = weapon.slot_index
		weapon.in_state = true
		setup()
		if weapon is MeleeWeapon:
			characterbody2d.can_turn = false
		if !GlobalSignals.player_turned.is_connected(setup):
			GlobalSignals.player_turned.connect(setup)
	
func exit():
	if !weapon:
		return
	else:
		weapon.in_state = false
		#weapon.visible = false
		weapon = null
		characterbody2d.can_turn = true
		velocity_component.speed_modifier = 1.0
		animation_player.stop()

	
	
	
func melee_setup(paladin_weapon : MeleeWeapon)->void:
	paladin_weapon.setup_weapon_paladin(weapon_direction,characterbody2d,weapon_pivot,slot_index)
	
func projectile_setup(paladin_weapon : ProjectileWeapon)->void:
	paladin_weapon.setup_gun_paladin(weapon_direction,characterbody2d,weapon_pivot,slot_index)
	
func setup(message : String = '')->void:
	if Inventory.player_backpack.get(slot_index):
		var weapon_thing : Weapon = Inventory.player_backpack.get(slot_index)
		if weapon_thing is MeleeWeapon:
			melee_setup(weapon_thing)
		elif weapon_thing is ProjectileWeapon:
			projectile_setup(weapon_thing)
		if message != '':
			print(message)
	
func animation_change_with_weapon()->void:
	if velocity_component.move_direction.length() > 0 :  
		animation_player.play("run")
	else:
		animation_player.play("idle")
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
