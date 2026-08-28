extends Node2D

signal player_registered(player_node: CharacterBody2D)
signal player_spawned(position: Vector2)

@export var player_scene: PackedScene

var player: CharacterBody2D = null


func register_player(player_node: CharacterBody2D) -> void:
	player = player_node
	player_registered.emit(player)


func get_player() -> CharacterBody2D:
	if is_instance_valid(player):
		return player
	return null


func set_player_position(target_position: Vector2) -> void:
	if is_instance_valid(player):
		player.global_position = target_position
		player.z_index  = 2
		player_spawned.emit(target_position)


func spawn_player_at(target_position: Vector2, parent_node: Node) -> void:
	if not is_instance_valid(player):
		if player_scene:
			var new_player = player_scene.instantiate() as CharacterBody2D
			parent_node.add_child.call_deferred(new_player)
			register_player(new_player)
	
	set_player_position(target_position)
