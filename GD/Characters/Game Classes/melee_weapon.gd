@icon("uid://bwtclp67oepwx")
extends Weapon
class_name MeleeWeapon


@onready var pivot: Marker2D = $pivot
@onready var non_physics: Node2D = $"pivot/Non-Physics"
@onready var input_manager: Node2D = $pivot/InputManager
@onready var animation_player: AnimationPlayer = $"pivot/Non-Physics/AnimationPlayer"
@onready var weapon: Sprite2D = $"pivot/Non-Physics/weapon"


@export var swings_per_second : int = 3


var FSM : NodeFiniteStateMachine
var slash_direction : Vector2
var weapon_user : CharacterBody2D
var mouse_direction : Vector2
var melee_setup : bool = false
var knockback_dir : Vector2 
var in_state : bool = false

func _process(_delta: float) -> void:
	rotate_and_flip_weapon()
	if in_state:
		input_manager.InputManaging()

func setup_weapon_paladin( direction : Vector2, user : CharacterBody2D, userpivot : Marker2D, slot : String)->void:
	slash_direction = direction
	knockback_dir = direction
	weapon_user = user
	slot_index = slot
	pivot.global_position = userpivot.global_position
	melee_setup = true
	critical_hit()

func rotate_and_flip_weapon()->void:
	if weapon_user is Character:
		mouse_direction  = (get_global_mouse_position() - pivot.global_position).normalized()
		if weapon_user.can_turn:
			pivot.rotation = mouse_direction.angle()
			if mouse_direction.x < 0:
				non_physics.scale.y = -1
				#weapon.flip_v = true
				
			elif mouse_direction.x > 0:
				non_physics.scale.y = 1
				#weapon.flip_v = false
	
func slash():
	animation_player.play("slash")
