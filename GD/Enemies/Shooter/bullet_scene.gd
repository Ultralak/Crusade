extends AnimatedSprite2D


var speed : int = 600
var direction : int
@export var projectile_damage : float = 500

func _physics_process(delta: float) -> void:
	move_local_x(direction * speed * delta)

func _on_disappear_timeout() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("GROUND_"):
		queue_free()
	if body.is_in_group("PLAYER_"):
		EnemyManager.attacking_projectile = self
		body.damage_taken(projectile_damage)
		queue_free()
