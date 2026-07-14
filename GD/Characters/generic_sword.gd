extends Node2D

# !!! remeber to do something about character class
@export var player : Character
@export var physics : Node2D
@export var non_physics : Node2D

func _ready() -> void:
	if !player:
		player = get_parent()
		
func _physics_process(_delta: float) -> void:
	var mouse_direction : Vector2 = (get_global_mouse_position() - player.global_position).normalized()
	if player.can_turn:
		non_physics.rotation = mouse_direction.angle()
		physics.rotation = mouse_direction.angle()
		
		if non_physics.scale.y  == 1 and mouse_direction.x < 0:
			non_physics.scale.y = -1
			
		elif non_physics.scale.y == -1 and mouse_direction.x > 0:
			non_physics.scale.y = 1
