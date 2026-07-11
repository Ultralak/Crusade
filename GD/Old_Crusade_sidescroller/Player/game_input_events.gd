class_name GameInputEvents
extends Node
#[Useless] code in paladin script( code for player ) replaces this

static func movement_input() -> float:
	var direction : float = Input.get_axis("move_left","move_right")
	return direction
	
	
static func jump_input() -> bool:
	var jump_input_ : bool  = Input.is_action_just_pressed("jump")
	return jump_input_
	
	
static func slash_input() -> bool:
	var slash_input_ : bool  = Input.is_action_pressed("slash")
	return slash_input_	

static func crouch_input() -> bool:
	var crouching : bool  = Input.is_action_pressed("crouch")
	return crouching

	
static func dash_input() -> bool:
	var dashing : bool = Input.is_action_just_pressed("dash")
	return dashing
	

	
