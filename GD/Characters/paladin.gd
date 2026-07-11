extends Character
#damage and health script


@onready var sword_anim: AnimationPlayer = $"sword/non-physics/sword_anim"
@onready var non_physics: Node2D = $"sword/non-physics"
@onready var sword: Node2D = $sword
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var physics: Node2D = $sword/physics

var can_turn : bool = true



var left : CollisionShape2D
var right : CollisionShape2D
var left_active : bool
var right_active : bool

func _ready() -> void:

	left = physics.get_child(0).get_child(0)
	right = physics.get_child(0).get_child(1)

	right.disabled = true
	right.visible = false
	right_active = false
	left_active = true

func _process(_delta: float) -> void:
	if can_turn:
		var mouse_direction : Vector2 = (get_global_mouse_position() - global_position).normalized()
		if mouse_direction.x > 0 and animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = true
		
	# rotate sword. remove when not needed
	
		non_physics.rotation = mouse_direction.angle()
		physics.rotation = mouse_direction.angle()
		if non_physics.scale.y  == 1 and mouse_direction.x < 0:
			non_physics.scale.y = -1
			swap_collisions()
		elif non_physics.scale.y == -1 and mouse_direction.x > 0:
			non_physics.scale.y = 1
			swap_collisions()
		

func swap_collisions() -> void:
	#right.disabled = !right.disabled
	right.visible = !right.visible
	right_active  = !right_active
	left_active  = !left_active
	#left.disabled = !left.disabled
	left.visible = !left.visible
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func enable_right():
	if right_active:
		right.disabled = false
	
func enable_left():
	if left_active:
		left.disabled = false
		
	
