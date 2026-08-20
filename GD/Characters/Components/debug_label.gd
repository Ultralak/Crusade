extends Label


@onready var state_machine: NodeFiniteStateMachine = $"../StateMachine"
@export var velocity_component: Node2D 
@export var health_component : HealthComponent
@export var interaction_node : ObjectInteraction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var state : String = state_machine.current_node_state_name
	var move_direction : String = " %s" % [velocity_component.move_direction]
	var velocity = "%s" % [get_parent().velocity]
	var health =  "%s" % [health_component.health]
	var closest_interactable : String
	if interaction_node.active_interactable:
		closest_interactable = " C.I : %s" % [interaction_node.active_interactable.get_parent().name]
	else:
		closest_interactable = " C.I : Null"
	text = state +" move: " + move_direction + " Velocity: " + velocity + " health : " + health + closest_interactable
