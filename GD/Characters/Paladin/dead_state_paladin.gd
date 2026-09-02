extends NodeState

var death_explosion: PackedScene = preload("uid://3er4nc5bjvmo")
var main_menu : PackedScene = preload("uid://byd35cbsn5h5k")
@export var player: CharacterBody2D
@export_file("*.tscn") var main_menu_path: String


func enter() -> void:
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
	get_tree().paused = false
	if main_menu:
		PlayerManager.reset()
		get_tree().change_scene_to_packed(main_menu)
		
	else:
		push_error("Main menu scene path is not set in the Inspector on " + name)
