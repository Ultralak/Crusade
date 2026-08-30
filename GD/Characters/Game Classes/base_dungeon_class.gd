class_name BaseDungeon
extends Node2D

enum DUNGEONTYPE {
	locked,
	free_way,
}

enum DUNGEONEVENT {
	spawn, 
	combat,
	treasure,
	boss,
	shop,
	treasure_combat,
}

@export var floor_type: DUNGEONTYPE = DUNGEONTYPE.locked
@export var floor_event : DUNGEONEVENT 
@onready var ground: TileMapLayer = $NavigationRegion2D/ground
@onready var wall: TileMapLayer = $NavigationRegion2D/wall
@onready var ground_objects: TileMapLayer = $NavigationRegion2D/ground_objects
@onready var ground_objects_2: TileMapLayer = $"NavigationRegion2D/ground objects 2"
@onready var player_detect: Area2D = $NavigationRegion2D/PlayerDetect

@export var spawn_component: SpawnComponent 



func _ready() -> void:
	if spawn_component:
		spawn_component.all_waves_cleared.connect(_on_all_waves_cleared)
	setup()


func setup() -> void:
	pass


func apply_door_states(has_top: bool, has_bottom: bool, has_left: bool, has_right: bool) -> void:
	var up_marker = $NavigationRegion2D/exit/up
	var down_marker = $NavigationRegion2D/exit/down
	var left_marker = $NavigationRegion2D/exit/left
	var right_marker = $NavigationRegion2D/exit/right

	if up_marker and up_marker is DoorMarker:
		up_marker.activated = has_top
	if down_marker and down_marker is DoorMarker:
		down_marker.activated = has_bottom
	if left_marker and left_marker is DoorMarker:
		left_marker.activated = has_left
	if right_marker and right_marker is DoorMarker:
		right_marker.activated = has_right

	wall.setup_room_walls()
	


func _on_player_detect_body_entered(_body: Node2D) -> void:
	player_detect.call_deferred("queue_free")
	
	if floor_type == DUNGEONTYPE.locked:
		wall.close()
		await get_tree().create_timer(0.5).timeout
		
	if spawn_component:
		spawn_component.start_spawning()

func initialize_room() -> void:
	var spawners = find_children("*", "ChestSpawnerComponent", true, false)
	for spawner in spawners:
		if spawner.has_method("spawn_chest"):
			spawner.spawn_chest()

func _on_all_waves_cleared() -> void:
	wall.open()
