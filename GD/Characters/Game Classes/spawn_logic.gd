extends Node2D

@export var player_spawn_position: Marker2D
@export var detect : Area2D
func _ready() -> void:
	detect.monitorable = false
	detect.monitoring = false
	if not player_spawn_position:
		return

	if PlayerManager.get_player():
		PlayerManager.set_player_position(player_spawn_position.global_position)
	else:
		PlayerManager.player_registered.connect(_on_player_registered, CONNECT_ONE_SHOT)
		PlayerManager.spawn_player_at(player_spawn_position.global_position, get_parent())
		
		


func _on_player_registered(_player_node: CharacterBody2D) -> void:
	if player_spawn_position:
		PlayerManager.set_player_position(player_spawn_position.global_position)
