extends NodeState

var death_explosion : PackedScene = preload("uid://3er4nc5bjvmo")
@export var enemy : Enemy
@export var Navigation_component : NavigationComponent
@export var weapon : ProjectileWeapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Navigation_component.disable_navigation()

func enter():
	PlayerManager.add_coins(enemy.energy_dropped)
	enemy.visible = false
	enemy.emit_is_dead()
	
	
	var death_explosion_instance = death_explosion.instantiate() as Node2D
	death_explosion_instance.global_position = enemy.global_position
	
	get_tree().current_scene.add_child(death_explosion_instance)
	weapon.queue_free()
	enemy.queue_free()
func exit():
	pass
