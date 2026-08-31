class_name SineWaveProjectile
extends BasicProjectile

@export var wave_frequency: float = 12.0 # Oscillations per second
@export var wave_amplitude: float = 35.0 # Max weave angle in degrees

var alive_time: float = 0.0


func _physics_process(delta: float) -> void:
	if is_shot and projectile_velocity:
		alive_time += delta

		var sine_value: float = sin(alive_time * wave_frequency)
		var angle_offset: float = deg_to_rad(sine_value * wave_amplitude)
		var current_dir: Vector2 = projectile_direction.rotated(angle_offset)

		velocity = current_dir * projectile_velocity
		rotation = velocity.angle()

		move_and_slide()
