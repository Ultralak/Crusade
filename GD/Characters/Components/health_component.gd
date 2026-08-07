extends Node
class_name HealthComponent

signal health_increased(new_health : float)
signal health_decreased(new_health : float)
@export var health : float  
@export var max_health : float 
@export var FSM : NodeFiniteStateMachine
@export var Hitbox_area : Area2D
@export var entity : CharacterBody2D
@export var hurt_state : NodeState
@export var damage_number_position : Node2D

	
func _ready() -> void:
	
	#effects of damage will be dealt in state machine
	max_health = entity.max_health
	health = max_health
	

	
func take_damage(damage : float, direction : Vector2, force : float):
	if damage_number_position:
		DamageNumbers.display_number(damage,damage_number_position.global_position,false)
	
	if entity.is_in_group("PLAYER"):
		print("Player health reduced by : %s" % damage)
	#print("take_damage runs")
	health -= damage
	hurt_state.set_knockback(direction, force)
	FSM.transition_to("hurt")
	health_decreased.emit(health)

func heal_health(heal_amount : float):
	health += heal_amount
	if health >= max_health:
		health = max_health
	health_increased.emit(health)
