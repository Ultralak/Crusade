extends Label

@export var health_comp : HealthComponent
@export var enemy : CharacterBody2D
@export var FSM : NodeFiniteStateMachine
var new_state_name : String = "null"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var state_name : String = FSM.current_node_state_name
	if is_state_changed(state_name):
		#print("Enemy Flying Animal State : %s" % state_name)
		new_state_name = state_name
	text = "Health : %s, Velocity : %s, State : %s" % [health_comp.health,enemy.velocity,state_name ]

func is_state_changed(s_name :String):
	return new_state_name != s_name
