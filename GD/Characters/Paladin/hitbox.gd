extends Area2D
class_name Hitbox

var damage_amount : int 


@export var knockback_force : float = 900
@export var player : CharacterBody2D
@export var slash_hitbox : CollisionShape2D
@export var sword : Node2D
func _init() -> void:
	pass
	
func _ready() -> void:
	assert(slash_hitbox != null)
	self.area_entered.connect(on_area_entered)
	damage_amount = sword.damage_amount

	
	
func on_area_entered(body : Area2D):
	CameraManager.add_trauma(0.5)
	player.hit_stop()
	var knockback_direction : Vector2 =  player.knockback_direction
	# stuff sends to health component that deals damage and and sets up direction thig
	# and then enters into hurt state where knock back occurs
	for node in body.get_parent().get_children():
		if node is HealthComponent:
			node.take_damage(damage_amount,knockback_direction,knockback_force)
			return
