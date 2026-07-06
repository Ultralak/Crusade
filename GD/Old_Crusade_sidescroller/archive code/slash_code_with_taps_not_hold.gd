#extends NodeState
#
#@export var character_body_2d : CharacterBody2D
#@export var animated_sprite_2d : AnimatedSprite2D
#
#@export_category("Slash_state")
#
#var slash_level : int
#var executed : bool = false
#
#func on_process(_delta : float):
	#pass
	#
#func on_physics_process(_delta : float):
	#var direction = GameInputEvents.movement_input()
	#
	#if direction != 0:
		#transition.emit("run")
#
	#if GameInputEvents.slash_input():
		#if !executed:
			#slash_level += 1
			#executed = true
		#else:
			#pass
#
	#if not character_body_2d.is_on_floor():
		#transition.emit("fall")
		#return
#
	#if GameInputEvents.jump_input():
		#transition.emit("jump")
		#return
		#
#
#func enter():
	#animated_sprite_2d.play("slash 1")
	#slash_level = 1
	#
#func exit():
	#animated_sprite_2d.stop()
#
#
#
#func _on_animated_sprite_2d_animation_finished() -> void:
	#if executed:
		#if slash_level == 3:
			#slash_level = 1
		#animated_sprite_2d.play("slash %d" % [slash_level])
		#executed = false
	#else  :
		#transition.emit("idle")
