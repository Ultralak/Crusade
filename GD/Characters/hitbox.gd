extends Area2D
class_name Hitbox

@export var damage_amount : int = 3

@export var knockback_force : float = 900
@export var player : CharacterBody2D
@export var slash_hitbox : CollisionShape2D

func _init() -> void:
	connect("body_entered",on_body_entered)
	
func _ready() -> void:
	assert(slash_hitbox != null)
	
	
func on_body_entered(body : CharacterBody2D):
	# stuff sends to health component that deals damage and and sets up direction thig
	# and then enters into hurt state where knock back occurs
	for node in body.get_children():
		if node is HealthComponent:
			node.deal_damage(damage_amount, player.knockback_direction,knockback_force)
			break
