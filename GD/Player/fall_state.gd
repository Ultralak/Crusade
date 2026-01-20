extends NodeState
@onready var coyote_timer: Timer = $coyote_timer
@onready var jump_buffer_timer: Timer = $jump_buffer_timer

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var Jump_node : NodeState

@export_category("Fall state")
@export var coyote_time : float = 0.1
@export var jump_buffer_time : float = 0.1 
@export var speed : float  = 200
@export var max_horizontal_speed : float = 200
@onready var jump: Node = $"../jump"
@export var jump_friction : int 


const GRAVITY : int = 1200
var coyote_jump : bool  = false
var jump_buffer : bool = false
var prevNode : String

func on_process(_delta : float):
	pass

func on_physics_process(delta : float):
	var direction = GameInputEvents.movement_input()
	character_body_2d.velocity.y += GRAVITY * delta
	
	if !character_body_2d.is_on_floor():
		if direction != 0 :
			character_body_2d.velocity.x += direction * speed
			character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_horizontal_speed, max_horizontal_speed)
			animated_sprite_2d.flip_h = false if direction > 0 else true
		else:
			character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0,jump_friction )
			
		if GameInputEvents.jump_input():
			jump_buffer = true
			jump_buffer_timer.start(jump_buffer_time)
			if coyote_jump:
				transition.emit("jump")
				coyote_jump = false
				return
			elif jump.jumps > 0:
				transition.emit("jump")
				return
	else:
		if jump_buffer:
			transition.emit("jump")
			jump_buffer = false
			return
		else:
			Jump_node.jumps = Jump_node.max_jump
			transition.emit("idle")
			return
	character_body_2d.move_and_slide()
	
	
	# slash state
	if GameInputEvents.slash_input():
		transition.emit("slash")
		return
	# dash state
	if GameInputEvents.dash_input():
		transition.emit("dash")
		return
		
func enter():
	var state_machine = get_parent() as NodeFiniteStateMachine
	prevNode = state_machine.previous_node_state_name
	if prevNode.to_lower() ==  "run":
		coyote_jump = true
		jump_buffer_timer.start(jump_buffer_time)
	animated_sprite_2d.play("fall")

func exit():
	animated_sprite_2d.stop()
	coyote_jump = false
	

func _on_coyote_timer_timeout() -> void:
	coyote_jump = false

func _on_jump_buffer_timer_timeout() -> void:
	jump_buffer = false
