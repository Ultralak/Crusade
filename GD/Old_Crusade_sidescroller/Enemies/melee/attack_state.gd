extends NodeState

@export_category("attack melee state")
@export var characterbody2d : CharacterBody2D
@export var hit: CollisionShape2D 
@export var state_machine_controller: Node 
@export var attack_warning : Label
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
		sprite_2d.flip_h = false
	elif player_pos.x > characterbody2d.global_position.x:
		sprite_2d.flip_h = true
	update_hitbox()
	animation_player.play("attack")
	characterbody2d.velocity.x = 0

	
func exit():
	animation_player.stop()
	attack_warning.text = ""

		
func update_hitbox():
	var direction = 1 if sprite_2d.flip_h else -1
	hit.position.x = fixed_offset * direction
	


	
