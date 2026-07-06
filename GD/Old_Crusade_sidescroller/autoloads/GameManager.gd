extends Node2D
#
#var test_level = preload("res://Scenes/test_level.tscn")
#var PAUSE_MENU_SCREEN = preload("uid://cxjca8vw5vsjt")
#var MAIN_MENU_SCREEN = preload("uid://c1d56vp3ibela")
#
#func _ready() -> void:
	#RenderingServer.set_default_clear_color(Color(0.44,0.12,0.53,1.00))
	#
	#SettingsManager.load_settings()
#
#func pause_game():
	#get_tree().paused = true
	#
	#var pause_menu_screen_instance = PAUSE_MENU_SCREEN.instantiate() 
	#get_tree().get_root().add_child(pause_menu_screen_instance)
#
#func continue_game():
	#get_tree().paused = false
	#
	#
#func main_menu():
	#var main_menu_screen_instance = MAIN_MENU_SCREEN.instantiate() 
	#get_tree().get_root().add_child(main_menu_screen_instance)
#
#func start_game():
	#if get_tree().paused:
		#continue_game()
		#return
		##this will need to be changed later to restart game from beginning
	#transition_to_scene(test_level.resource_path)
	#
#
#
	#
#func exit_game():
	#get_tree().quit()
	#
#func transition_to_scene(scene_path ):
	#await get_tree().create_timer(0.1).timeout
	#get_tree().change_scene_to_file(scene_path)
