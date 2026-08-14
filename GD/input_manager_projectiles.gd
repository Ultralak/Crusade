extends Node2D

@export var weapon : ProjectileWeapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_default_attacking():
		weapon.shoot()

func is_default_attacking() -> bool:
	if weapon.slot_index == "Slot 1": 
		return Input.is_action_pressed("slot_1")
	if weapon.slot_index == "Slot 2":
		return Input.is_action_pressed("slot_2")
	return false
