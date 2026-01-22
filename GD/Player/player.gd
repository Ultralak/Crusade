extends CharacterBody2D

var player_death_effect = preload("res://Player/player_dead_effect/player_death.tscn")
@onready var collision_shape_2d: CollisionShape2D = $hit_box/CollisionShape2D

signal hurt

@export var player_health : int = 10
@export var damage_amount : int = 3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	PlayerManager.player = self

func damage_taken(damage : int):
	player_health -= damage
	hurt.emit()
	if player_health <= 0:
		player_dead()
		
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ENEMY_"):
		body.damage_taken(damage_amount)

func player_dead():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	player_death_effect_instance.get_child(0).flip_h = animated_sprite_2d.flip_h
	get_parent().add_child(player_death_effect_instance)
	queue_free()


	
	
