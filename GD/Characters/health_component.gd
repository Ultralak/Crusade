extends Node
class_name HealthComponent

@export var health : float  
@export var max_health : float 
@export var FSM : NodeFiniteStateMachine
@export var Hitbox_area : Area2D
@export var entity : CharacterBody2D
@export var hurt_state : NodeState
@export var Navigation_component : NavigationComponent


	
func _ready() -> void:
	
	#effects of damage will be dealt in state machine
	max_health = entity.max_health
	health = max_health
	Hitbox_area.connect("body_entered", take_damage)

	
func take_damage(damage : float, direction : Vector2, force : float):
	health -= damage
	hurt_state.set_knockback(direction, force)
	FSM.transition_to("hurt")
	

func heal_health(heal_amount : float):
	health += heal_amount
	if health >= max_health:
		health = max_health
