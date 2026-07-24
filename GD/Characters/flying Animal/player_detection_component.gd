extends Node2D
class_name PlayerDetectionComponent


@export var FSM : NodeFiniteStateMachine
@export var enemy : CharacterBody2D
@export var raycast : RayCast2D

var target : CharacterBody2D
var detection_radius : float
var distance_to_player : float
var max_chase_distance : float
var chase_begun : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detection_radius = enemy.detection_radius
	max_chase_distance  = enemy.max_chase_distance
	if detection_radius >= max_chase_distance:
		printerr("Detection radius is bigger than max distance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if FSM.current_node_state_name != "idle" :
		if is_out_of_bounds():
				chase_begun = false
				FSM.transition_to("idle")
	else:
		if !target:
			target = PlayerManager.player
		if target :
			if chase_begun : 
				FSM.transition_to("chase")
			distance_to_player = enemy.global_position.distance_to(target.global_position)
			if distance_to_player <= detection_radius  :
				if check_if_player_detected() and !chase_begun:
					FSM.transition_to("chase")
					chase_begun = true
					
	
func check_if_player_detected() -> bool:
	raycast.enabled = true
	raycast.target_position = target.global_position - raycast.global_position
	raycast.force_raycast_update()
	if raycast.is_colliding():
		#print("Object_name : %s" % [raycast.get_collider().get_class()])
		if raycast.get_collider() is Character:
			raycast.enabled = false
			return true
	raycast.enabled = false
	return false
		

func is_out_of_bounds():
	if target:
		return enemy.global_position.distance_to(target.global_position) > max_chase_distance

	
