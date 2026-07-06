extends Node

var Objects_to_flip : Array
var state_machine : NodeFiniteStateMachine
var previous_direction : int = -2
func _ready() -> void:
	# check for performance
	for child in get_parent().get_children():
		if child is NodeFiniteStateMachine:
			state_machine = child
	if state_machine:
		for child in state_machine.get_children():
			if child.has_signal("direction_changed"):
				child.direction_changed.connect(flip)


	for child in get_parent().get_children():
		if child is Marker2D or child is RayCast2D or child is Area2D:
			Objects_to_flip.append(child)



	
func flip():
	for child in Objects_to_flip:
		child.position.x *= -1
		if child is RayCast2D:
			child.target_position.x *= -1

	
