extends Node2D
class_name ENDROOM
@onready var ground: TileMapLayer = $Ground
@onready var floor_objects: TileMapLayer = $"floor objects"
@onready var wall: TileMapLayer = $wall
@onready var roof_top: TileMapLayer = $"roof top"
@onready var wall_objects: TileMapLayer = $"wall objects"
@onready var left: Marker2D = $Entrance/left
@onready var right: Marker2D = $Entrance/right
@onready var center: Marker2D = $Entrance/center

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter_next()->void:
	pass
