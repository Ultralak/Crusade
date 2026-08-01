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
@onready var door: StaticBody2D = $Doors/Door

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

func close_door()->void:
	for door in doors.get_children():
		if door is StaticBody2D:
			door.close()
			

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("PLAYER"):
		player_detection.queue_free()
		open_door()
