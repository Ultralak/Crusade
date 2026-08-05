extends Label

@export var healthcomp : HealthComponent
@export var FSM  :NodeFiniteStateMachine

@export var enemy : Enemy
var distance_to_player : float
var player : Character
func _ready() -> void:
	player = PlayerManager.player
	


func _process(_delta: float) -> void:
	if player:
		distance_to_player = enemy.global_position.distance_to(player.global_position)
		var state : String = " State : %s" % [FSM.current_node_state_name]
		var health : String = "Health : %s" % [healthcomp.health]
		var dts : String  = " DTS : %s" % [round(distance_to_player)]
		text = health + state + dts
