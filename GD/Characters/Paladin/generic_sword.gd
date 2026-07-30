extends Node2D

# !!! remeber to do something about character class
@export var player : Character
@export var physics : Node2D
@export var non_physics : Node2D
@export var damage_amount : float = 10.0
@export var weapon_pivot : Marker2D

func _ready() -> void:
	if !player:
		player = get_parent()
		
func _physics_process(_delta: float) -> void:
	var mouse_direction : Vector2 = (get_global_mouse_position() - weapon_pivot.global_position).normalized()
	if player.can_turn:
		weapon_pivot.rotation = mouse_direction.angle()
		
		if mouse_direction.x < 0:
			non_physics.scale.y = -1
			#non_physics.flip_sprites_v(true)
			
		elif mouse_direction.x > 0:
			#non_physics.flip_sprites_v(false)
			non_physics.scale.y = 1
