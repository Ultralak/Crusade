extends NodeState

var meleeWeapon : Node2D
var projectileWeapon : ProjectileWeapon
var magicWeapon : Node2D

@export var velocity_component : VelocityComponent
func enter():
	pass

func on_process(_delta : float):
	velocity_component.get_input()
	if velocity_component.move_direction.length() > 0 :  
		animation_player.play("run")
	else:
		animation_player.play("idle")
	
func on_physics_process(_delta : float):
	pass
	
func exit():
	pass
