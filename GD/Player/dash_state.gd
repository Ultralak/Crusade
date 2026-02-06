extends NodeState

@export var character_body_2d : CharacterBody2D



@export_category("Dash_state")
@export var Dash_speed : int = 3000
@export var friction : int = 200
@export var dash_particles : GPUParticles2D
func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):

	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, friction)
	character_body_2d.move_and_slide()
	if character_body_2d.velocity.x == 0:
		if not character_body_2d.is_on_floor():
			transition.emit("fall")
			return
	# dashing resets jump, fix that
		if GameInputEvents.jump_input() :
			transition.emit("jump")
			return
			
		if  character_body_2d.is_on_floor():
			transition.emit("idle")
			return
		
func enter():
	dash_particles.emitting = true
	character_body_2d.set_collision_layer_value(2,false)
	character_body_2d.set_collision_mask_value(3,false)
	character_body_2d.set_collision_layer_value(6,true)
	var direction = GameInputEvents.movement_input()
	if direction == 0:	
		direction  = -1 if sprite_2d.flip_h else 1
	dash_particles.scale.y = -1 if sprite_2d.flip_h else 1
	character_body_2d.velocity.x  += direction * Dash_speed
	character_body_2d.velocity.y = 0
	
	animation_player.play("dash")
	
	
func exit():
	character_body_2d.set_collision_layer_value(2,true)
	character_body_2d.set_collision_mask_value(3,true)
	character_body_2d.set_collision_layer_value(6,false)
	
	
	animation_player.stop()
	
	await  get_tree().create_timer(0.1).timeout
	
	dash_particles.emitting  = false
