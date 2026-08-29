@icon("uid://dior6ofoq1cca")
extends Node

@export var FSM : NodeFiniteStateMachine
@export var velocity_component : Node2D
var current_state : String
@export var player : Paladin
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = FSM.current_node_state_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_state = FSM.current_node_state_name
	velocity_component.get_input()
	match current_state:
		"idle":
			if velocity_component.move_velocity != Vector2.ZERO: 
				FSM.transition_to("run")
			elif Input.is_action_just_pressed("dash"):
				FSM.transition_to("dash")
			elif Input.is_action_pressed("Slot 1"):
				FSM.transition_to("Slot 1")
			elif Input.is_action_pressed("Slot 2"):
				FSM.transition_to("Slot 2")
		"run":
			if velocity_component.move_velocity.length() < 3 : 
				FSM.transition_to("idle")
			elif Input.is_action_just_pressed("dash"):
				FSM.transition_to("dash")
			elif Input.is_action_pressed("Slot 1"):
				FSM.transition_to("Slot 1")
			elif Input.is_action_pressed("Slot 2"):
				FSM.transition_to("Slot 2")
		"slot 1":
			if Input.is_action_pressed("Slot 2"):
				FSM.transition_to("Slot 2")
			elif Input.is_action_pressed("dash"):
				FSM.transition_to("dash")
			elif Input.is_action_just_released("Slot 1"):
				FSM.transition_to("idle")
		"slot 2":
			if Input.is_action_pressed("Slot 2"):
				FSM.transition_to("Slot 2")
			elif Input.is_action_pressed("dash"):
				FSM.transition_to("dash")
			elif Input.is_action_just_released("Slot 2"):
				FSM.transition_to("idle")
