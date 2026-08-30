class_name ChestSpawnerComponent
extends Node2D

@export var chest_pool: Array[ChestDropData] = []
@export var spawn_marker: Marker2D
@export var detect: Area2D


func _ready() -> void:
	if is_instance_valid(detect):
		detect.monitorable = false
		detect.monitoring = false


func spawn_chest() -> void:
	if chest_pool.is_empty():
		return

	var sorted_pool = chest_pool.duplicate()
	sorted_pool.sort_custom(func(a: ChestDropData, b: ChestDropData): return a.spawn_chance < b.spawn_chance)

	var selected_chest_scene: PackedScene = null

	for data in sorted_pool:
		var roll = randf()
		if roll <= data.spawn_chance:
			selected_chest_scene = data.chest_scene
			break

	if not selected_chest_scene and not sorted_pool.is_empty():
		selected_chest_scene = sorted_pool.back().chest_scene

	if selected_chest_scene:
		var chest_instance = selected_chest_scene.instantiate() as Node2D
		
		var spawn_pos: Vector2 = position
		if is_instance_valid(spawn_marker):
			spawn_pos = spawn_marker.position
			
		chest_instance.position = spawn_pos
		get_parent().add_child.call_deferred(chest_instance)
