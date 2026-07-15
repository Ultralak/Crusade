extends NodeState

@export var characterbody2d : CharacterBody2D
@export var healthcomponent : HealthComponent
@export var statemachine : NodeFiniteStateMachine

var is_setup  : bool = false
var knk_direction : Vector2
var knk_force : float
@export var friction = 0.01

func _ready() -> void:
	if !characterbody2d:
		characterbody2d = get_parent().get_parent()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	characterbody2d.velocity = characterbody2d.velocity.lerp(Vector2.ZERO,friction)
	characterbody2d.move_and_slide()
func enter():
	characterbody2d.velocity += knk_direction * knk_force
	animation_player.play("hit")
func exit():
	is_setup = false
	
func set_knockback(direction : Vector2, force : float):
	knk_direction = direction
	knk_force = force
	is_setup = true
