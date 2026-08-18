extends Node2D

@export var weapon : ProjectileWeapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if weapon_input():
		weapon.shoot()

func is_default_attacking() -> bool:
	if weapon.slot_index == "Slot 1": 
		return Input.is_action_pressed("slot_1")
	if weapon.slot_index == "Slot 2":
		return Input.is_action_pressed("slot_2")
	return false
	

func weapon_input()->bool:
	return is_default_attacking() != enemy_attacking()

func enemy_attacking()->bool:
	if weapon.weapon_user:
		if weapon.weapon_user is Enemy:
			var user : Enemy = weapon.weapon_user
			if user.FSM.current_node_state_name == "shoot":
				return true
	return false

func player_picked_up_weapon()->void:
	pass
