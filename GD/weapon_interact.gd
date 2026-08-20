extends Interactable

var is_on_ground : bool = true
var player : Paladin
@export var weapon : ProjectileWeapon

func _ready() -> void:
	player = PlayerManager.player

func interact():
	var Inventory : InventorySystem = player.Inventory
	if !Inventory:
		print("Player does not exist")
		return
	Inventory.pick_up_weapon(weapon.weapon_data)
	weapon.queue_free()
	
	
