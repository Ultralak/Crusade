extends NodeState
@export var FSM : NodeFiniteStateMachine
@export var warning_text : Label
@onready var prepare_timer: Timer = $prepare
@export var prepare_timer_time : float = 0.5
@export var entity : Enemy
var player : CharacterBody2D

func _ready() -> void:
	player = PlayerManager.player
func enter():
	animation_player.play("idle")
	var direction_to_player : Vector2 = entity.global_position.direction_to(player.weapon_pivot.global_position)
	entity.direction_to_player = direction_to_player
	warning_text.visible = true
	timer_setup(prepare_timer,prepare_timer_time)
	
func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	pass
	
func exit():
	animation_player.stop()
	warning_text.visible = false

func timer_setup(timer : Timer, time : float)->void:
	timer.wait_time = time
	timer.one_shot  = true
	timer.start()
	
	

func _on_prepare_timeout() -> void:
	FSM.transition_to("shoot")
