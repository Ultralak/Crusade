extends Node2D

# this should be individualised to each weapon especially the is_attacking function
@export var weapon : MeleeWeapon
@export var slash_name : String = "slash"
@onready var animation_player: AnimationPlayer = $"../Non-Physics/AnimationPlayer"
@onready var slash_rate_timer: Timer = $slashRateTimer

var can_slash : bool  = true


func InputManaging()->void:
	if is_default_attacking():
		default_slash()
		
func default_slash()->void:
	animation_player.play(slash_name)
	
	can_slash = false
	
	slash_rate_timer.wait_time = 1.0/weapon.swings_per_second
	slash_rate_timer.one_shot = true
	slash_rate_timer.start()
	
func _on_slash_rate_timer_timeout() -> void:
	can_slash = true
	
func is_default_attacking() -> bool:
	var first_slot = weapon.slot_index == 1 and Input.is_action_pressed("slot_1")
	var second_slot = weapon.slot_index == 2 and Input.is_action_pressed("slot_2")
	return first_slot and second_slot
