extends NodeState

@export var entity: Enemy
func enter():
	animation_player.play("idle")
	entity.velocity = Vector2.ZERO

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass
	
func exit():
	animation_player.stop()
	
