extends Label

@export var state_machine_enemy: NodeFiniteStateMachine
@export var test_enemy: CharacterBody2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = state_machine_enemy.current_node_state_name + " %s" % [EnemyHealthManager.get_health_data(test_enemy.name)]
