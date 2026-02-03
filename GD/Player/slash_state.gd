extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

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

	animated_sprite_2d.play("main_slash")

	
func exit():

	animated_sprite_2d.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "main_slash":
		if GameInputEvents.slash_input():
			force_transition.emit("slash")
		else:
			transition.emit("idle")


func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "main_slash":
		var lunge_direction = -1 if animated_sprite_2d.flip_h else 1
		if animated_sprite_2d.frame == 3 or animated_sprite_2d.frame == 9:
			character_body_2d.velocity.x = 300 * lunge_direction
		if (animated_sprite_2d.frame >= 3 and animated_sprite_2d.frame <= 5):
			collision_shape_2d.set_deferred("disabled", false)
		elif (animated_sprite_2d.frame >= 7 and animated_sprite_2d.frame <= 11) :
			collision_shape_2d.set_deferred("disabled", false)
		else:
			collision_shape_2d.set_deferred("disabled", true)



func _on_air_timer_timeout() -> void:
	stop_fall = false
	
func update_attack_area():
	var direction = 1 if animated_sprite_2d.flip_h else -1
	collision_shape_2d.position.x = fixed_offset * direction
