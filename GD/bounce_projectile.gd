class_name RicochetProjectile
extends BasicProjectile

@export var max_bounces: int = 3
var current_bounces: int = 0


func _physics_process(delta: float) -> void:
	if is_shot and projectile_velocity:
		velocity = projectile_direction * projectile_velocity
		
		var collision := move_and_collide(velocity * delta)
		if collision:
			current_bounces += 1
			projectile_direction = projectile_direction.bounce(collision.get_normal())
			rotation = projectile_direction.angle()

			if current_bounces >= max_bounces:
				call_deferred("queue_free")


func _on_attack_box_body_entered(_body: Node2D) -> void:
	# Physics collisions and wall bounces are managed in _physics_process.
	pass
