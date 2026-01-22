extends RayCast2D

signal entered_ray_right

signal exited_ray_right
var entered : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_colliding():
		var collision = get_collider()
		if collision and collision.is_in_group("PLAYER_") and !entered:
			entered_ray_right.emit()
			entered = true
	
	if !is_colliding() and entered:
		emit_signal("exited_ray_right")
		entered = false
