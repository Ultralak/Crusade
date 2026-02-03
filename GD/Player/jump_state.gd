extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine  : NodeFiniteStateMachine

@export_category("Jump_State")
@export var max_jump : int 
@export var Fall_Node : NodeState

@export var move_speed : float
@export var jump_height : float  
@export var time_to_peak : float
@export var time_to_descent : float
@export var max_horizontal_speed : float

@onready var jump_velocity : float = ((2.0 * jump_height) / time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (time_to_peak * time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (time_to_descent * time_to_descent)) * -1.0


var jumps : int 

func on_process(_delta : float):
	pass
		
	
func on_physics_process(delta : float):
	var direction  = GameInputEvents.movement_input()
	   
	character_body_2d.move_and_slide()
	#multiple jumps
	if !character_body_2d.is_on_floor():
		character_body_2d.velocity.y += jump_gravity * delta
		if direction != 0:
			animated_sprite_2d.flip_h = false if direction > 0 else true
			character_body_2d.velocity.x += direction * move_speed
			character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_horizontal_speed, max_horizontal_speed)
		else:
			character_body_2d.velocity.x = 0
			# multiple jumps
		if GameInputEvents.jump_input() and jumps > 0 :
			character_body_2d.velocity.y = jump_velocity
			jumps -= 1
	else:
		transition.emit("idle")
		return
		
		#transitioning states
	#fall state
	if character_body_2d.velocity.y > 0:
		transition.emit("fall")
	
	#slash state
	if GameInputEvents.slash_input():
		transition.emit("slash")
		return
	# dash state
	if GameInputEvents.dash_input():
		transition.emit("dash")
		return

func enter():
	#comes from idle
	character_body_2d.set_collision_mask_value(4 , false)
	if max_jump <= 0:
		transition.emit("idle")
		return
		
	if character_body_2d.is_on_floor() :
		jumps = max_jump
	elif Fall_Node.coyote_jump : 
		jumps += 1
		Fall_Node.coyote_jump = false
	animated_sprite_2d.play("jump")
	character_body_2d.velocity.y = jump_velocity
	jumps -= 1

		

func exit():
	character_body_2d.set_collision_mask_value(4, true)
	animated_sprite_2d.stop()

func get_jump_gravity():
	return jump_gravity
	
func get_fall_gravity():
	return fall_gravity
