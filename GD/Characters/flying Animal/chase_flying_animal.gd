extends NodeState

@export var navigation_component : Node2D
@export var enemy : CharacterBody2D
@export var line : Line2D
const max_trail_count : int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	
	
	navigation_component.enable_navigation()
	navigation_component.recalculate_path()
	animation_player.play("idle")

	line.clear_points()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_physics_process(_delta: float) -> void:
	if line.points.size() >= max_trail_count:
		line.remove_point(0)
	line.add_point(enemy.global_position)
	
	navigation_component.recalculate_path()
	enemy.velocity = navigation_component.new_velocity
	enemy.move_and_slide()

func exit():
	line.clear_points()
	animation_player.stop()
	navigation_component.disable_navigation()
