extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var enemy_1 : CharacterBody2D
@export var animation_player : AnimationPlayer

@export_category("Distances")
@export var detect_distance : float = 100
@export var attack_distance : float = 20
var is_dead : bool = false

var distance : float = 10000

func _physics_process(_delta: float) -> void:
	var player_pos = PlayerManager.get_player_position()
	if player_pos == Vector2.ZERO:
		return
	distance = (player_pos - enemy_1.global_position).length()
	
	var current_state = node_finite_state_machine.current_node_state_name
	
	if current_state == "attack" or current_state == "death" or current_state == "recovery" or current_state == "hurt":
		return
	if  distance < attack_distance:
		if current_state != "attack":
			node_finite_state_machine.transition_to("attack")
	elif distance > attack_distance and distance < detect_distance:
		if current_state != "run":
			node_finite_state_machine.transition_to("run")
	else:
		if current_state != "idle":
			node_finite_state_machine.transition_to("idle")


func _on_test_enemy_enemy_hit() -> void:
	node_finite_state_machine.transition_to("hurt")



func _on_player_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		node_finite_state_machine.transition_to("recovery")
	if anim_name == "death":
		enemy_1.queue_free()


func _on_health_component_enemy_hit() -> void:
	node_finite_state_machine.transition_to("hurt")
