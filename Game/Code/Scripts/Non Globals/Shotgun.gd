extends WeaponTest

@export var num_pellets := 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func shoot():
	print("Shotgun form of shoot")
	for pellet in range(num_pellets):
		firing_ports.spawn_projectile(projectile_spread_angle, projectile_damage, projectile_range, projectile_velocity, enemy_weapon) # FIXME: Not compatible with enemies yet
# func set_up_projectile_v2(creator_basis: Basis, projectile_damage: int, projectile_range: float, projectile_velocity: float, creator_group: String = "player", projectile_type: type_enum = type_enum.LASER)
