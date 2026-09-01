class_name BurstWeapon
extends ProjectileWeapon


func fire() -> void:
	if PlayerManager.spend_coins(weapon_data.energy_cost):
		setup_normal_damage()
		if not bullet_setup or not can_shoot or not is_normal_damage_setup:
			return

		can_shoot = false

		for i in range(weapon_data.burst_count):
			if not is_instance_valid(self) or not is_inside_tree():
				return

			var bulletInstance := weapon_data.bullet_scene.instantiate() as BasicProjectile
			bulletInstance.global_position = muzzle.global_position
			bulletInstance.z_index = 20
			
			critical_hit()
			bulletInstance.knockback_dir = gun_direction
			bulletInstance.knockback_force = weapon_data.knockback_force
			bulletInstance.damage_amount = damage
			bulletInstance.penetration = weapon_data.penetration
			bulletInstance.projectile_direction = gun_direction
			
			handle_weapon_bloom()
			bulletInstance.is_critical_damage = critical_hit_done
			bulletInstance.projectile_velocity = weapon_data.bullet_velocity
			bulletInstance.rotation = gun_direction.angle()
			bulletInstance.weapon_shot_out_off = self
			
			if weapon_user.is_in_group("ENEMY"):
				bulletInstance.layer_damage_player()
			elif weapon_user.is_in_group("PLAYER"):
				bulletInstance.layer_damage_enemy()
				
			get_tree().current_scene.add_child(bulletInstance)
			bulletInstance.is_shot = true
			
			apply_weapon_recoil()

			if i < weapon_data.burst_count - 1:
				var burst_timer = get_tree().create_timer(weapon_data.burst_delay)
				await burst_timer.timeout

		bullet_setup = false
		
		var frequency: float = 1.0 / (weapon_data.fire_rate * 1.0)
		fire_rate_timer.wait_time = frequency
		fire_rate_timer.one_shot = true
		fire_rate_timer.start()
		
func shoot() -> void:
	if weapon_user is Paladin :
		if PlayerManager.spend_coins(weapon_data.energy_cost):
			fire()
	else:
		fire()
