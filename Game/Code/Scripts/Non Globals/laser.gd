extends WeaponTest

func shoot():
	firing_ports.spawn_projectile(projectile_spread_angle, projectile_damage, projectile_range, projectile_velocity, enemy_weapon) # FIXME: Not compatible with enemies yet
# func set_up_projectile_v2(creator_basis: Basis, projectile_damage: int, projectile_range: float, projectile_velocity: float, creator_group: String = "player", projectile_type: type_enum = type_enum.LASER)
