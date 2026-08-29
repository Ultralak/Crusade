class_name RoomCamera
extends Camera2D

@export var player: Node2D
@export var room_width: float = 480
@export var room_height: float = 270
@export var transition_speed: float = 10.0

var trauma : float = 0.0
var trauma_delay : float = 0.0
var decay_rate : float = 1.5

var max_offset : Vector2 = Vector2(16,12)
var max_roll : float = 5.0

var noise : FastNoiseLite
var noise_speed : float = 30.0
var noise_time : float = 0

var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	player = PlayerManager.player
	CameraManager.register(self)
	noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.frequency = 0.08
	if player:
		target_position = calculate_target_position(player.global_position)
		global_position = target_position


func _physics_process(delta: float) -> void:
	if not player:
		return

	target_position = calculate_target_position(player.global_position)
	global_position = global_position.lerp(target_position, transition_speed * delta)
	if trauma > 0:
		trauma -= delta * decay_rate
		trauma = clampf(trauma,0,1)
		
		noise_time += delta * noise_speed
		
		var intensity = trauma * trauma
		
		var noise_x = noise.get_noise_2d(noise_time,0)
		var noise_y = noise.get_noise_2d(0,noise_time)
		var noise_rot = noise.get_noise_2d(noise_time,noise_time)
		
		offset.x  = noise_x * max_offset.x * intensity
		offset.y  = noise_y * max_offset.y * intensity
		rotation = noise_rot * deg_to_rad(max_roll) * intensity
		
	else:
		if offset != Vector2.ZERO:
			offset = Vector2.ZERO
			rotation = 0


func calculate_target_position(player_pos: Vector2) -> Vector2:
	var grid_x: float = floor(player_pos.x / room_width)
	var grid_y: float = floor(player_pos.y / room_height)

	var center_x: float = (grid_x * room_width) + (room_width / 2.0)
	var center_y: float = (grid_y * room_height) + (room_height / 2.0)

	return Vector2(center_x, center_y)
func add_trauma(amount : float)->void:
	trauma += amount
	trauma = clampf(trauma,0,1)
	
	
	
	
