extends ProgressBar

@export var timer : Timer
@export var damage_bar : ProgressBar
@export var visibility_timer : Timer
var health : float = 0 : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_parent().get_children():
			if child.has_method("init_health"):
				health = child.init_health()
				max_value = health
				value = health
				damage_bar.value = value
				damage_bar.max_value = value
				return
	PlayerManager.on_health_changed.connect(_set_health)
	health = PlayerManager.health
	max_value = health
	value = health
	damage_bar.value = health
	damage_bar.max_value = health

		
	

func _set_health(new_health):
	visible = true
	
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		
	if health < prev_health:
		timer.start()
		visibility_timer.start()
	else:
		damage_bar.value = health
	

func _on_timer_timeout() -> void:
	damage_bar.value = health



func _on_visibility_timer_timeout() -> void:
	visible = false
