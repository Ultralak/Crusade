extends Node

@export var entity : CharacterBody2D
@export var FSM : NodeFiniteStateMachine
var player : Character
@export var sweet_spot : float = 100
@export var deadzone : float = 10
func _ready() -> void:
	player = PlayerManager.player 

func _process(_delta: float) -> void:
	match FSM.current_node_state_name:
		"idle":
			if within_sweet_spot():
				FSM.transition_to("prepare")
			elif can_approach():
				FSM.transition_to("approach")
			elif can_retreat():
				FSM.transition_to("retreat")
		"retreat": 
			if entity.retreat_finished:
				FSM.transition_to("idle")
				entity.retreat_finished = false
				
		"approach" : 
			if within_sweet_spot():
				FSM.transition_to("prepare")
			elif entity.approach_finished:
				FSM.transition_to("idle")
				entity.approach_finished = false
		#

func within_sweet_spot()->bool:
	if !player:
		return false
	var distance := entity.global_position.distance_to(player.global_position)
	return sweet_spot - deadzone <= distance and distance <= sweet_spot + deadzone

func can_retreat()->bool:
	if !player:
		return false
	return entity.global_position.distance_to(player.global_position) < sweet_spot - deadzone

func can_approach()->bool:
	if !player:
		return false
	return entity.global_position.distance_to(player.global_position) > sweet_spot + deadzone
