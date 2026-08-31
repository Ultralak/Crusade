class_name SpawnComponent
extends Node2D

signal wave_started(wave_index: int)
signal wave_cleared(wave_index: int)
signal all_waves_cleared

@export var dungeon: BaseDungeon
@export var enemy_scenes: Array[PackedScene] = []
@export var spawn_explosion_scene: PackedScene
@export var explosion_duration: float = 0.5
@export var max_waves: int = 3

var current_wave_index: int = 0
var active_enemies: int = 0
var wave_containers: Array[Node] = []


func start_spawning() -> void:
	if dungeon and (dungeon.floor_event == BaseDungeon.DUNGEONEVENT.treasure or dungeon.floor_event == BaseDungeon.DUNGEONEVENT.shop):
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
	for child in get_children():
		if child.get_child_count() > 0 and _has_valid_markers(child):
			wave_containers.append(child)
			if wave_containers.size() == max_waves:
				break


func _has_valid_markers(container: Node) -> bool:
	for sub_child in container.get_children():
		if sub_child is Marker2D:
			return true
	return false


func spawn_current_wave() -> void:
	if current_wave_index >= wave_containers.size():
		all_waves_cleared.emit()
		return

	wave_started.emit(current_wave_index)
	var current_container = wave_containers[current_wave_index]
	var valid_markers: Array[Marker2D] = []

	for child in current_container.get_children():
		if child is Marker2D:
			valid_markers.append(child)

	if valid_markers.is_empty():
		advance_wave()
		return

	active_enemies = valid_markers.size()

	for marker in valid_markers:
		_spawn_enemy_with_telegraph(marker)


func _spawn_enemy_with_telegraph(marker: Marker2D) -> void:
	if not is_inside_tree() or not is_instance_valid(marker):
		_register_enemy_death()
		return

	var target_position = marker.global_position

	if spawn_explosion_scene:
		var explosion_instance = spawn_explosion_scene.instantiate() as Node2D
		get_parent().add_child(explosion_instance)
		explosion_instance.global_position = target_position

	var timer = get_tree().create_timer(explosion_duration)
	await timer.timeout

	if not is_inside_tree() or not is_instance_valid(marker):
		_register_enemy_death()
		return

	var enemy_scene = enemy_scenes.pick_random()
	if enemy_scene:
		var enemy_instance = enemy_scene.instantiate() as Node2D
		enemy_instance.z_index = 1
		enemy_instance.tree_exited.connect(_on_enemy_tree_exited)
		get_parent().add_child(enemy_instance)
		enemy_instance.global_position = target_position
	else:
		_register_enemy_death()


func _on_enemy_tree_exited() -> void:
	_register_enemy_death()


func _register_enemy_death() -> void:
	active_enemies -= 1
	print("Enemies left is  : %s" % active_enemies)
	if active_enemies <= 0:
		wave_cleared.emit(current_wave_index)
		advance_wave()


func advance_wave() -> void:
	current_wave_index += 1
	if current_wave_index < wave_containers.size():
		spawn_current_wave()
	else:
		all_waves_cleared.emit()
		print("all waves cleared emitted")
