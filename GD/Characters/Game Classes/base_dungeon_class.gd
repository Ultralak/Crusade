extends Node2D
class_name BaseDungeon

@export var Enemies : Array[PackedScene]

@onready var ground: TileMapLayer = $ground
@onready var ground_objects: TileMapLayer = $ground_objects
@onready var wall: TileMapLayer = $wall
@onready var enemy_spawn: Node2D = $"Enemy Spawn"
@onready var player_detect: Area2D = $PlayerDetect

var active_enemies: int = 0
func _ready() -> void:
	wall.open()
	

func _on_player_detect_area_entered(area: Area2D) -> void:
	wall.close()
	player_detect.call_deferred("queue_free")
	spawn_enemies()


func spawn_enemies() -> void:
	if Enemies.is_empty():
		wall.open()
		return
		
	var spawn_markers = enemy_spawn.get_children()
	if spawn_markers.is_empty():
		wall.open()
		return
		
	for marker in spawn_markers:
		var enemy_scene = Enemies.pick_random()
		if enemy_scene:
			var enemy_instance = enemy_scene.instantiate()
			enemy_instance.global_position = marker.global_position
			enemy_instance.tree_exited.connect(_on_enemy_tree_exited)
			active_enemies += 1
			add_child(enemy_instance)
			
	if active_enemies == 0:
		wall.open()


func _on_enemy_tree_exited() -> void:
	active_enemies -= 1
	if active_enemies <= 0:
		wall.open()


func apply_door_states(has_top: bool, has_bottom: bool, has_left: bool, has_right: bool) -> void:
	var up_marker = $exit/up
	var down_marker = $exit/down
	var left_marker = $exit/left
	var right_marker = $exit/right

	if up_marker and up_marker is DoorMarker:
		up_marker.activated = has_top
	if down_marker and down_marker is DoorMarker:
		down_marker.activated = has_bottom
	if left_marker and left_marker is DoorMarker:
		left_marker.activated = has_left
	if right_marker and right_marker is DoorMarker:
		right_marker.activated = has_right

	wall.setup_room_walls()
