extends NodeState

@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D
@export var hit: CollisionShape2D 
@export var attack_warning: Label 
@export var state_machine_controller: Node 

var fixed_offset : float = 17

func on_process(_delta : float):
	pass
		
	
func on_physics_process(_delta : float):
	pass
	
func enter():
	if state_machine_controller.is_dead:
		return
	var player_pos : Vector2 = PlayerManager.get_player_position()
	if player_pos.x < characterbody2d.global_position.x:
		animatedsprite2d.flip_h = false
	elif player_pos.x > characterbody2d.global_position.x:
		animatedsprite2d.flip_h = true
	update_hitbox()
	animatedsprite2d.play("attack")
	characterbody2d.velocity.x = 0
	attack_warning.text = "!!"
	
func exit():
	animatedsprite2d.stop()
	

		
func update_hitbox():
	var direction = 1 if animatedsprite2d.flip_h else -1
	hit.position.x = fixed_offset * direction
	


	

func _on_animated_sprite_2d_frame_changed() -> void:
	if animatedsprite2d.animation == "attack":
		if animatedsprite2d.frame >= 2 and animatedsprite2d.frame <= 4:
			hit.set_deferred("disabled", false)
		else: 
			hit.set_deferred("disabled", true) 
