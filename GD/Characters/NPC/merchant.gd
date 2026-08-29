extends CharacterBody2D


var player : Paladin
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	player = PlayerManager.player
	
func _process(_delta: float) -> void:
	
	if player:
		var direction_to_player = global_position.direction_to(player.global_position)
		if direction_to_player.x > 0:
			sprite.flip_h = false

		if direction_to_player.x < 0:
			sprite.flip_h = true
