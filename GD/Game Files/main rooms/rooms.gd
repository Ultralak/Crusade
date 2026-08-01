extends Node2D
class_name INTERROOM
const SPAWN_EXPLOSION_SCENE : PackedScene = preload("res://Game Files/character_explosion.tscn")
enum ENEMYTYPE {FLYING, RANGE}
const ENEMY_SCENES: Dictionary = {
		ENEMYTYPE.FLYING : preload("res://Characters/flying Animal/flyingEnemy.tscn")
		
}

var num_enemies: int
var prev_player_z_index : int
var entrance_closed : bool = false
@export var wall_tile_atlas: Vector2i
@onready var ground: TileMapLayer = $NavigationRegion2D/Ground
@onready var wall: TileMapLayer = $NavigationRegion2D/wall
@onready var floor_objects: TileMapLayer = $"NavigationRegion2D/floor objects"
@onready var wall_objects: TileMapLayer = $"NavigationRegion2D/wall objects"
@onready var doors: Node2D = $Doors
@onready var enemy_positions: Node2D = $Enemy_Positions
@onready var player_detection: Area2D = $Player_Detection
@onready var entrance: Node2D = $Entrance
@onready var left: Marker2D = $Entrance/left
@onready var right: Marker2D = $Entrance/right
@onready var door: StaticBody2D = $Doors/Door

func _ready() -> void:
	num_enemies  = enemy_positions.get_child_count()

func _open_doors()->void:
	for door in doors.get_children():
		if door is StaticBody2D:
			door.open()
	if entrance_closed:
		var coords = ground.local_to_map(left.global_position)
		wall.set_cell(coords,-1,Vector2i(7,6))
		
		coords = ground.local_to_map(right.global_position)
		wall.set_cell(coords,-1,Vector2i(8,6))
			
			
func _close_entrance()->void:
	entrance_closed = true

	var coords = ground.local_to_map(left.global_position)
	wall.set_cell(coords,0,Vector2i(7,6))
	
	coords = ground.local_to_map(right.global_position)
	wall.set_cell(coords,0,Vector2i(8,6))
	
	for door in doors.get_children():
		if door is StaticBody2D:
			door.close()


func _close_entrance_DEPRACATED()->void:
	for door in doors.get_children():
		if door is StaticBody2D:
			door.close()
			
			
func _spawn_enemies(markers : Marker2D) -> void:
	var spawn_explosion_instance : Node2D = SPAWN_EXPLOSION_SCENE.instantiate() as Node2D
	spawn_explosion_instance.global_position = markers.global_position
	add_child(spawn_explosion_instance)
	
	await get_tree().create_timer(spawn_explosion_instance.animation_time + 0.3).timeout
	
	if is_instance_valid(markers) and is_inside_tree():
		var enemy_instance : CharacterBody2D = ENEMY_SCENES.get(ENEMYTYPE.FLYING).instantiate() as CharacterBody2D
		enemy_instance.global_position = markers.global_position
		enemy_instance.enemy_killed.connect(on_enemy_killed)
		call_deferred("add_child", enemy_instance)


func on_enemy_killed(_enemy : CharacterBody2D)->void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()
		
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("PLAYER"):
		player_detection.queue_free()
		_close_entrance()
		for markers in enemy_positions.get_children():
			_spawn_enemies(markers)
