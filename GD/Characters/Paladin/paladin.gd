extends Character
class_name Paladin
#damage and health script



@export var DEBUGMODE : bool = false


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_pivot: Marker2D = $weapon_pivot


@export var Inventory : InventorySystem
@export var max_health : float = 10
@export var velocity_comp : VelocityComponent
@export var debug_label : Label

@export var dash_speed : float = 500
@export var dashTime : float = 0.2

@export var player_center : Node2D
@export var freeze_slow := 0.07
@export var freeze_time := 0.3
@export var debug_enabled : bool

var knockback_direction : Vector2 
var can_turn : bool = true
var can_attack  :bool = true
var mouse_direction : Vector2


func _ready() -> void:
	if DEBUGMODE:
		debug_mode()
	PlayerManager.register_player(self)
	debug_label.visible = debug_enabled

func _process(_delta: float) -> void:
	knockback_direction = (get_global_mouse_position() - global_position).normalized()
	if can_turn:
		GlobalSignals.player_turned.emit()
		mouse_direction = (get_global_mouse_position() - global_position).normalized()
		if mouse_direction.x > 0 and animated_sprite_2d.flip_h:
			
			animated_sprite_2d.flip_h = false
			weapon_pivot.position.x = abs(weapon_pivot.position.x)
			
			
		elif mouse_direction.x < 0 and not animated_sprite_2d.flip_h:
			
			animated_sprite_2d.flip_h = true
			weapon_pivot.scale.x = 1
			weapon_pivot.position.x = -abs(weapon_pivot.position.x)
			

	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func debug_mode() -> void:
	velocity_comp.Max_speed = 400
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, false)
	

func hit_stop() ->void:
	Engine.time_scale = freeze_slow
	await get_tree().create_timer(freeze_time,true,false,true).timeout
	Engine.time_scale = 1
	
	
	

	
	
	
	
	
	
	
	
	
	
