extends Node2D

var player: Paladin

@onready var player_spawn_position: Marker2D = $player_spawn_position


func _ready() -> void:
	if !player:
		player = PlayerManager.player
		#var player_instance : CharacterBody2D = PLAYER.instantiate() as CharacterBody2D

		# TODO : Check to make sure player is added to scene correctly

		#get_parent().call_deferred("add_child",player_instance)
	player.global_position = player_spawn_position.get_child(0).global_position
