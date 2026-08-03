extends Node2D

const SPAWN_ROOMS : Array[PackedScene] =[preload("res://Game Files/spawn rooms/spawn_room_0.tscn"),
							preload("res://Game Files/spawn rooms/spawn_room_1.tscn"),
							preload("res://Game Files/spawn rooms/spawn_room_2.tscn")]
const INTERMEDIATE_ROOMS : Array[PackedScene]  = [preload("res://Game Files/main rooms/room_0.tscn"),
									preload("res://Game Files/main rooms/rooms_1.tscn"),
									preload("res://Game Files/main rooms/room_2.tscn"),
									preload("res://Game Files/main rooms/room_3.tscn")]
const END_ROOM : Array[PackedScene]  = [preload("res://Game Files/end rooms/End_Room.tscn")]
const TILESIZE : int = 16


@export var num_levels : int = 5
@export var floor_atlas_coords : Vector2i
@export var left_wall_atlas_coords : Vector2i
@export var right_wall_atlas_coords : Vector2i


var prev_room_tilemap_ground : TileMapLayer
var prev_room_tilemap_roof : TileMapLayer
var curr_room_tilemap_ground : TileMapLayer
var previous_room : Node = null
var current_room : Node = null
var previous_room_door : StaticBody2D 
# player is already handled in spawn room script

func _ready() -> void:
	_spawn_rooms()
	
	
func _spawn_rooms()->void:
	for i in num_levels:
		if i == 0:
			current_room = SPAWN_ROOMS.pick_random().instantiate() as Node2D
			add_child(current_room)
		elif 0 < i and i < num_levels - 1:
			current_room = INTERMEDIATE_ROOMS.pick_random().instantiate() as Node2D
			add_child(current_room)
		else:
			current_room = END_ROOM.pick_random().instantiate() as Node2D
			add_child(current_room)
				
		var path_length : int = randi_range(5,9)
		# eventually i will have hallways build themselves up by using a seperate tilemaplayer scene for hallways
		# need a new tileset though
		var hallway_end : Vector2 
		
		if i == 0:
			pass
		else:
			if previous_room is SPAWNROOM:
				create_bridge(path_length, previous_room.ground, previous_room.roof_top, previous_room.left.global_position, previous_room.right.global_position)
				hallway_end = previous_room.center.global_position + Vector2.UP * (path_length * TILESIZE)
			elif previous_room is INTERROOM:
				var left_position : Vector2 = previous_room.door.position + (Vector2.LEFT + Vector2.UP)  * TILESIZE/2
				var right_position : Vector2 = previous_room.door.position + (Vector2.RIGHT + Vector2.UP) * TILESIZE/2
				create_bridge(path_length, previous_room.ground, previous_room.roof_top, left_position, right_position)
				hallway_end = previous_room.door.global_position + Vector2.UP * (path_length * TILESIZE)
				
			current_room.global_position = (hallway_end - current_room.center.global_position)
		previous_room = current_room

func change_tile_at_position(layer : TileMapLayer, tile_position : Vector2, atlasTextureCoords : Vector2i) -> void:
	layer.to_local(tile_position)
	var coordinates = layer.local_to_map(tile_position)
	layer.set_cell(coordinates ,0,atlasTextureCoords)
	
func create_bridge(tile_num : int, ground : TileMapLayer, roof_top : TileMapLayer, left_position : Vector2, right_position : Vector2)->void:
	for i in tile_num:
		change_tile_at_position(ground,left_position + Vector2.UP * i * TILESIZE,Vector2i(3,1))
		change_tile_at_position(ground,right_position + Vector2.UP * i * TILESIZE,Vector2i(3,1))
	for i in tile_num  :
		change_tile_at_position(roof_top,left_position + Vector2.UP * (i + 1)* TILESIZE + Vector2.LEFT * TILESIZE,Vector2i(4,5))
		change_tile_at_position(roof_top, right_position + Vector2.UP * (i + 1) * TILESIZE + Vector2.RIGHT * TILESIZE ,Vector2i(3,5))
	change_tile_at_position(roof_top, right_position + Vector2.UP  * TILESIZE + Vector2.RIGHT * TILESIZE ,Vector2i(1,7))
	change_tile_at_position(roof_top,left_position + Vector2.UP * TILESIZE + Vector2.LEFT * TILESIZE,Vector2i(5,7))
	
