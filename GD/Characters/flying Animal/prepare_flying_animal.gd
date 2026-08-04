extends NodeState
@export var timer : Timer
@export var enemy : CharacterBody2D
@export var FSM : NodeFiniteStateMachine
@export var time : float = 0.2
@export var warning_label : Label
var can_attack : bool = false

var player : Character
# Hold for a small period and transition to dash
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player
	enemy.velocity = Vector2.ZERO

func enter():
	var direction_to_player : Vector2 = enemy.global_position.direction_to(player.weapon_pivot.global_position ) 
	enemy.direction_to_player = direction_to_player
	can_attack = true
	timer.one_shot = true
	timer.wait_time = time
	timer.start()
	warning_label.visible = true
	
	
func exit():
	warning_label.visible = false
	can_attack = false

func _on_prepare_timer_timeout() -> void:
	if can_attack:
		FSM.transition_to("attack")
