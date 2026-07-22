extends Node2D
class_name PlayerDetectionComponent


@export var FSM : NodeFiniteStateMachine
@export var enemy : CharacterBody2D
@export var raycast : RayCast2D
var target : CharacterBody2D
var detection_radius : float
var distance_to_player : float
var max_chase_distance : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detection_radius = enemy.detection_radius
	max_chase_distance  = enemy.max_chase_distance
	raycast.enabled = false
	if detection_radius >= max_chase_distance:
		printerr("Detection radius is bigger than max distance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if FSM.current_node_state_name != "idle" :
		if is_out_of_bounds():
				FSM.transition_to("idle")
		return
	else:
		if !target:
			target = PlayerManager.player
		else :
			distance_to_player = enemy.global_position.distance_to(target.global_position)
			if distance_to_player <= detection_radius  :
				raycast.enabled = true
				raycast.target_position = target.global_position - raycast.global_position
				raycast.force_raycast_update()
				if raycast.is_colliding():
					#print("Object_name : %s" % [raycast.get_collider().get_class()])
					if raycast.get_collider() is Character:
						print("true")
						raycast.enabled = false
						FSM.transition_to("chase")
					else:
						pass
				else:
					#print("not colliding")
					pass
			else:
				
				raycast.enabled = false
	
	
func is_out_of_bounds():
	if target:
		return enemy.global_position.distance_to(target.global_position) > max_chase_distance

	
