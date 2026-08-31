extends Interactable

@export var weapon: ProjectileWeapon

var is_on_ground: bool = true
var player: Paladin


func _ready() -> void:
	player = PlayerManager.player
	if weapon:
		if weapon.weapon_user is Enemy:
			set_collision_layer_value(7, false)
