extends NodeState
@export_category("idle melee state")
@export var characterbody2d : CharacterBody2D
@export var state_machine_controller: Node
@export var acceleration : float = 500
@export var speed : float = 600

@export var gun_sprite : Sprite2D	
@export var attack_timer : Timer


signal direction_changed


var bullet = preload("res://Enemies/Shooter/bullet.tscn")

func on_process(_delta : float):
	pass
func on_physics_process(_delta : float):
	pass
	
func enter():
	var direction = -1 if sprite_2d.flip_h else 1

	
	var bullet_instance = bullet.instantiate() as Node2D
	bullet_instance.global_position = characterbody2d.muzzle.global_position
	bullet_instance.speed = characterbody2d.projectile_speed
	bullet_instance.direction = direction
	bullet_instance.projectile_damage = characterbody2d.projectile_damage
	attack_timer.start(characterbody2d.attack_duration)
	get_parent().add_child(bullet_instance)
	
	
	gun_sprite.show()
	characterbody2d.velocity.x = 0
	animation_player.play("idle")

func exit():
	gun_sprite.visible = false
	animation_player.stop()
	
	
	
