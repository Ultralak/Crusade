extends Node2D

var player : CharacterBody2D = null
var health : float
var max_health : float
signal hurt
signal player_dead
signal on_health_increase(health : float)
signal on_health_decrease(health : float)
# Called when the node enters the scene tree for the first time.
var saved : int  = 2
var time  : float 
var can_get_health : bool
var called : bool = false

func register_player(player_node : CharacterBody2D):
	#called = true
	player = player_node
	#time = player_node.damage_tween_time
	#health = player_node.player_health
	#max_health = health

					
func register_healthbar(damagebar : CustomProgressBar):
	if called:
		damagebar.damage_time = time
		damagebar.setup_health_bar(health)

func damage_taken(damage : int):
	if saved > 0 and (health - damage) <= 0:
		health = 1
		saved -= 1
	else: 
		health -= damage
	on_health_decrease.emit(health)
	hurt.emit()
	if health <= 0:
		player_dead.emit()
		
	can_get_health = true
	
	await get_tree().create_timer(3).timeout
	
	can_get_health = false


func health_improved(health_increase : float):
	health += health_increase
	
	if health > max_health:
		health  = max_health
	on_health_increase.emit(health)
	


func get_player_position() -> Vector2:
	if is_instance_valid(player):
		return player.global_position
	return Vector2.ZERO
	
