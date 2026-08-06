extends Camera2D

var player : Character

var trauma : float = 0.0
var trauma_delay : float = 0.0
var decay_rate : float = 1.5

var max_offset : Vector2 = Vector2(16,12)
var max_roll : float = 5.0

var noise : FastNoiseLite
var noise_speed : float = 30.0
var noise_time : float = 0

func _ready() -> void:
	player = PlayerManager.player
	CameraManager.register(self)
	noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.frequency = 0.08

func add_trauma(amount : float)->void:
	trauma += amount
	trauma = clampf(trauma,0,1)
	
func _physics_process(delta: float) -> void:
	
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
	
