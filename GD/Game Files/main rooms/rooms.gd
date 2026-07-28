extends Node2D

const SPAWN_EXPLOSION_SCENE : PackedScene = preload("res://Game Files/character_explosion.tscn")
const ENEMY_SCENES: Dictionary = {
		"FLYING CREATURE" : preload("res://Characters/flying Animal/flyingEnemy.tscn")
		
}

var num_enemies: int
@onready var ground: TileMapLayer = $NavigationRegion2D/Ground
@onready var wall: TileMapLayer = $NavigationRegion2D/wall
@onready var floor_objects: TileMapLayer = $"NavigationRegion2D/floor objects"
@onready var wall_objects: TileMapLayer = $"NavigationRegion2D/wall objects"
@onready var doors: Node2D = $Doors
@onready var enemy_positions: Node2D = $Enemy_Positions
@onready var player_detection: Area2D = $Player_Detection
@onready var entrance: Node2D = $Entrance

func _ready() -> void:
	num_enemies  = enemy_positions.get_child_count()

func _open_doors()->void:
	for door in doors.get_children():
		if door is StaticBody2D:
			door.open()
			
			
func _close_entrance()->void:
	var left_entry : Marker2D
	var right_entry : Marker2D
	if entrance.get_child_count() > 2:
		printerr("Many entrance marker 2d is not handled")
	assert(entrance.get_child_count() == 2)
	
	
	if entrance.get_child(0).global_position.x - entrance.get_child(1).global_position.x > 0:
		right_entry = entrance.get_child(0)
		left_entry = entrance.get_child(1)
	else:
		right_entry = entrance.get_child(1)
		left_entry = entrance.get_child(0)
		
	var coords = ground.local_to_map(left_entry.global_position)
	wall.set_cell(coords,0,Vector2i(7,6))
	
	coords = ground.local_to_map(right_entry.global_position)
	wall.set_cell(coords,0,Vector2i(8,6))
	
	for door in doors.get_children():
		if door is StaticBody2D:
			door.close()

func _spawn_enemies(markers : Marker2D) -> void:
	var spawn_explosion_instance : Node2D = SPAWN_EXPLOSION_SCENE.instantiate() as Node2D
	spawn_explosion_instance.global_position = markers.global_position
	call_deferred("add_child", spawn_explosion_instance)
	
	var timer : Timer = Timer.new()
	timer.wait_time = spawn_explosion_instance.animation_time + 0.5
	timer.one_shot = true
	timer.timeout.connect(on_spawn_explosion_timeout.bind(markers))
	add_child(timer)
	timer.start()
	
	

func on_enemy_killed()->void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()
		
func on_spawn_explosion_timeout(markers : Marker2D):
	var enemy_instance : CharacterBody2D = ENEMY_SCENES.get("FLYING CREATURE").instantiate() as CharacterBody2D
	enemy_instance.global_position = markers.global_position
	enemy_instance.tree_exited.connect(on_enemy_killed)
	call_deferred("add_child", enemy_instance)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("PLAYER"):
		player_detection.queue_free()
		_close_entrance()
		for markers in enemy_positions.get_children():
			_spawn_enemies(markers)
