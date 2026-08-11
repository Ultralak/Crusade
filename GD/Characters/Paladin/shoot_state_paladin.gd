extends NodeState

var bullet_damage : float = 2
var bullet := preload("res://Characters/goblin/PlayerBullet.tscn")
var player_direction : Vector2
# number of bullets shot per second

@export var bullet_spread : float = deg_to_rad(45)
# TODO : Implement spread logic
@export var rate_of_fire : float = 2
@export var knockback_force : float = 150
@export var muzzle : Marker2D
@export var projectile_velocity : float = 500
@export var FSM : NodeFiniteStateMachine
@export var timer : Timer

var can_shoot : bool  = true
var can_shoot_time : float

func enter():
	animation_player.play("run")
	print("Setting up player bullet scene")
	can_shoot_time = 1/rate_of_fire
	player_direction = get_parent().get_parent().mouse_direction
	shoot_bullet()
func on_physics_process(_delta : float):
	pass
	
func on_process(_delta : float):
	if can_shoot:
		player_direction = get_parent().get_parent().mouse_direction
		shoot_bullet()
	
	
func exit():
	animation_player.stop()

func shoot_bullet()->void:
	var BulletInstance = bullet.instantiate() as BasicProjectile
	
	# Position of bullet at spawn
	BulletInstance.global_position = muzzle.global_position
	
	#Direction of force and knockback
	BulletInstance.projectile_direction = player_direction
	BulletInstance.projectile_velocity = projectile_velocity
	
	#Enemy Knockback
	BulletInstance.knockback_dir = player_direction
	BulletInstance.knockback_force = knockback_force
	
	add_child(BulletInstance)
	BulletInstance.is_shot = true
	can_shoot = false
	
	timer.wait_time = can_shoot_time
	timer.one_shot = true
	timer.start()
	
func _on_can_shoot_timeout() -> void:
	can_shoot = true
