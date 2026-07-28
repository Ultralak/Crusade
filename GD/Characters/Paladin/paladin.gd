extends Character
#damage and health script




@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var max_health : float = 10
@export var debug_label : Label
@export var dash_speed : float = 500
@export var dashTime : float = 0.2
var knockback_direction : Vector2 
var can_turn : bool = true
var can_attack  :bool = true
var mouse_direction : Vector2
@export var debug_enabled : bool 
func _ready() -> void:
	PlayerManager.register_player(self)
	debug_label.visible = debug_enabled

func _process(_delta: float) -> void:
	knockback_direction = (get_global_mouse_position() - global_position).normalized()
	if can_turn:
		mouse_direction = (get_global_mouse_position() - global_position).normalized()
		if mouse_direction.x > 0 and animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = true

	
func _physics_process(_delta: float) -> void:
	move_and_slide()
