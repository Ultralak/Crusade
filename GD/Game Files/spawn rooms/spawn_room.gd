extends Node2D
class_name SPAWNROOM
var PLAYER : PackedScene = preload("res://Characters/Paladin/player.tscn")
@onready var doors: Node2D = $Doors
@onready var player_spawn_position: Node2D = $player_spawn_position
@export var player : CharacterBody2D
@onready var player_detection: Area2D = $Player_Detection
@onready var ground: TileMapLayer = $Ground
@onready var floor_objects: TileMapLayer = $"floor objects"
@onready var wall: TileMapLayer = $wall
@onready var roof_top: TileMapLayer = $"roof top"
@onready var wall_objects: TileMapLayer = $"wall objects"
@onready var left: Marker2D = $exit/left
@onready var right: Marker2D = $exit/right
const TILE_SIZE = 16

func test()->void:
	var tile_num : int = randi_range(3,7)
	for i in tile_num:
		change_tile_at_position(ground,left.global_position + Vector2.UP * i * TILE_SIZE,Vector2i(3,1))
		change_tile_at_position(ground,right.global_position + Vector2.UP * i * TILE_SIZE,Vector2i(3,1))
	for i in tile_num - 2:
		change_tile_at_position(wall,left.global_position + Vector2.UP * (i + 2)* TILE_SIZE + Vector2.LEFT * TILE_SIZE,Vector2i(4,5))
		change_tile_at_position(wall, right.global_position + Vector2.UP * (i + 2) * TILE_SIZE + Vector2.RIGHT * TILE_SIZE ,Vector2i(3,5))

	
func _ready() -> void:
	if !player:
		player = PlayerManager.player
		#var player_instance : CharacterBody2D = PLAYER.instantiate() as CharacterBody2D
		

		# TODO : Check to make sure player is added to scene correctly
		
		#get_parent().call_deferred("add_child",player_instance)
	player.global_position = player_spawn_position.get_child(0).global_position
	call_deferred("close_door")
	# Spawn Logic
func open_door()->void:
	for door in doors.get_children():
		if door is StaticBody2D:
			door.open()
	test()

func close_door()->void:
	for door in doors.get_children():
		if door is StaticBody2D:
			door.close()
			

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("PLAYER"):
		player_detection.queue_free()
		open_door()

func change_tile_at_position(layer : TileMapLayer, position : Vector2, atlasTextureCoords : Vector2i) -> void:
	var coordinates = layer.local_to_map(position)
	layer.set_cell(coordinates ,0,atlasTextureCoords)
