extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D

@export_category("Fall state")
@export var coyote_time : float = 0.5
@export var speed : float  = 200
@export var max_horizontal_speed : float = 200
@export var jump_count : int = 2
@onready var jump_buffer_time : Timer 
@export var max_jump_buffer_time : float  = 0.1

@onready var jump: Node = $"../jump"
@onready var jump_buffer_timer: Timer = $jump_buffer_timer


const GRAVITY : int = 1000
var coyote_jump : bool 

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction = GameInputEvents.movement_input()
	

	
		
	
	if !character_body_2d.is_on_floor():
		character_body_2d.velocity.y += GRAVITY * delta
		if direction != 0 :
			character_body_2d.velocity.x += direction * speed
			character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_horizontal_speed, max_horizontal_speed)
			animated_sprite_2d.flip_h = false if direction > 0 else true
		else:
			character_body_2d.velocity.x = 0
			
		if GameInputEvents.jump_input():
			jump_buffer_timer.start()
			if coyote_jump :
				transition.emit("jump")
			
	character_body_2d.move_and_slide()
	#Transition states
	
	#Transition to idle state
	if character_body_2d.is_on_floor():
		if jump_buffer_time:
			if !jump_buffer_time.is_stopped():
				transition.emit("jump")
			else:
				transition.emit("idle")
		else:
			transition.emit("idle")
	
	if GameInputEvents.slash_input():
		transition.emit("slash")
		return
	
		
func enter():
	coyote_jump = true
	get_coyote_time()
	animated_sprite_2d.play("fall")
	
	
func exit():
	animated_sprite_2d.stop()
	if jump_buffer_time:
		jump_buffer_time.stop()
	
func get_coyote_time():
	await get_tree().create_timer(coyote_time).timeout
	coyote_jump = false


	
	
