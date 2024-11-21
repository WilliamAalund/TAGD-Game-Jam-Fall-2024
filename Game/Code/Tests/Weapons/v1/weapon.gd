extends Node3D
class_name WeaponTest

signal weapon_fired

@onready var firing_ports = $FiringPorts

# Weapon parameters
@export var weapon_name := ""
@export var enemy_weapon := false # If true, controls what firing ports are used by the subclass
@export var weapon_enabled := false # If weapon is useable or not
@export var rounds_per_minute: float = 200.0 :
	get:
		return rounds_per_minute
	set(value):
		rounds_per_minute = value
		fire_rate = 60.0 / rounds_per_minute
var fire_rate := 60.0 / rounds_per_minute # Not directly altered by other code. 
@export var automatic_firing := true # Controls if the player can continue firing by holding down a button
@export var projectile_range := 10.0 # Farthest distance in units a projectile will travel before deleting itself
@export var projectile_velocity := 10.0 # Velocity at which projectile will travel
@export var projectile_spread_angle := 5.0
@export var projectile_damage := 5
@export var firing_port_mode = WeaponConstants.port_modes.ALTERNATE # FIXME: This is not implemented

var elapsed_time_since_last_shot := 0.0
var can_shoot := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print("New weapon with firing port mode: ", firing_port_mode)
	firing_ports.port_mode = firing_port_mode

func weapon_process(delta: float):
	if not can_shoot:
		elapsed_time_since_last_shot += delta
		if elapsed_time_since_last_shot >= fire_rate:
			can_shoot = true
			elapsed_time_since_last_shot = 0.0
	elif weapon_enabled:
		var shot = false
		if automatic_firing and Input.is_action_pressed("shoot"):
			shot = true
		elif not automatic_firing and Input.is_action_just_pressed("shoot"):
			shot = true
		if shot:
			can_shoot = false
			weapon_fired.emit()
			shoot()
	else:
		pass # Can shoot, but weapon is not enabled
		

func shoot():
	print("shoot() not implemented in parent Weapon class") # Implemented in lower functions

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	weapon_process(delta)
