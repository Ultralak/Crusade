extends Node2D

var PLAYER : PackedScene = preload("res://Characters/Paladin/player.tscn")
@onready var doors: Node2D = $Doors
@onready var player_spawn_position: Node2D = $player_spawn_position
@onready var player_detection: Area2D = $Player_Detection


func _ready() -> void:
	var player_instance : CharacterBody2D = PLAYER.instantiate() as CharacterBody2D
	player_instance.global_position = player_spawn_position.child(0).global_position
	# TODO : Check to make sure player is added to scene correctly
	
	get_parent().get_parent().add_child(player_instance)
	# Spawn Logic
func open_door()->void:
	for door in doors:
		if door is StaticBody2D:
			door.open()

func close_door()->void:
	for door in doors:
		if door is StaticBody2D:
			door.close()
