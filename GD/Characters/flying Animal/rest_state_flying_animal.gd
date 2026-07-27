extends NodeState

@export var rest_time : float = 1.0
@export var rest_timer : Timer
@export var enemy : CharacterBody2D
@export var FSM : NodeFiniteStateMachine
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	rest_timer.timeout.connect(on_timeout)
func enter():
	rest_timer.one_shot = true
	
	rest_timer.wait_time = rest_time
	rest_timer.start()
	animation_player.play("idle")
	
func exit():
	animation_player.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_timeout() -> void:
	FSM.transition_to("chase")
