extends Label
@onready var jump: Node = $"../state_machine/jump"
@onready var fall: Node = $"../state_machine/fall"
@onready var player: CharacterBody2D = $".."


@export var state_mach : NodeFiniteStateMachine 
var words : String = ""
var printed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if jump.jumps:
		words = "%s" % [jump.jumps]

	text = state_mach.previous_node_state_name + " -> " + state_mach.current_node_state_name+ " " + words	
	printed = false
