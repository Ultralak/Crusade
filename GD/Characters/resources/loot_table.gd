class_name LootTable
extends Resource

@export var entries: Array[LootItem] = []


func pick_loot_item() -> LootItem:
	if entries.is_empty():
		return null

	var total_weight: float = 0.0
	for entry in entries:
		if entry:
			total_weight += entry.weight

	if total_weight <= 0.0:
		return null

	var roll: float = randf() * total_weight
	var current_weight: float = 0.0

	for entry in entries:
		if not entry:
			continue
		current_weight += entry.weight
		if roll <= current_weight:
			return entry

	return entries[0]


func pick_unique_loot_items(count: int) -> Array[LootItem]:
	var results: Array[LootItem] = []
	if entries.is_empty() or count <= 0:
		return results

	var pool: Array[LootItem] = entries.duplicate()

	while results.size() < count and not pool.is_empty():
		var total_weight: float = 0.0
		for entry in pool:
			if entry:
				total_weight += entry.weight

		if total_weight <= 0.0:
			break

		var roll: float = randf() * total_weight
		var current_weight: float = 0.0
		var selected_index: int = -1

		for i in range(pool.size()):
			var entry: LootItem = pool[i]
			if not entry:
				continue
			current_weight += entry.weight
			if roll <= current_weight:
				selected_index = i
				break

		if selected_index != -1:
			results.append(pool[selected_index])
			pool.remove_at(selected_index)
		else:
			break

	return results
