extends Node
class_name DamageComponent

@export var entity : CharacterBody2D
@export var attackbox : Area2D

var knockback_dir : Vector2
var knockback_force : float
var damage_amount : float

var entities_hit : Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if attackbox:
		attackbox.area_entered.connect(deal_damage)

func deal_damage(body : Area2D):
	if entities_hit.has(body):
		return
	entities_hit.append(body)
	print("Area entered : %s" % body.name)
	
	if entity.is_in_group("ENEMY"):
		damage_amount = entity.damage_amount
		knockback_dir = entity.knockback_dir
		knockback_force = entity.knockback_force
	for node in body.get_parent().get_children():
		if node is HealthComponent:
			node.take_damage(damage_amount, knockback_dir, knockback_force)
			return
