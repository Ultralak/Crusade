extends Node2D

const SPAWN_EXPLOSION_SCENE : PackedScene = preload("res://Game Files/character_explosion.tscn")
const ENEMY_SCENES: Dictionary = {
		"FLYING CREATURE" : preload("res://Characters/flying Animal/flyingEnemy.tscn")
		
}

var num_enemies: int
@onready var ground: TileMapLayer = $Ground
@onready var wall: TileMapLayer = $wall
@onready var objects: TileMapLayer = $objects
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
	wall.set_cell(coords,0,Vector2i(7,6))

func _spawn_enemies() -> void:
	for positions in enemy_positions.get_children():
		var enemy : CharacterBody2D = ENEMY_SCENES.FLYING_CREATURE.instantiate() as Node2D
		enemy.global_position = positions.global_position
		add_child(enemy)
		
		
		
		
