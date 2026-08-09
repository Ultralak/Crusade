extends Node2D

@export var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move()


func move()->void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(sprite,"global_position:x",50,1)
	tween.set_parallel(true)
	tween.tween_property(sprite,"scale",Vector2(2,2),1)
	tween.tween_property(sprite,"scale",Vector2(1,1),1).set_delay(1)
	
