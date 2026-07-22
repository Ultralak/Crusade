extends NodeState

var death_explosion : PackedScene = preload("uid://3er4nc5bjvmo")
@export var player : CharacterBody2D


func enter():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.timeout.connect(on_timer_timeout)
	
	var death_explosion_instance = death_explosion.instantiate() as Node2D
	death_explosion_instance.global_position = player.global_position
	player.visible = false
	get_parent().add_child(death_explosion_instance)
	timer.start()

func on_timer_timeout() -> void:
	player.queue_free()
