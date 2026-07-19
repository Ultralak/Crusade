extends Node

@export var FSM : NodeFiniteStateMachine
@export var velocity_component : Node2D
var current_state : String
@export var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = FSM.current_node_state_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	velocity_component.get_input()
	match current_state:
		"idle":
			if velocity_component.move_velocity != Vector2.ZERO: 
				FSM.transition_to("run")
			elif Input.is_action_pressed("primary_attack"):
				FSM.transition_to("primary_attack")
		"run":
			if velocity_component.move_velocity == Vector2.ZERO : 
				FSM.transition_to("idle")
			elif Input.is_action_pressed("primary_attack"):
				FSM.transition_to("primary_attack")
		"primary_attack":
			pass
