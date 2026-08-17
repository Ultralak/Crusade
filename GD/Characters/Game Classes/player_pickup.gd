extends Node2D

@export var raycast : RayCast2D
var player : Character
var distance_to_player
func _ready() -> void:
	player = PlayerManager.player

func _process(delta: float) -> void:
	pass
	
