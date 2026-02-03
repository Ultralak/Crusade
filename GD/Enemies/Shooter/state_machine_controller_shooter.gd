extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var shooter : CharacterBody2D
@export var animation_player : AnimationPlayer
@export_category("Distances")
var distance : float = 10000
var attack_distance : float
var player_pos : Vector2 = Vector2.ZERO
@export var height_offset : float = 30
var time : float
var aware_time : float = 0.15
var current_state : NodeState

func _ready() -> void:
	attack_distance = shooter.attack_distance

func _physics_process(_delta: float) -> void:
	time += _delta
	if time >= aware_time:
		player_pos = PlayerManager.get_player_position()
		time = 0.0
	
	
	if player_pos == Vector2.ZERO:
		return
		
	distance = (player_pos - shooter.global_position).length()
	
	current_state = node_finite_state_machine.current_node_state
	if current_state.unstoppable:
		return
	if  distance < attack_distance and in_range(shooter.global_position.y, player_pos.y, height_offset):
			node_finite_state_machine.transition_to("aim")



func _on_health_component_enemy_hit() -> void:
	node_finite_state_machine.transition_to("hurt")

func in_range(height : float, player_height : float , offset : float):
	return abs(player_height) < abs(height) + offset

func _on_attack_timer_timeout() -> void:
	if current_state.name == "aim":
		node_finite_state_machine.transition_to("fire")
		return
	player_pos = PlayerManager.get_player_position()
	if  distance < attack_distance and in_range(shooter.global_position.y, player_pos.y, height_offset):
		node_finite_state_machine.transition_to("aim")
	else:
		node_finite_state_machine.transition_to("walk")
