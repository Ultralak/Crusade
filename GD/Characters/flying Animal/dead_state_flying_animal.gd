extends NodeState

var death_explosion : PackedScene = preload("uid://3er4nc5bjvmo")
@export var enemy : Enemy
@export var Navigation_comp : NavigationComponent


func enter():
	PlayerManager.add_coins(enemy.energy_dropped)
	Navigation_comp.disable_navigation()
	enemy.emit_is_dead()
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 1.0
	add_child(timer)
	timer.timeout.connect(on_timer_timeout)
	
	var death_explosion_instance = death_explosion.instantiate() as Node2D
	death_explosion_instance.global_position = enemy.global_position
	enemy.visible = false
	get_parent().add_child(death_explosion_instance)
	timer.start()
func exit():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_timer_timeout() -> void:
	enemy.queue_free()
