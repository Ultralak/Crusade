extends NodeState


@export var muzzle : Marker2D
@export var entity : CharacterBody2D
@onready var has_shot: Timer = $has_shot
@export var has_shot_time : float = 2
@export var FSM : NodeFiniteStateMachine

var direction_to_player : Vector2
var player : CharacterBody2D
var knife_projectile_scene = preload("res://Characters/goblin/Goblin_Knife.tscn")


func enter():
	
	player = PlayerManager.player
	entity.velocity = Vector2.ZERO
	
	var knife_projectile_scene_instance = knife_projectile_scene.instantiate() as Node2D
	
	# Set projectile speed and position
	
	knife_projectile_scene_instance.global_position = muzzle.global_position
	knife_projectile_scene_instance.projectile_direction = entity.direction_to_player
	knife_projectile_scene_instance.projectile_velocity  = entity.projectile_speed
	
	# Set projectile knockback effects
	knife_projectile_scene_instance.damage_amount = entity.damage_amount
	print("Knife Damage Amount at shoot state for %s : %s" % [get_parent().get_parent().name, knife_projectile_scene_instance.damage_amount])
	knife_projectile_scene_instance.knockback_dir = entity.direction_to_player
	knife_projectile_scene_instance.knockback_force = entity.knockback_force
	
	
	# Add to scene
	add_child(knife_projectile_scene_instance)
	knife_projectile_scene_instance.is_shot = true
	
	has_shot.wait_time = has_shot_time
	has_shot.one_shot = true
	has_shot.start()
	
	animation_player.play("idle")
	
func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass
	
func exit():
	animation_player.stop()


func _on_has_shot_timeout() -> void:
	FSM.transition_to("idle")
