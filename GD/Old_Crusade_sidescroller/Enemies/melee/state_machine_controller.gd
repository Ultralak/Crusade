extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var animation_player : AnimationPlayer
@export var wait_time : float = 1.0
@export var health_component : HealthComponent
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	match node_finite_state_machine.current_node_state_name:
		"hurt":
			var timer = Timer.new()
			timer.one_shot = true
			timer.wait_time = 1.0
			add_child(timer)
			timer.timeout.connect(on_timer_timeout)
			timer.start()
			
func on_timer_timeout():
	if health_component.health <= 0:
		node_finite_state_machine.transition_to("dead")
	else:
		node_finite_state_machine.transition_to("idle")
	
