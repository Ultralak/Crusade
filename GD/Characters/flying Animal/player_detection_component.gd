extends Node2D
class_name PlayerDetectionComponent


@export var FSM : NodeFiniteStateMachine
@export var enemy : CharacterBody2D
@export var raycast : RayCast2D
var target : CharacterBody2D
var is_target_setup  : bool = false
var detection_radius : float
var distance_to_player : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detection_radius = enemy.detection_radius
	raycast.enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if FSM.current_node_state_name != "idle":
		return
	if !is_target_setup:
		target = PlayerManager.player
		is_target_setup = true
	else:
		distance_to_player = enemy.global_position.distance_to(target.global_position)
		if distance_to_player <= detection_radius:
			raycast.enabled = true
			raycast.target_position = target.global_position
			if raycast.is_colliding():
				if raycast.get_collider() is Character:
					raycast.enabled = false
					FSM.transition_to("chase")
				else:
					pass
		else:
			raycast.enabled = false
	
	


	
