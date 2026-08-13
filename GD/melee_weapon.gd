@icon("uid://bwtclp67oepwx")
extends Node2D
class_name MeleeWeapon


@onready var pivot: Marker2D = $pivot
@onready var non_physics: Node2D = $"pivot/Non-Physics"
@onready var input_manager: Node2D = $pivot/InputManager
@onready var animation_player: AnimationPlayer = $"pivot/Non-Physics/AnimationPlayer"


@export var swings_per_second : int = 3
@export var damage_amount : float
@export var critical_hit_chance : float

var FSM : NodeFiniteStateMachine
var slash_direction : Vector2
var weapon_user : CharacterBody2D
var weapon_user_pivot : Marker2D
var mouse_direction : Vector2
var melee_setup : bool = false
var slot_index : int 
var in_state : bool = false

func _process(_delta: float) -> void:
	rotate_and_flip_weapon()
	if in_state:
		input_manager.InputManaging()

func setup_weapon_paladin( direction : Vector2, user : CharacterBody2D, userpivot : Marker2D, slot)->void:
	slash_direction = direction
	weapon_user = user
	slot_index = slot
	weapon_user_pivot = userpivot
	melee_setup = true

func rotate_and_flip_weapon()->void:
	if weapon_user is Character:
		mouse_direction  = (get_global_mouse_position() - weapon_user_pivot.global_position).normalized()
		if weapon_user.can_turn:
			weapon_user_pivot.rotation = mouse_direction.angle()
			if mouse_direction.x < 0:
				non_physics.scale.y = -1
			
			elif mouse_direction.x > 0:
				non_physics.scale.y = 1
	
func slash():
	animation_player.play("slash")
