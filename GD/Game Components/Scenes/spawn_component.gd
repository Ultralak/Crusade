class_name SpawnComponent
extends Node2D

signal wave_started(wave_index: int)
signal wave_cleared(wave_index: int)
signal all_waves_cleared

@export var dungeon : BaseDungeon
@export var enemy_scenes: Array[PackedScene] = []
@export var spawn_explosion_scene: PackedScene
@export var explosion_duration: float = 0.5
@export var max_waves: int = 3

var current_wave_index: int = 0
var active_enemies: int = 0
var wave_containers: Array[Node] = []


func start_spawning() -> void:
	if dungeon.floor_event == BaseDungeon.DUNGEONEVENT.treasure or dungeon.floor_event == BaseDungeon.DUNGEONEVENT.shop:
		all_waves_cleared.emit()
		return

	collect_wave_containers()

	if wave_containers.is_empty() or enemy_scenes.is_empty():
		all_waves_cleared.emit()
		return

	current_wave_index = 0
	spawn_current_wave()


func collect_wave_containers() -> void:
	wave_containers.clear()
	var children = get_children()
	var count = min(children.size(), max_waves)
	for i in range(count):
		wave_containers.append(children[i])


func spawn_current_wave() -> void:
	if current_wave_index >= wave_containers.size():
		all_waves_cleared.emit()
		return

	wave_started.emit(current_wave_index)
	var current_container = wave_containers[current_wave_index]
	var markers = current_container.get_children()

	active_enemies = 0

	for marker in markers:
		if marker is Marker2D:
			active_enemies += 1
			_spawn_enemy_with_telegraph(marker)

	if active_enemies == 0:
		advance_wave()


func _spawn_enemy_with_telegraph(marker: Marker2D) -> void:
	if not is_inside_tree():
		return

	var target_position = marker.global_position

	if spawn_explosion_scene:
		var explosion_instance = spawn_explosion_scene.instantiate() as Node2D
		get_parent().add_child(explosion_instance)
		explosion_instance.global_position = target_position

	var tree = get_tree()
	if not tree:
		return

	await tree.create_timer(explosion_duration).timeout

	if not is_inside_tree() or not is_instance_valid(marker):
		active_enemies -= 1
		if active_enemies <= 0:
			wave_cleared.emit(current_wave_index)
			advance_wave()
		return

	var enemy_scene = enemy_scenes.pick_random()
	if enemy_scene:
		var enemy_instance = enemy_scene.instantiate() as Node2D
		enemy_instance.z_index = 1
		enemy_instance.tree_exited.connect(_on_enemy_tree_exited)
		get_parent().add_child(enemy_instance)
		enemy_instance.global_position = target_position


func _on_enemy_tree_exited() -> void:
	active_enemies -= 1
	if active_enemies <= 0:
		wave_cleared.emit(current_wave_index)
		advance_wave()


func advance_wave() -> void:
	current_wave_index += 1
	if current_wave_index < wave_containers.size():
		spawn_current_wave()
	else:
		all_waves_cleared.emit()
