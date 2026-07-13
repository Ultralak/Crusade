extends NodeState

@export var characterbody2d : CharacterBody2D
@export var healthcomponent : HealthComponent
@export var statemachine : NodeFiniteStateMachine

var knk_direction : Vector2
var knk_force : float

func _ready() -> void:
	if !characterbody2d:
		characterbody2d = get_parent().get_parent()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	knock_back(-knk_direction, knk_force)
	
func enter():
	characterbody2d.velocity = Vector2.ZERO
	knock_back(-knk_direction, knk_force)
func exit():
	pass

func knock_back(direction : Vector2, force : float) -> void:
	characterbody2d.velocity += direction * force

func set_knockback(direction : Vector2, force : float):
	knk_direction = direction
	knk_force = force
