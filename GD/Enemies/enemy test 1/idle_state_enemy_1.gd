extends NodeState

@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D
@export var slow_down_speed : float = 50

@onready var raycast_left: RayCast2D = $"../../raycast_left"
@onready var raycast_right: RayCast2D = $"../../raycast_right"


func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	characterbody2d.velocity.x = move_toward(characterbody2d.velocity.x, 0, slow_down_speed * delta )
	characterbody2d.move_and_slide()


	
	
func enter():
	animatedsprite2d.play("idle")
	pass


func exit():
	animatedsprite2d.stop()
	


func _on_raycast_left_entered_ray_left() -> void:
	pass # Replace with function body.
	




func _on_raycast_right_entered_ray_right() -> void:
	pass # Replace with function body.
