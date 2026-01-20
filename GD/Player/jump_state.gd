extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine  : NodeFiniteStateMachine

@export_category("Jump_State")
@export var jump_height : float  = -250
@export var jump_horizontal_speed : int = 200
@export var max_jump_horizontal_speed : int = 200
@export var jump_gravity : int  = 1000
@export var max_jump : int 
@export var Fall_Node : NodeState

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
			character_body_2d.velocity.x += direction * jump_horizontal_speed
			character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
		else:
			character_body_2d.velocity.x = 0
			# multiple jumps
		if GameInputEvents.jump_input() and jumps > 0 :
			character_body_2d.velocity.y = jump_height
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
	if max_jump <= 0:
		transition.emit("idle")
		return
		
	if character_body_2d.is_on_floor() :
		jumps = max_jump
	elif Fall_Node.coyote_jump : 
		jumps += 1
		Fall_Node.coyote_jump = false
	animated_sprite_2d.play("jump")
	character_body_2d.velocity.y = jump_height
	jumps -= 1
	

func exit():
	animated_sprite_2d.stop()
