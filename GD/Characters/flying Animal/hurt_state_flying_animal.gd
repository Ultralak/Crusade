extends NodeState

@export var characterbody2d : CharacterBody2D
@export var healthcomponent : HealthComponent
@export var node_finite_state_machine : NodeFiniteStateMachine
@export var Navigation_component : Node2D
@export var timer : Timer
@export var time : float = 1.0
@export var dust_particles : CPUParticles2D
var is_setup : bool = false

# is_setup is a boolean that is sent to the navigation node so i can turn of navigation
# when the knockback variables are setup so the knock back can take effect

var knk_direction : Vector2
var knk_force : float
@export var friction = 50

func _ready() -> void:
	if !characterbody2d:
		characterbody2d = get_parent().get_parent()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_physics_process(delta: float) -> void:
	characterbody2d.velocity = characterbody2d.velocity.move_toward(Vector2.ZERO,friction * delta)
	characterbody2d.move_and_slide()
	
func enter():
	dust_particles.rotation = knk_direction.angle_to(Vector2.ZERO)
	timer.one_shot = true
	timer.wait_time = time
	timer.start()
	
	characterbody2d.velocity = knk_direction * knk_force
	animation_player.play("hit")
	if healthcomponent.health <= 0:
		node_finite_state_machine.transition_to("dead")


func exit():
	Navigation_component.enable_navigation()
	
func set_knockback(direction : Vector2, force : float):
	knk_direction = direction
	knk_force = force
	is_setup = true
	print("hurt state : is_setup = true")



func _on_hurt_timer_timeout() -> void:
	is_setup = false
	print("hurt state : is_setup = false")
	node_finite_state_machine.transition_to("chase")
	
