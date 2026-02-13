extends NodeState

@export var character_body_2d : CharacterBody2D


@export var fall: NodeState
@onready var state_machine: NodeFiniteStateMachine = $".."
@onready var collision_shape_2d: CollisionShape2D = $"../../hit_box/CollisionShape2D"
@onready var air_timer: Timer = $air_timer


@export_category("Slash_state")
@export var air_time : float
@export var fixed_offset : float = 20

var stop_fall : bool = false

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction = GameInputEvents.movement_input()
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0 ,100 )
	character_body_2d.move_and_slide()
	
	if stop_fall:
		character_body_2d.velocity.y = move_toward(character_body_2d.velocity.y, 0 , 10)
	else:
		character_body_2d.velocity.y += fall.fall_gravity * delta
	
	if !GameInputEvents.slash_input():
		if !character_body_2d.is_on_floor():
			transition.emit("fall")
			return
		elif direction != 0:
			transition.emit("run")


	if GameInputEvents.jump_input():
		transition.emit("jump")
		return
		

func enter():
	update_attack_area()
	if state_machine.previous_node_state_name == "fall" or state_machine.previous_node_state_name == "jump":
		stop_fall = true
		air_timer.start(air_time)

	animation_player.speed_scale = 1.5
	animation_player.play("main_slash")
	

	
func exit():
	animation_player.speed_scale = 1
	
	collision_shape_2d.set_deferred("disabled", true)



	


func _on_air_timer_timeout() -> void:
	stop_fall = false
	
func update_attack_area():
	var direction = 1 if sprite_2d.flip_h else -1
	collision_shape_2d.position.x = fixed_offset * direction


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "main_slash":
		if GameInputEvents.slash_input():
			force_transition.emit("slash")
		else:
			transition.emit("idle")
