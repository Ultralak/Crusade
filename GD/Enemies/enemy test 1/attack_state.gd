extends NodeState

@export var characterbody2d : CharacterBody2D
@export var animatedsprite2d : AnimatedSprite2D
signal animation_done

@onready var hit_box: Area2D = $"../../Hit_box"
@onready var attack_timer: Timer = $attack_timer

var player : CharacterBody2D
var direction : int 

func on_process(_delta : float):
	pass
		
	
func on_physics_process(delta : float):
	pass

func enter():
	animatedsprite2d.play("attack")
	

func exit():
	animatedsprite2d.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	animation_done.emit()
