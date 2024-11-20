extends Node3D

# TODO: Add switching between active weapons, if applicable
@export var input_enabled = false

@onready var laser_scene = load("res://Code/Entities/Weapons/Laser.tscn")
@onready var shotgun_scene = load("res://Code/Entities/Weapons/Shotgun.tscn")
# burst weapon scene yet to be implemented

var weapon_count = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Equipping weapons")
	set_up_weapons() 

func set_weapons_enabled(enabled: bool) -> void:
	if enabled:
		set_up_weapons()
	else:
		clear_current_weapons()

func get_weapon_parameter_dictionary(weapon_id: int) -> Dictionary:
	return WeaponConstants.WEAPONS[weapon_id] # TODO: Implement this

func spawn_weapon(weapon_id: int) -> void:
	# Convert weapon id to dictionary
	var weapon_parameters = get_weapon_parameter_dictionary(weapon_id)
	var weapon_child
	
	if weapon_parameters["type"] == "Laser":
		weapon_child = laser_scene.instantiate()
		if weapon_count == 0:
			weapon_child.weapon_enabled = true
		elif weapon_count == 1:
			weapon_child.weapon_enabled = false
		else:
			print("Error adding weapon: too many weapons equipped")
			return
		weapon_child.weapon_enabled = true
		weapon_child.rounds_per_minute = weapon_parameters["rpm"]
		weapon_child.automatic_firing = weapon_parameters["automatic"]
		weapon_child.projectile_range = weapon_parameters["range"]
		weapon_child.projectile_velocity = weapon_parameters["velocity"]
		weapon_child.projectile_spread_angle = weapon_parameters["spread"]
		weapon_child.projectile_damage = weapon_parameters["damage"]
		weapon_child.firing_port_mode = weapon_parameters["firing_mode"]
	elif weapon_parameters["type"] == "Shotgun":
		print("Spawning shotgun")
		weapon_child = shotgun_scene.instantiate()
		if weapon_count == 0:
			weapon_child.weapon_enabled = true
		elif weapon_count == 1:
			weapon_child.weapon_enabled = false
		else:
			print("Error adding weapon: too many weapons equipped")
			return
			weapon_child.weapon_enabled = true
			weapon_child.rounds_per_minute = weapon_parameters["rpm"]
			weapon_child.automatic_firing = weapon_parameters["automatic"]
			weapon_child.projectile_range = weapon_parameters["range"]
			weapon_child.projectile_velocity = weapon_parameters["velocity"]
			weapon_child.projectile_spread_angle = weapon_parameters["spread"]
			weapon_child.projectile_damage = weapon_parameters["damage"]
			weapon_child.firing_port_mode = weapon_parameters["firing_mode"]
			weapon_child.num_pellets = weapon_parameters["number_of_pellets"]
	
	self.add_child(weapon_child)
	weapon_count += 1

func clear_current_weapons() -> void:
	for child in self.get_children():
		child.queue_free()

func set_up_weapons() -> void:
	clear_current_weapons()
	spawn_weapon(PlayerData.primary_weapon_id)
	if PlayerData.secondary_weapon_id != -1:
		spawn_weapon(PlayerData.secondary_weapon_id)
	
	
func _on_player_new_player_data_packet(packet: Variant) -> void:
	self.global_position = packet["global_pos"] 
	self.transform.basis = packet["ship_basis"]

func _on_new_weapon_bought(weapon_id: Variant) -> void:
	spawn_weapon(weapon_id)
