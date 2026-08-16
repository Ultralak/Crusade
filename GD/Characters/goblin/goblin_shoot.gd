extends NodeState


@export var muzzle : Marker2D
@export var entity : CharacterBody2D
@onready var has_shot: Timer = $has_shot
@export var FSM : NodeFiniteStateMachine
@export var weapon : ProjectileWeapon

var direction_to_player : Vector2
var player : CharacterBody2D
var knife_projectile_scene = preload("res://Characters/goblin/Goblin_Knife.tscn")


func enter():
	
	player = PlayerManager.player
	entity.velocity = Vector2.ZERO
	has_shot.wait_time = 1.0/weapon.fire_rate
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
