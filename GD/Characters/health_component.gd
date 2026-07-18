extends Node
class_name HealthComponent

@export var health : float  
@export var max_health : float = 10
@export var FSM : NodeFiniteStateMachine
@export var Hitbox_area : Area2D
@export var entity : CharacterBody2D
@export var hurt_state : NodeState
@export var Navigation_component : Node2D
func _init() -> void:
	health = max_health
	
func _ready() -> void:
	#effects of damage will be dealt in state machine
	Hitbox_area.connect("body_entered", deal_damage)

	
func deal_damage(damage : float, direction : Vector2, force : float):
	health -= damage
	if entity.is_in_group("ENEMY_"):
		hurt_state.set_knockback(direction, force)
		Navigation_component.disable_navigation()
	FSM.transition_to("hurt")
	

func heal_health(heal_amount : float):
	health += heal_amount
	if health >= max_health:
		health = max_health
