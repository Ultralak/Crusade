extends Node2D


@export var healthbar : TextureProgressBar
@export var damage_bar : TextureProgressBar
@export var visibility_timer : Timer
@export var entity : CharacterBody2D
@export var healthComp : HealthComponent
@export var visibility_time : float = 2
@export var damage_bar_time : float = 1
@export var damage_bar_tween_duration : float = 0.5

var current_damage_tween : Tween
var health : float 
var damage_tween_array : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
						break
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
		if current_damage_tween and current_damage_tween.is_running():
			current_damage_tween.kill()
		
		current_damage_tween = create_tween()
		current_damage_tween.tween_interval(0.5)
		setup_tween(current_damage_tween)
		visibility_timer.start()
	else:
		damage_bar.value = health
	
func setup_tween(tween : Tween):
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(damage_bar, "value", health, damage_bar_tween_duration)
	

func _on_visibility_timer_timeout() -> void:
	pass



	
	
