extends Node
class_name DamageComponent

@export var entity : CharacterBody2D
@export var attackbox : Area2D
var knockback_dir : Vector2
var knockback_force : float
var damage_amount : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attackbox.connect("body_entered", deal_damage)
	if entity.is_in_group("ENEMY_"):
		damage_amount = entity.damage_amount
		knockback_dir = entity.knockback_dir
		knockback_force = entity.knockback_force
	# need to do for player



func deal_damage(body : CharacterBody2D):
	body.take_damage(damage_amount, knockback_dir, knockback_force)
