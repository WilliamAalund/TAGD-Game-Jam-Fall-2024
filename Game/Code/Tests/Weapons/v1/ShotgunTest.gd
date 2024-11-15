extends WeaponTest

@export var number_of_pellets := 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	firing_ports.port_mode = firing_ports.port_modes.BOTTOM # This is a pretty weird way to do this, however, 

func shoot() -> void:
	print("Calling shotgun shoot() function")
	#spawn_projectile(spread_angle: float, velocity: float, range: float, damage: float, enemy_projectile: bool) -> void:
	for pellet in range(number_of_pellets):
		firing_ports.spawn_projectile(projectile_spread_angle, projectile_velocity, projectile_range, projectile_damage, enemy_weapon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
