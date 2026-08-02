extends Node2D

const SPAWN_ROOMS : Array =[preload("res://Game Files/spawn rooms/spawn_room_0.tscn"),
							preload("res://Game Files/spawn rooms/spawn_room_1.tscn"),
							preload("res://Game Files/spawn rooms/spawn_room_2.tscn")]
const INTERMEDIATE_ROOMS : Array = [preload("res://Game Files/main rooms/room_0.tscn"),
									preload("res://Game Files/main rooms/rooms_1.tscn"),
									preload("res://Game Files/main rooms/room_2.tscn"),
									preload("res://Game Files/main rooms/room_3.tscn")]
const END_ROOM : Array = [preload("res://Game Files/end rooms/end_room.gd")]


const TILE_SIZE : int = 16
const TILE_SOURCE : int = 0
const FLOOR_TILE_ATLAS_COORDINATES : Vector2i  = Vector2i(3,1)
const LEFT_WALL_TILE_ATLAS_COORDINATES : Vector2i = Vector2i(4,5)
const RIGHT_WALL_TILE_ATLAS_COORDINATES : Vector2i = Vector2i(3,5)

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
	previous_room = SPAWN_ROOMS.pick_random().instantiate() as Node
	add_child(previous_room)
	
	
