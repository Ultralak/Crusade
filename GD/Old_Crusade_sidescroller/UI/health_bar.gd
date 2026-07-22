extends Node2D

@export var damage_bar_timer : Timer
@export var healthbar : ProgressBar
@export var damage_bar : ProgressBar
@export var visibility_timer : Timer
@export var entity : CharacterBody2D
@export var healthComp : HealthComponent
@export var visibility_time : float = 2
@export var damage_bar_time : float = 1
var health : float 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage_bar_timer.wait_time = damage_bar_time
	visibility_timer.wait_time = visibility_time
	if !entity:
		entity = get_parent()
	if entity:
		health = entity.max_health
		healthbar.max_value = health
		healthbar.value = health
		damage_bar.value = healthbar.value
		damage_bar.max_value = healthbar.value
		if !healthComp:
			for child in entity.get_children():
					if child is HealthComponent:
						healthComp = child
						return
		healthComp.health_decreased.connect(health_decrease)
		healthComp.health_increased.connect(health_increase)

func health_increase(new_health : float) -> void:
	visible = true
	health = min(healthbar.max_value, new_health)
	healthbar.value = health
	damage_bar.value = health

		
func health_decrease(new_health : float) -> void:
	visible = true
	
	var prev_health = health
	health = min(healthbar.max_value, new_health)
	healthbar.value = health
	

		
	if health < prev_health:
		
		damage_bar_timer.start()
		visibility_timer.start()
	else:
		damage_bar.value = health



func _on_visibility_timer_timeout() -> void:
	pass


func _on_damage_bar_timer_timeout() -> void:
	damage_bar.value = health
