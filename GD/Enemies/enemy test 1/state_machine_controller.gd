extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine
@export var enemy_1 : CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var stumble_timer: Timer = $"../state_machine_enemy/stumble/stumble_timer"

var player_still_in_area_2d : bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("PLAYER_"):	
		player_still_in_area_2d = true
		node_finite_state_machine.transition_to("walk")
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("PLAYER_"):
		player_still_in_area_2d = false
		if node_finite_state_machine.current_node_state_name == "attack":
			node_finite_state_machine.transition_to("stumble")
		else:
			node_finite_state_machine.transition_to("idle")


func _on_stumble_timer_timeout() -> void:
	node_finite_state_machine.transition_to("idle")


func _on_idle_player_still_in() -> void:
	node_finite_state_machine.transition_to("attack")


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("PLAYER_"):
		node_finite_state_machine.transition_to("attack")


func _on_attack_animation_done() -> void:
	node_finite_state_machine.transition_to("run")


func _on_hit_box_body_exited(body: Node2D) -> void:
	node_finite_state_machine.transition_to("run")
