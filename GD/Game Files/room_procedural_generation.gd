extends Node2D

const SPAWN_ROOMS : Array =[preload("res://Game Files/spawn rooms/spawn_room_0.tscn"),
							preload("res://Game Files/spawn rooms/spawn_room_1.tscn")]
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

# player is already handled in spawn room script

func _ready() -> void:
	_spawn_rooms()
	
	
func _spawn_rooms()->void:
	var previous_room : Node
	
	for i in num_levels:
		var room_to_spawn : Node
		
		if i == 0:
			room_to_spawn = SPAWN_ROOMS.pick_random().instantiate() as Node
			
		if room_to_spawn:
			add_child(room_to_spawn)
			previous_room = room_to_spawn
