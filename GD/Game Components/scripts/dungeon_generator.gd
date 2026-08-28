extends Node2D
class_name DungeonGenerator

@export var spawn_room_scene: PackedScene
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

	spawn_rooms()


func spawn_rooms() -> void:
	if combat_room_scenes.is_empty() or not spawn_room_scene:
		return

	for grid_pos in dungeon_layout.keys():
		var event_type: BaseDungeon.DUNGEONEVENT = dungeon_layout[grid_pos]
		var selected_scene: PackedScene
		
		if event_type == BaseDungeon.DUNGEONEVENT.spawn:
			selected_scene = spawn_room_scene
		else:
			selected_scene = combat_room_scenes.pick_random()

		var room_instance = selected_scene.instantiate() as Node2D
		
		var world_x: float = grid_pos.x * room_width
		var world_y: float = grid_pos.y * room_height
		room_instance.global_position = Vector2(world_x, world_y)
		
		add_child(room_instance)
		configure_doors(room_instance, grid_pos)


func configure_doors(room_node: Node2D, grid_pos: Vector2i) -> void:
	var has_top: bool = dungeon_layout.has(grid_pos + Vector2i.UP)
	var has_bottom: bool = dungeon_layout.has(grid_pos + Vector2i.DOWN)
	var has_left: bool = dungeon_layout.has(grid_pos + Vector2i.LEFT)
	var has_right: bool = dungeon_layout.has(grid_pos + Vector2i.RIGHT)
	
	if room_node.has_method("apply_door_states"):
		room_node.apply_door_states(has_top, has_bottom, has_left, has_right)
