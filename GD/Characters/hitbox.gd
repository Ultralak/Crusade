extends Area2D
class_name Hitbox

@export var damage_amount : int = 3
var knockback_direction : Vector2 = Vector2.ZERO
@export var knockback_force : float = 300

@export var left : CollisionShape2D 
@export var right : CollisionShape2D 

func _init() -> void:
	connect("body_entered",on_body_entered)
	
func _ready() -> void:
	assert(left != null)
	assert(right != null)
	
	
func on_body_entered(body : CharacterBody2D):
	for node in body.get_children():
		if node is HealthComponent:
			node.deal_damage(damage_amount, knockback_direction,knockback_force)
			break
