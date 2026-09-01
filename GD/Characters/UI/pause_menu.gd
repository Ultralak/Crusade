extends Control

@export_file("*.tscn") var main_menu_path: String = "res://MainMenu.tscn"

@onready var background_overlay: ColorRect = $ColorRect
@onready var menu_container: MarginContainer = $MarginContainer
@onready var resume_button: Button = $MarginContainer/VBoxContainer/ResumeButton
@onready var main_menu_button: Button = $MarginContainer/VBoxContainer/MainMenuButton

var is_animating: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Initial reset of visibility and overlay transparency
	_reset_menu_state()
	
	var buttons: Array[Button] = [resume_button, main_menu_button]
	for btn in buttons:
		if btn:
			_setup_button_juice(btn)

func _unhandled_input(event: InputEvent) -> void:
	# GUARD: Do not allow pausing if the active scene IS the Main Menu
	if get_tree().current_scene and get_tree().current_scene.scene_file_path == main_menu_path:
		return
		
	if event.is_action_pressed("pause") and not is_animating:
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func pause_game() -> void:
	is_animating = true
	show()
	get_tree().paused = true
	
	menu_container.position.y = -get_viewport_rect().size.y
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(menu_container, "position:y", 0.0, 0.35)
	tween.tween_property(background_overlay, "modulate:a", 1.0, 0.25)
	
	await tween.finished
	is_animating = false

func resume_game() -> void:
	is_animating = true
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(menu_container, "position:y", -get_viewport_rect().size.y, 0.3)
	tween.tween_property(background_overlay, "modulate:a", 0.0, 0.25)
	
	await tween.finished
	hide()
	get_tree().paused = false
	is_animating = false

func _reset_menu_state() -> void:
	hide()
	background_overlay.modulate.a = 0.0
	is_animating = false

func _setup_button_juice(btn: Button) -> void:
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

func _on_resume_button_pressed() -> void:
	if is_animating:
		return
	_animate_reset(resume_button)
	resume_game()

func _on_main_menu_button_pressed() -> void:
	if is_animating:
		return
	_animate_reset(main_menu_button)
	
	# Unpause the game tree and clean up menu visibility before changing scene
	get_tree().paused = false
	_reset_menu_state()
	
	if main_menu_path != "":
		get_tree().change_scene_to_file(main_menu_path)
	else:
		push_error("Main Menu scene path is not assigned in the PauseMenu Inspector!")
