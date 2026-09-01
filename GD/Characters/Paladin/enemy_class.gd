extends Character
class_name Enemy

signal enemy_killed(body: CharacterBody2D)

@export var energy_dropped : int = 10
@export var sprite: Sprite2D
@export var damage_amount: float = 4.0
@export var max_health: float = 10.0
@export var debug_text_enabled: bool
@export var debug_text: Label
@export var movement_speed: float = 25.0
@export var FSM: NodeFiniteStateMachine

@export_group("Waddle Animation")
@export var tilt_angle_degrees: float = 10.0
@export var tilt_speed: float = 0.15

var tilt_tween: Tween
var is_waddling: bool = false


func _ready() -> void:
	if is_instance_valid(debug_text):
		debug_text.visible = debug_text_enabled


func _physics_process(_delta: float) -> void:

	if not is_instance_valid(sprite):
		return

	if velocity.length() > 5.0:
		start_waddle()
	else:
		stop_waddle()


func start_waddle() -> void:
	if is_waddling:
		return

	is_waddling = true
	_kill_active_tween()

	var tilt_rad := deg_to_rad(tilt_angle_degrees)

	tilt_tween = create_tween().set_loops()
	tilt_tween.tween_property(sprite, "rotation", tilt_rad, tilt_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tilt_tween.tween_property(sprite, "rotation", -tilt_rad, tilt_speed * 2.0)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tilt_tween.tween_property(sprite, "rotation", 0.0, tilt_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func stop_waddle() -> void:
	if not is_waddling:
		return

	is_waddling = false
	_kill_active_tween()

	tilt_tween = create_tween()
	tilt_tween.tween_property(sprite, "rotation", 0.0, tilt_speed)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _kill_active_tween() -> void:
	if tilt_tween and tilt_tween.is_valid():
		tilt_tween.kill()


func emit_is_dead() -> void:
	enemy_killed.emit(self)
