extends NodeState
@export var dash_speed : float = 500
@export var Navigation_node : Node2D
@export var enemy : CharacterBody2D 
@export var timer : Timer
@export var time : float = 0.5
@export var FSM : NodeFiniteStateMachine
@export var Navigation_component : Node2D
var target : CharacterBody2D
var direction : Vector2
var done_prepare
# when the player stops for an extended period of time dash into them and attack them dealing damage
func enter():
	target = Navigation_component.target
	direction = enemy.global_position.direction_to(target.global_position)
	timer_setup()
	animation_player.play("idle")
	

func exit():
	pass
func _physics_process(_delta: float) -> void:
	
	enemy.velocity = direction * dash_speed 
	enemy.move_and_slide()
func _process(_delta: float) -> void:
	pass
	
func timer_setup() -> void:
	timer.one_shot = true
	timer.wait_time = time
	timer.start()


func _on_attack_timer_timeout() -> void:
	FSM.transition_to("idle")
