extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var damage_amount : int = 3
@export var health : int = 20


signal enemy_dead
signal enemy_hit

func _ready() -> void:
	EnemyHealthManager.update_dictionary(name, health)
func damage_taken(damage : int):
	health -= damage
	EnemyHealthManager.update_dictionary(name, health)
	enemy_hit.emit()
	if health <= 0:
		enemy_dead.emit()
		

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("PLAYER_"):
		EnemyManager.attacking_player = animated_sprite_2d
		body.damage_taken(damage_amount)
