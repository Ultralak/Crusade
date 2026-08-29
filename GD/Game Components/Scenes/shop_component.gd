class_name ShopComponent
extends Node2D

@export var loot_table: LootTable
@export var spawn_positions: Array[Marker2D] = []
@export var detect: Area2D


func _ready() -> void:
	if detect:
		detect.monitorable = false
		detect.monitoring = false
	spawn_shop_items()


func spawn_shop_items() -> void:
	if not loot_table or spawn_positions.is_empty():
		return

	for marker in spawn_positions:
		if not is_instance_valid(marker):
			continue

		var chosen_loot: LootItem = loot_table.pick_loot_item()
		if not chosen_loot or not chosen_loot.item_scene:
			continue

		var pickup_instance = chosen_loot.item_scene.instantiate()
		marker.add_child(pickup_instance)
		pickup_instance.position = Vector2.ZERO

		if chosen_loot.item_data:
			if pickup_instance.has_method("setup_item"):
				pickup_instance.setup_item(chosen_loot.item_data)
			elif "item_data" in pickup_instance:
				pickup_instance.item_data = chosen_loot.item_data
			elif "weapon_data" in pickup_instance:
				pickup_instance.weapon_data = chosen_loot.item_data
