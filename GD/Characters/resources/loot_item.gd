class_name LootItem
extends Resource

@export var item_data: Resource
@export var item_scene: PackedScene
@export_range(1, 1000, 1) var weight: int = 100
