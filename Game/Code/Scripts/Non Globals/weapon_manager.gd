extends Node3D

# TODO: Add switching between active weapons, if applicable
@export var input_enabled = false

@onready var laser_scene = load("res://Code/Entities/Weapons/Laser.tscn")
@onready var shotgun_scene = load("res://Code/Entities/Weapons/Shotgun.tscn")
# burst weapon scene yet to be implemented

var weapon_count = 0

const DEFAULT_LASER_WEAPON = {
	"name": "Laser",
	"rpm": 500.0,
	"automatic": true,
	"range": 1000.0,
	"velocity": 700.0,
	"spread": 0.5,
	"damage": 8,
	"firing_mode": "Alternate"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_weapon(0)
	print("Equipping laser primary weapon")
		

func get_weapon_parameter_dictionary(weapon_id: int) -> Dictionary:
	return DEFAULT_LASER_WEAPON # TODO: Implement this

func spawn_weapon(weapon_id: int):
	# Convert weapon id to dictionary
	var weapon_parameters = get_weapon_parameter_dictionary(weapon_id)
	var weapon_child
	
	if weapon_parameters["name"] == "Laser":
		weapon_child = laser_scene.instantiate()
		if weapon_count == 0:
			weapon_child.weapon_enabled = true
			weapon_child.rounds_per_minute = weapon_parameters["rpm"]
			weapon_child.automatic_firing = weapon_parameters["automatic"]
			weapon_child.projectile_range = weapon_parameters["range"]
			weapon_child.projectile_velocity = weapon_parameters["velocity"]
			weapon_child.projectile_spread_angle = weapon_parameters["spread"]
			weapon_child.projectile_damage = weapon_parameters["damage"]
			weapon_child.firing_port_mode = weapon_parameters["firing_mode"]
	
	self.add_child(weapon_child)
	weapon_count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_new_player_data_packet(packet: Variant) -> void:
	self.global_position = packet["global_pos"] 
	self.transform.basis = packet["ship_basis"]
