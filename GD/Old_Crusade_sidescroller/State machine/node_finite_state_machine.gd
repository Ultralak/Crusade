class_name NodeFiniteStateMachine
extends Node

@export var initial_node_state : NodeState
@export var player : CharacterBody2D



var node_states : Dictionary = {}

var current_node_state: NodeState
var current_node_state_name : String
var FlipComponent : Node

func _ready():
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
			child.force_transition.connect(force_transition_to) # might remove
			# checks the children of the scene for any nodestates and adds to the dictionary and connects to the signals


	if initial_node_state:
		initial_node_state.enter()
		current_node_state = initial_node_state
		current_node_state_name = initial_node_state.name
		
		# if initial node state exists transition to it
		

		
func _process(delta : float):
	if current_node_state:
		current_node_state.on_process(delta)
	
func _physics_process(delta: float) -> void:
	
	if current_node_state:
		current_node_state.on_physics_process(delta)
	#if  !printed:	
		#print("Current State: ", current_node_state_name )
		#printed = true	
	
func transition_to(node_state_name: String):

	if node_state_name == current_node_state_name.to_lower():
		return
		# doesn't call the same state again
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state:
		return
		
	if current_node_state:
		current_node_state.exit()
		

	new_node_state.enter()
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
		

func force_transition_to(node_state_name	):
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state:
		return
		
	if current_node_state:
		current_node_state.exit()
		

	new_node_state.enter()
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
