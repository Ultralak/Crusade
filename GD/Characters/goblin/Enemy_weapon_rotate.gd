extends Node2D
class_name EnemyRotateComponent

@export var weapon : Weapon
@export var entity : Enemy
@export var pivot : Marker2D
var player : Character

func _ready() -> void:
	player = PlayerManager.player
	
func _process(_delta: float) -> void:
	if weapon is ProjectileWeapon and player:
		weapon.setup_gun_enemy(entity.global_position.direction_to(player.player_center.global_position),entity,pivot)
