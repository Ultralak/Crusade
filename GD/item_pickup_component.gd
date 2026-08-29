class_name ItemPickupComponent
extends Node2D

signal item_picked_up

@export var interactable: Interactable
@export var weapon: Weapon
@export var purchase: PurchaseComponent


func _ready() -> void:
	
	if interactable and not purchase:
		interactable.interacted.connect(_on_interacted)
	else:
		purchase.purchase_succeeded.connect(_on_interacted)


func _on_interacted() -> void:
	var player = PlayerManager.get_player()
	if player:
		grant_item(player)


func grant_item(player: CharacterBody2D) -> bool:
	if not weapon or not player.get("Inventory"):
		return false

	var inventory = player.Inventory
	if inventory and inventory.has_method("pick_up_weapon"):
		inventory.pick_up_weapon(weapon.weapon_data)
		item_picked_up.emit()
		weapon.queue_free()
		return true

	return false
