extends CharacterBody2D
class_name Player

var player_death_effect = preload("res://Player/player_dead_effect/player_death.tscn")
@onready var collision_shape_2d: CollisionShape2D = $hit_box/CollisionShape2D
@export var state_machine  : NodeFiniteStateMachine
@export var sprite_2d : Sprite2D
@export var player_health : float = 10
@export var damage_amount : int = 5
@export var damage_tween_time : float = 3.0

var dash_speed : float = 500
var dash_friction : float = 200
var hurt_time : float = 0.2


func _ready() -> void:
	PlayerManager.register_player(self)
	PlayerManager.player_dead.connect(dead)
	PlayerManager.hurt.connect(_on_player_hurt)
	
func damage_taken(damage : int):
	PlayerManager.damage_taken(damage)
	
func get_player_health():
	return player_health
		
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ENEMY_"):
		if body.has_method("damage_taken"):
			body.damage_taken(damage_amount)
		else:
			for child in body.get_children():
				if child.has_method("damage_taken"):
					child.damage_taken(damage_amount)
	if PlayerManager.can_get_health:
		PlayerManager.health_improved( 0.3 * damage_amount)


func dead():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	player_death_effect_instance.get_child(0).flip_h = sprite_2d.flip_h
	get_parent().add_child(player_death_effect_instance)
	queue_free()



func _on_player_hurt() -> void:
	state_machine.transition_to("hurt")


func _on_crouch_passthrough() -> void:
	await get_tree().create_timer(0.5).timeout
	
	set_collision_mask_value(4 , true)
