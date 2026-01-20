extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@onready var fall: Node = $"../fall"
@onready var state_machine: NodeFiniteStateMachine = $".."

@onready var air_timer: Timer = $air_timer

@export_category("Slash_state")
@export var air_time : float
var stop_fall : bool = false

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction = GameInputEvents.movement_input()
	
	if direction != 0:
		animated_sprite_2d.flip_h = false if direction > 0 else true
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0 ,100 )
	character_body_2d.move_and_slide()
	
	if stop_fall:
		character_body_2d.velocity.y = move_toward(character_body_2d.velocity.y, 0 , 10)
	else:
		character_body_2d.velocity.y += fall.GRAVITY * delta
	

	if !GameInputEvents.slash_input():
		if !character_body_2d.is_on_floor():
			transition.emit("fall")
			return
		else:
			transition.emit("idle")
			return

	if GameInputEvents.jump_input():
		transition.emit("jump")
		return
		

func enter():
	
	if state_machine.previous_node_state_name == "fall" or state_machine.previous_node_state_name == "jump":
		stop_fall = true
		air_timer.start(air_time)

	animated_sprite_2d.play("main_slash")

	
func exit():

	animated_sprite_2d.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	if GameInputEvents.slash_input():
		animated_sprite_2d.play("main_slash")


func _on_animated_sprite_2d_frame_changed() -> void:

	var lunge_direction = -1 if animated_sprite_2d.flip_h else 1
	
	if animated_sprite_2d.frame == 3 or animated_sprite_2d.frame == 9:
		character_body_2d.velocity.x = 300 * lunge_direction
	else:
			pass
		
#fall -> slash ( reduce gravity , remove lunge )

func _on_air_timer_timeout() -> void:
	stop_fall = false
	
