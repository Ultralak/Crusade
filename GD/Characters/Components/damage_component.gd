class_name DamageComponent
extends Node

@export var entity: Node2D
@export var attackbox: Area2D

var knockback_dir: Vector2
var knockback_force: float
var damage_amount: float
var entities_hit: Array


func _ready() -> void:
	if is_instance_valid(attackbox):
		attackbox.area_entered.connect(deal_damage)


func deal_damage(body: Area2D) -> void:
	if not is_instance_valid(entity):
		return

	if not is_instance_valid(body) or not is_instance_valid(body.get_parent()):
		return

	print("damage amount : %s" % [entity.damage_amount])

	if body.get_parent() is Paladin:
		CameraManager.add_trauma(0.4)

	if entities_hit.has(body):
		return
	entities_hit.append(body)

	if entity is EnvironmentalHazard:
		damage_amount = entity.damage_amount
		knockback_force = entity.knockback_force
		for node in body.get_parent().get_children():
			if is_instance_valid(node) and node is HealthComponent:
				knockback_dir = node.get_knockback_force()
				break
	else:
		damage_amount = entity.damage_amount
		knockback_dir = entity.knockback_dir
		knockback_force = entity.knockback_force

	print("Area entered : %s and damage_dealt : %s" % [body.get_parent().name, damage_amount])

	for node in body.get_parent().get_children():
		if is_instance_valid(node) and node is HealthComponent:
			if entity is BasicProjectile:
				node.take_damage(
					damage_amount,
					knockback_dir,
					knockback_force,
					entity.is_critical_damage,
				)
			else:
				node.take_damage(damage_amount, knockback_dir, knockback_force)
			
			manage_penetration()
			entities_hit.clear()
			return


func manage_penetration() -> void:
	if not is_instance_valid(entity):
		return

	if entity is BasicProjectile:
		if (
			is_instance_valid(entity.weapon_shot_out_off)
			and entity.weapon_shot_out_off is ProjectileWeapon
			and entities_hit.size() == entity.penetration
		):
			entity.call_deferred("queue_free")
