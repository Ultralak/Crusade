class_name ClusterProjectile
extends BasicProjectile

@export var sub_projectile_scene: PackedScene
@export var cluster_count: int = 6
@export var damage_multiplier: float = 0.5

var has_split: bool = false


func _ready() -> void:
	super._ready()
	if is_instance_valid(attack_box):
		attack_box.area_entered.connect(_on_attack_box_area_entered)


func on_timeout() -> void:
	call_deferred("queue_free")


func _on_attack_box_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		call_deferred("queue_free")


func _on_attack_box_area_entered(area: Area2D) -> void:
	if has_split:
		return

	var target := area.get_parent()
	if not is_instance_valid(target):
		return

	var is_valid_target := false

	if is_instance_valid(weapon_shot_out_off) and is_instance_valid(weapon_shot_out_off.weapon_user):
		if weapon_shot_out_off.weapon_user.is_in_group("PLAYER") and target.is_in_group("ENEMY"):
			is_valid_target = true
		elif weapon_shot_out_off.weapon_user.is_in_group("ENEMY") and target.is_in_group("PLAYER"):
			is_valid_target = true

	if is_valid_target:
		spawn_cluster()
		call_deferred("queue_free")


func spawn_cluster() -> void:
	if has_split or not sub_projectile_scene:
		return
	has_split = true

	var angle_step: float = TAU / float(cluster_count)

	for i in range(cluster_count):
		var spawn_angle: float = angle_step * i
		var spawn_direction: Vector2 = Vector2.RIGHT.rotated(spawn_angle)

		var sub_bullet := sub_projectile_scene.instantiate() as BasicProjectile
		sub_bullet.global_position = global_position
		sub_bullet.z_index = z_index
		sub_bullet.projectile_direction = spawn_direction
		sub_bullet.projectile_velocity = projectile_velocity * 0.5
		sub_bullet.damage_amount = damage_amount * damage_multiplier
		sub_bullet.knockback_dir = spawn_direction
		sub_bullet.knockback_force = knockback_force
		sub_bullet.penetration = 1
		sub_bullet.rotation = spawn_direction.angle()
		sub_bullet.scale = Vector2(0.5, 0.5)
		sub_bullet.weapon_shot_out_off = weapon_shot_out_off
		sub_bullet.is_critical_damage = is_critical_damage

		if weapon_shot_out_off and is_instance_valid(weapon_shot_out_off.weapon_user):
			if weapon_shot_out_off.weapon_user.is_in_group("ENEMY"):
				sub_bullet.layer_damage_player()
			elif weapon_shot_out_off.weapon_user.is_in_group("PLAYER"):
				sub_bullet.layer_damage_enemy()

		get_tree().current_scene.call_deferred("add_child", sub_bullet)
		sub_bullet.is_shot = true
