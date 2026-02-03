extends CharacterBody2D

var player_death_effect = preload("res://Player/player_dead_effect/player_death.tscn")
@onready var collision_shape_2d: CollisionShape2D = $hit_box/CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var state_machine  : NodeFiniteStateMachine

@export var player_health : int = 10
@export var damage_amount : int = 3
@export var damage_tween_time : float = 3.0

var dash_speed : float = 500
var dash_friction : float = 200
var hurt_time : float = 0.2


func _ready() -> void:
	PlayerManager.player = self
	PlayerManager.health = player_health
	PlayerManager.player_dead.connect(dead)
	PlayerManager.hurt.connect(_on_player_hurt)
	PlayerManager.time = damage_tween_time
func damage_taken(damage : int):
	PlayerManager.damage_taken(damage)
		
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ENEMY_"):
		if body.has_method("damage_taken"):
			body.damage_taken(damage_amount)
			
		else:
			for child in body.get_children():
				if child.has_method("damage_taken"):
					child.damage_taken(damage_amount)
					return
				


func dead():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	player_death_effect_instance.get_child(0).flip_h = animated_sprite_2d.flip_h
	get_parent().add_child(player_death_effect_instance)
	queue_free()



func _on_player_hurt() -> void:
	state_machine.transition_to("hurt")


func _on_crouch_passthrough() -> void:
	await get_tree().create_timer(0.5).timeout
	
	set_collision_mask_value(4 , true)
