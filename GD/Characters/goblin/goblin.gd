@icon("res://Art/enemies/goblin/goblin_idle_anim_f0.png")
extends Enemy
@export_category("Goblin variables")

@export var projectile_speed : float = 500
@export var knockback_force : float
@export var weapon_pivot : Marker2D

var knockback_dir : Vector2
var player : CharacterBody2D
var direction_to_player : Vector2
var retreat_finished : bool = false
var approach_finished : bool = false

func _ready() -> void:
	player = PlayerManager.player
	
func _process(_delta: float) -> void:
	direction_to_player = global_position.direction_to(player.global_position)
	if player:
		if direction_to_player.x > 0:
			sprite.flip_h = false
			weapon_pivot.position.x = abs(weapon_pivot.position.x)
		if direction_to_player.x < 0:
			sprite.flip_h = true
			weapon_pivot.position.x = -abs(weapon_pivot.position.x)
