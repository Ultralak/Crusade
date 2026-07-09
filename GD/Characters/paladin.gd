extends CharacterBody2D
#damage and health script


@onready var sword_anim: AnimationPlayer = $"sword/non-physics/sword_anim"
@onready var non_physics: Node2D = $"sword/non-physics"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(_delta: float) -> void:
	var mouse_direction : Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
		
	# rotate sword. remove when not needed
	non_physics.rotation = mouse_direction.angle()
	if non_physics.scale.y and mouse_direction.x < 0:
		non_physics.scale.y = -1
	elif non_physics.scale.y == -1 and mouse_direction.x > 0:
		non_physics.scale.y = 1

	
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	
