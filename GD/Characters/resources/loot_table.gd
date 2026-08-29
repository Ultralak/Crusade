class_name LootTable
extends Resource

@export var entries: Array[LootItem] = []


func pick_loot_item() -> LootItem:
	if entries.is_empty():
		return null

	var total_weight: int = 0
	for entry in entries:
		if entry and entry.item_scene:
			total_weight += entry.weight

	if total_weight <= 0:
		return null

	var roll: float = randf_range(0.0, total_weight)
	var current_sum: float = 0.0

	for entry in entries:
		if not entry or not entry.item_scene:
			continue

		current_sum += entry.weight
		if roll <= current_sum:
			return entry

	return entries[0]
