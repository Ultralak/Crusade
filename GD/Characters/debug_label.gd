extends Label


@onready var state_machine: NodeFiniteStateMachine = $"../StateMachine"
@onready var velocity_component: Node2D = $"../Velocity_Component"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var state : String = state_machine.current_node_state_name
	var move_direction : String = " %s" % [velocity_component.move_direction]
	var velocity = "%s" % [get_parent().velocity]
	
	text = state +" move: " + move_direction + " Velocity: " + velocity
