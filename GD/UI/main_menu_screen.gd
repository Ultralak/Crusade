extends CanvasLayer

var SETTINGS_MENU_SCREEN = preload("uid://d1iklfyxmi27g")


func _on_play_button_pressed() -> void:
	GameManager.start_game()
	queue_free()


	
func _on_exit_button_pressed() -> void:
	GameManager.exit_game()


func _on_settigns_button_pressed() -> void:
	var settings_menu_screen_instance = SETTINGS_MENU_SCREEN.instantiate()
	get_tree().get_root().add_child(settings_menu_screen_instance)
