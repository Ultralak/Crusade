class_name Destroy
extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var box: Destroy = $"."
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var sprite_textures: Array[Texture2D]

var explosion: PackedScene = preload("uid://3er4nc5bjvmo")

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	if not sprite_textures.is_empty():
		sprite_2d.texture = sprite_textures.pick_random()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	var explosion_instance = explosion.instantiate() as Node2D
	add_child(explosion_instance)
	sprite_2d.visible = false
	explosion_instance.global_position = global_position
	_area.get_parent().call_deferred("queue_free")
	area_2d.call_deferred("queue_free")
	collision_shape_2d.call_deferred("queue_free")
	await get_tree().create_timer(1.0).timeout
	queue_free()
