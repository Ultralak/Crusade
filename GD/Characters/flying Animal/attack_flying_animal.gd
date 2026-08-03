extends NodeState
@export var dash_speed : float = 500
@export var Navigation_node : Node2D
@export var enemy : CharacterBody2D 
@export var timer : Timer
@export var time : float = 0.5
@export var FSM : NodeFiniteStateMachine
@export var Damage_Component : DamageComponent
@export var Navigation_component : Node2D
@export var Attackbox : Area2D
var target : CharacterBody2D
var direction : Vector2
var done_prepare
@export var friction : float = 5
# when the player stops for an extended period of time dash into them and attack them dealing damage
func enter():
	if Navigation_component.target:
		target = Navigation_component.target
		direction = Navigation_component.target_direction
	
	enemy.knockback_dir = direction
	enemy.velocity = dash_speed * direction
	timer_setup()
	animation_player.play("idle")
	Attackbox.set_deferred("monitorable", true)
	Attackbox.set_deferred("monitoring", true)
	

func exit():
	
	Attackbox.set_deferred("monitorable", false)
	Attackbox.set_deferred("monitoring", false)
	
	#remove hit entities so hits are registered once
	Damage_Component.entities_hit.clear()
func on_physics_process(_delta: float) -> void:
	
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, friction * _delta)
	enemy.move_and_slide()
func on_process(_delta: float) -> void:
	pass
	
func timer_setup() -> void:
	timer.one_shot = true
	timer.wait_time = time
	timer.start()


func _on_attack_timer_timeout() -> void:
	FSM.transition_to("rest")
