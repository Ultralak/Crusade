extends Label


@onready var state_machine: NodeFiniteStateMachine = $"../StateMachine"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = state_machine.current_node_state_name
	
