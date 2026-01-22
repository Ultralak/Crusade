extends NodeState
@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass

func enter():
	animatedsprite2d.play("death")
	
	await get_tree().create_timer(0.3).timeout
	
	characterbody2d.queue_free()


func exit():
	pass
