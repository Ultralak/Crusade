extends Marker2D
class_name DoorMarker

enum  Direction{Up,Right,Down,Left}
@export var direction : Direction
@onready var area_2d: Area2D = $Area2D
@export var activated : bool = true
var is_connected : bool = false
