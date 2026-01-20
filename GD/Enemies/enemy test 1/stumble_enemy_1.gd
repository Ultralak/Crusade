extends NodeState

@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D
@export var stumble_period : float = 5.0
@export var acceleration : float = 400
@export var speed : float = 500



@onready var attack_warning: Label = $"../../attack_warning"


var player : CharacterBody2D
var direction : int

func on_process(_delta : float):
	pass
	
func on_physics_process(delta : float):
	characterbody2d.velocity.x = move_toward(characterbody2d.velocity.x, speed , delta * acceleration)
	characterbody2d.move_and_slide()

func enter():
	player = get_tree().get_nodes_in_group("PLAYER_")[0] as CharacterBody2D
	if player.global_position < characterbody2d.global_position:
		animatedsprite2d.flip_h = false
		direction = -1
	elif player.global_position > characterbody2d.global_position:
		animatedsprite2d.flip_h = true
		direction = 1
	
	animatedsprite2d.play("run")


func exit():
	attack_warning.text = ""
	animatedsprite2d.stop()
