class_name ChestSpawnerComponent
extends Node2D

@export var chest_pool: Array[ChestDropData] = []
@export var spawn_markers: Array[Marker2D] = []
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

	var valid_markers: Array[Marker2D] = []
	for marker in spawn_markers:
		if is_instance_valid(marker):
			valid_markers.append(marker)

	if valid_markers.is_empty():
		_roll_and_spawn_at_position(position, sorted_pool)
	else:
		for marker in valid_markers:
			_roll_and_spawn_at_position(marker.position, sorted_pool)


func _roll_and_spawn_at_position(spawn_pos: Vector2, sorted_pool: Array[ChestDropData]) -> void:
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
		chest_instance.position = spawn_pos
		get_parent().add_child.call_deferred(chest_instance)
