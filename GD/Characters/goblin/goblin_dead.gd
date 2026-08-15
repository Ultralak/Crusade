extends NodeState

var death_explosion : PackedScene = preload("uid://3er4nc5bjvmo")
@export var enemy : CharacterBody2D
@export var Navigation_component : NavigationComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Navigation_component.disable_navigation()

func enter():
	enemy.visible = false
	enemy.emit_is_dead()
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 1.0
	add_child(timer)
	timer.timeout.connect(on_timer_timeout)
	
	var death_explosion_instance = death_explosion.instantiate() as Node2D
	death_explosion_instance.global_position = enemy.global_position
	
	get_parent().add_child(death_explosion_instance)
	timer.start()
func exit():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_timer_timeout() -> void:
	enemy.queue_free()
