extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var animation_player : AnimationPlayer

func _physics_process(_delta: float) -> void:
	var player_pos = get_parent().global_position
	if player_pos == Vector2.ZERO:
		return
	var current_state = node_finite_state_machine.current_node_state_name
	match current_state:
		"idle":
			if get_parent().velocity.length() > 0:
				node_finite_state_machine.transition_to("walk")
		"walk":
			if get_parent().velocity.length() < 10:
				node_finite_state_machine.transition_to("idle")
