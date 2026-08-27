class_name RoomCamera
extends Camera2D

@export var player: Node2D
@export var room_width: float = 480
@export var room_height: float = 270
@export var transition_speed: float = 10.0

var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	if player:
		target_position = calculate_target_position(player.global_position)
		global_position = target_position


func _physics_process(delta: float) -> void:
	if not player:
		return

	target_position = calculate_target_position(player.global_position)
	global_position = global_position.lerp(target_position, transition_speed * delta)


func calculate_target_position(player_pos: Vector2) -> Vector2:
	var grid_x: float = floor(player_pos.x / room_width)
	var grid_y: float = floor(player_pos.y / room_height)

	var center_x: float = (grid_x * room_width) + (room_width / 2.0)
	var center_y: float = (grid_y * room_height) + (room_height / 2.0)

	return Vector2(center_x, center_y)
