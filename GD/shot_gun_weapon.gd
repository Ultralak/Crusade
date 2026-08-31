class_name ShotgunWeapon
extends ProjectileWeapon


func shoot() -> void:
	setup_normal_damage()
	if not bullet_setup or not can_shoot or not is_normal_damage_setup:
		return

	can_shoot = false
	var base_direction: Vector2 = gun_direction

	for i in range(weapon_data.pellets_per_shot):
		if not is_instance_valid(self) or not is_inside_tree():
			return

		var bulletInstance := weapon_data.bullet_scene.instantiate() as BasicProjectile
		bulletInstance.global_position = muzzle.global_position
		bulletInstance.z_index = 20

		critical_hit()

		var mid: float = float(weapon_data.weapon_bloom) / 2.0
		var pellet_angle: float = randf_range(-mid, mid)
		var pellet_direction: Vector2 = base_direction.rotated(deg_to_rad(pellet_angle))

		bulletInstance.knockback_dir = pellet_direction
		bulletInstance.knockback_force = weapon_data.knockback_force
		bulletInstance.damage_amount = damage
		bulletInstance.penetration = weapon_data.penetration
		bulletInstance.projectile_direction = pellet_direction

		bulletInstance.is_critical_damage = critical_hit_done
		bulletInstance.projectile_velocity = weapon_data.bullet_velocity
		bulletInstance.rotation = pellet_direction.angle()
		bulletInstance.weapon_shot_out_off = self

		if weapon_user.is_in_group("ENEMY"):
			bulletInstance.layer_damage_player()
		elif weapon_user.is_in_group("PLAYER"):
			bulletInstance.layer_damage_enemy()

		get_tree().current_scene.add_child(bulletInstance)
		bulletInstance.is_shot = true

	apply_weapon_recoil()

	bullet_setup = false

	var frequency: float = 1.0 / (weapon_data.fire_rate * 1.0)
	fire_rate_timer.wait_time = frequency
	fire_rate_timer.one_shot = true
	fire_rate_timer.start()
