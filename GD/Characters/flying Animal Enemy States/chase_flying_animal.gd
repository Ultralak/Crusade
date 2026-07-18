extends NodeState

@export var navigation_component : Node2D
@export var enemy : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	navigation_component.recalculate_path()
	animation_player.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_physics_process(_delta: float) -> void:
	navigation_component.recalculate_path()
	enemy.velocity = navigation_component.new_velocity
	enemy.move_and_slide()

func exit():
	animation_player.stop()
	navigation_component.disable_navigation()
