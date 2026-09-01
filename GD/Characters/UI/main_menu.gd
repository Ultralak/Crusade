extends Control

@export_file("*.tscn") var first_level_path: String

@onready var play_button: Button = $MarginContainer/VBoxContainer/PlayButton
@onready var quit_button: Button = $MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	var menu_buttons: Array[Button] = [play_button, quit_button]
	for button in menu_buttons:
		if button:
			_setup_button_juice(button)

func _setup_button_juice(btn: Button) -> void:
	# Center the pivot point so scale and tilt originate from the middle of the button
	btn.pivot_offset = btn.size / 2.0
	btn.resized.connect(func(): btn.pivot_offset = btn.size / 2.0)
	
	btn.mouse_entered.connect(_animate_hover.bind(btn))
	btn.mouse_exited.connect(_animate_reset.bind(btn))
	btn.focus_entered.connect(_animate_hover.bind(btn))
	btn.focus_exited.connect(_animate_reset.bind(btn))

func _animate_hover(btn: Button) -> void:
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn, "scale", Vector2(1.08, 1.08), 0.12)
	tween.tween_property(btn, "rotation_degrees", -4.0, 0.12)

func _animate_reset(btn: Button) -> void:
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn, "scale", Vector2(1.0, 1.0), 0.12)
	tween.tween_property(btn, "rotation_degrees", 0.0, 0.12)

func _on_play_button_pressed() -> void:
	# Instantly animate the button back to normal scale and tilt on click
	var reset_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	reset_tween.tween_property(play_button, "scale", Vector2(1.0, 1.0), 0.08)
	reset_tween.tween_property(play_button, "rotation_degrees", 0.0, 0.08)
	await reset_tween.finished
	
	if first_level_path != "":
		get_tree().change_scene_to_file(first_level_path)
	else:
		push_error("First level scene path is not set in the Inspector!")

func _on_quit_button_pressed() -> void:
	var reset_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	reset_tween.tween_property(quit_button, "scale", Vector2(1.0, 1.0), 0.08)
	reset_tween.tween_property(quit_button, "rotation_degrees", 0.0, 0.08)
	await reset_tween.finished
	
	get_tree().quit()
