extends Node2D
class_name DungeonGenerator

@export var spawn_room_scene: PackedScene
@export var end_room_scene: PackedScene
@export var shop_room_scene: PackedScene
@export var treasure_room_scene: PackedScene
@export var combat_room_scenes: Array[PackedScene] = []

@export var max_rooms: int = 10
@export var room_width: int = 480
@export var room_height: int = 270

var dungeon_layout: Dictionary = {}
var cardinal_directions: Array[Vector2i] = [
	Vector2i.UP,
	Vector2i.RIGHT,
	Vector2i.DOWN,
	Vector2i.LEFT
]


func _ready() -> void:
	generate_dungeon()


func generate_dungeon() -> void:
	dungeon_layout.clear()
	var current_pos: Vector2i = Vector2i.ZERO
	dungeon_layout[current_pos] = BaseDungeon.DUNGEONEVENT.spawn
	
	while dungeon_layout.size() < max_rooms:
		var move_direction: Vector2i = cardinal_directions.pick_random()
		current_pos += move_direction
		if not dungeon_layout.has(current_pos):
			dungeon_layout[current_pos] = BaseDungeon.DUNGEONEVENT.combat

	_assign_room_events()
	spawn_rooms()


func _assign_room_events() -> void:
	# Breadth-First Search (BFS) to find true walking step distance from spawn (0,0)
	var distances: Dictionary = {}
	var queue: Array[Vector2i] = [Vector2i.ZERO]
	distances[Vector2i.ZERO] = 0
	
	var furthest_pos: Vector2i = Vector2i.ZERO
	var max_distance: int = 0
	
	while not queue.is_empty():
		var current: Vector2i = queue.pop_front()
		var current_dist: int = distances[current]
		
		if current_dist > max_distance:
			max_distance = current_dist
			furthest_pos = current
		
		for dir in cardinal_directions:
			var neighbor: Vector2i = current + dir
			if dungeon_layout.has(neighbor) and not distances.has(neighbor):
				distances[neighbor] = current_dist + 1
				queue.append(neighbor)
	
	# Assign boss room to the room requiring the most room-to-room steps from spawn
	if furthest_pos != Vector2i.ZERO:
		dungeon_layout[furthest_pos] = BaseDungeon.DUNGEONEVENT.boss
	
	# Filter available positions, explicitly protecting spawn (0,0) and the boss room
	var available_positions: Array[Vector2i] = []
	for grid_pos in dungeon_layout.keys():
		if grid_pos != Vector2i.ZERO and grid_pos != furthest_pos:
			available_positions.append(grid_pos)
	
	available_positions.shuffle()
	
	if not available_positions.is_empty():
		var shop_pos = available_positions.pop_back()
		dungeon_layout[shop_pos] = BaseDungeon.DUNGEONEVENT.shop
	
	var treasure_room_count: int = max_rooms / 4
	for i in range(treasure_room_count):
		if available_positions.is_empty():
			break
		var treasure_pos = available_positions.pop_back()
		dungeon_layout[treasure_pos] = BaseDungeon.DUNGEONEVENT.treasure


func spawn_rooms() -> void:
	if combat_room_scenes.is_empty() or not spawn_room_scene:
		return

	for grid_pos in dungeon_layout.keys():
		var event_type: BaseDungeon.DUNGEONEVENT = dungeon_layout[grid_pos]
		var selected_scene: PackedScene = _get_scene_for_event(event_type)

		if not selected_scene:
			continue

		var room_instance = selected_scene.instantiate() as Node2D
		
		var world_x: float = grid_pos.x * room_width
		var world_y: float = grid_pos.y * room_height
		room_instance.global_position = Vector2(world_x, world_y)
		
		add_child(room_instance)
		configure_doors(room_instance, grid_pos)

		if room_instance.has_method("initialize_room"):
			room_instance.initialize_room()


func _get_scene_for_event(event_type: BaseDungeon.DUNGEONEVENT) -> PackedScene:
	match event_type:
		BaseDungeon.DUNGEONEVENT.spawn:
			return spawn_room_scene
		BaseDungeon.DUNGEONEVENT.boss:
			return end_room_scene if end_room_scene else combat_room_scenes.pick_random()
		BaseDungeon.DUNGEONEVENT.shop:
			return shop_room_scene if shop_room_scene else combat_room_scenes.pick_random()
		BaseDungeon.DUNGEONEVENT.treasure:
			return treasure_room_scene if treasure_room_scene else combat_room_scenes.pick_random()
		_:
			return combat_room_scenes.pick_random()


func configure_doors(room_node: Node2D, grid_pos: Vector2i) -> void:
	var has_top: bool = dungeon_layout.has(grid_pos + Vector2i.UP)
	var has_bottom: bool = dungeon_layout.has(grid_pos + Vector2i.DOWN)
	var has_left: bool = dungeon_layout.has(grid_pos + Vector2i.LEFT)
	var has_right: bool = dungeon_layout.has(grid_pos + Vector2i.RIGHT)
	
	if room_node.has_method("apply_door_states"):
		room_node.apply_door_states(has_top, has_bottom, has_left, has_right)
