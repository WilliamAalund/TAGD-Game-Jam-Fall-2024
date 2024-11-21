extends Node3D

@onready var projectile_scene = load("res://Code/Entities/Projectile/v2/Projectile.tscn")

@export var port_mode = port_modes.ALTERNATE


enum port_modes{ALTERNATE,BOTTOM,THREE,ENEMY,CENTER}
#@export var port_mode: port_modes

var port_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#set_up_projectile(projectile_type: type_enum, creator_basis: Basis,creator_group: String):

func spawn_projectile(spread: float, projectile_damage: float, projectile_range: float, projectile_velocity: float, _enemy_projectile: bool) -> void:
	var projectile_to_spawn = projectile_scene.instantiate()

	var rotation_basis = self.global_transform.basis

	# Generate random angles for horizontal and vertical spread
	var horizontal_angle = randf_range(-spread, spread)
	var vertical_angle = randf_range(-spread, spread)

	# Convert angles to radians
	horizontal_angle = deg_to_rad(horizontal_angle)
	vertical_angle = deg_to_rad(vertical_angle)

	# Create rotation bases for both axes
	var horizontal_rotation = Basis().rotated(Vector3(0, 1, 0), horizontal_angle) # Y-axis rotation
	var vertical_rotation = Basis().rotated(Vector3(1, 0, 0), vertical_angle) # X-axis rotation

	# Combine rotations
	rotation_basis = horizontal_rotation * vertical_rotation * rotation_basis
	
	projectile_to_spawn.set_up_projectile_v2(rotation_basis, projectile_damage, projectile_range, projectile_velocity) #projectile_to_spawn.type_enum.LASER,projectile_velocity,
	
	get_parent().get_parent().get_parent().add_child(projectile_to_spawn)
	#print("Port mode: ", port_mode)
	if port_mode == port_modes.BOTTOM:
		projectile_to_spawn.global_position = $Bottom.global_position
	elif port_mode == port_modes.CENTER:
		projectile_to_spawn.global_position = $Middle.global_position
	elif port_mode == port_modes.ALTERNATE:
		if port_index == 0:
			projectile_to_spawn.global_position = $Left.global_position
			port_index += 1
			$LeftAudio.pitch_scale = randf_range(0.9,1.1)
			$LeftAudio.play()
		else:
			projectile_to_spawn.global_position = $Right.global_position
			port_index = 0
			$RightAudio.play()
			$RightAudio.pitch_scale = randf_range(0.9,1.1)
	elif port_mode == port_modes.BOTTOM:
		projectile_to_spawn.global_position = $Middle.global_position
	#print("Spawning Projectile")
