extends Node
class_name HealthComponent

@export var health : float  
@export var max_health : float = 10
@export var FSM : NodeFiniteStateMachine
@export var Hitbox_area : Area2D

func _init() -> void:
	health = max_health
	
func _ready() -> void:
	Hitbox_area.connect("body_entered", deal_damage)

func deal_damage(damage_amount : float, knockback_dir : Vector2, Knockback_force : float):
	health -= damage_amount
	FSM.transition_to("hurt")
	
	if health <= 0:
		FSM.transition_to("dead")
	
func heal_health(heal_amount : float):
	health += heal_amount
	if health >= max_health:
		health = max_health
