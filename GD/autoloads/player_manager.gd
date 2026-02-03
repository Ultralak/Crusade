extends Node2D

var player : CharacterBody2D = null
var health : float

signal hurt
signal player_dead
signal on_health_increase(health : float)
signal on_health_decrease(health : float)
# Called when the node enters the scene tree for the first time.
var saved : bool = false
var time  : float


func damage_taken(damage : int):
	if !saved and health - damage < 1:
		health = 1
	else: 
		health -= damage
	on_health_decrease.emit(health)
	hurt.emit()
	if health <= 0:
		player_dead.emit()
		


func health_improved(health_increase : float):
	health += health_increase
	on_health_increase.emit(health)
	saved = false
	


func get_player_position() -> Vector2:
	if is_instance_valid(player):
		return player.global_position
	return Vector2.ZERO
	
