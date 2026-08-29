extends Interactable

@export var weapon: ProjectileWeapon

var is_on_ground: bool = true
var player: Paladin


func _ready() -> void:
	player = PlayerManager.player
