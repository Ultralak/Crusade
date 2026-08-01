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
var previous_room : Node
var current_room : Node
var previous_room_door : StaticBody2D 
# player is already handled in spawn room script




func _ready() -> void:
	_spawn_rooms()
	
	
func _spawn_rooms()->void:
	

	for i in num_levels:
		if i == 0:
			current_room = SPAWN_ROOMS.pick_random().instantiate() as Node
		elif i == num_levels - 1:
			current_room = END_ROOM.pick_random().instantiate() as Node
		else:
			current_room  = INTERMEDIATE_ROOMS.pick_random().instantiate() as Node
			# add room
		if current_room:
			add_child(current_room)
			previous_room = current_room
				
		prev_room_tilemap_ground = previous_room.ground
		prev_room_tilemap_roof = previous_room.ground
		# door node2d only has on
		previous_room_door = previous_room.doors.get_child(0)
		var left_tile_pos : Vector2 = prev_room_tilemap_ground.world_to_map(previous_room_door.position) + Vector2.UP
		var corridor_height : int = randi_range(2,6)

		for y in corridor_height:
			prev_room_tilemap_ground.set_cell(left_tile_pos + Vector2(-1, -y),0,floor_atlas_coords) #right tile
			prev_room_tilemap_ground.set_cell(left_tile_pos + Vector2(0, -y),0,floor_atlas_coords) # left tile
			prev_room_tilemap_roof.set_cell(left_tile_pos + Vector2(1, -y),0,right_wall_atlas_coords) #right wall
			prev_room_tilemap_roof.set_cell(left_tile_pos + Vector2(-2, -y),0,left_wall_atlas_coords) # left wall
		
		for node in current_room.get_children():
			if node is TileMapLayer:
				curr_room_tilemap_layers_array.append(node)
				
		var curr_tilemap_layer : TileMapLayer = curr_room_tilemap_layers_array.get(0)
		var amount_to_move_up_by : Vector2 = Vector2.UP * TILE_SIZE * (curr_tilemap_layer.get_used_rect().size.y + corridor_height)
		var amount_to_move_left_by : Vector2 = Vector2.LEFT * TILE_SIZE * (curr_tilemap_layer.get_used_rect().size.x - left_tile_pos.x)
		
		current_room.global_position = previous_room_door.global_position + amount_to_move_up_by + amount_to_move_left_by
