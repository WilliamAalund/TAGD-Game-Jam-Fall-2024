extends Node3D

@onready var projectile_scene = load("res://Code/Entities/Projectile/Projectile.tscn")

@onready var left = $LaserCannons/Left
@onready var right = $LaserCannons/Right

var rpm = 413 # Rounds per minute
var fire_rate = 60.0 / rpm # Time between shots in seconds
var time_since_last_fire = 0.0 # Timer to track time since last shot

var fire_mode = "Laser"
enum fire_port {LEFT, RIGHT}
var current_port = fire_port.LEFT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Increment the timer by the time elapsed since the last frame
	time_since_last_fire += delta
	# Check if it's time to fire the next projectile
	if Input.is_action_pressed("shoot"):
		if time_since_last_fire >= fire_rate:
			fire_projectile()
			time_since_last_fire = 0 # Reset the timer after firing


func fire_projectile():
	# Implement the logic to instantiate and fire a projectile here
	Input.start_joy_vibration(0,0.2,0.1,0.10)
	spawn_projectile()
	if current_port == fire_port.LEFT:
		current_port = fire_port.RIGHT
	else:
		current_port = fire_port.LEFT

func spawn_projectile():
	var new_projectile = projectile_scene.instantiate()
	get_parent().add_child(new_projectile) # Enables removal of lasers upon deletion of Parent node
	if current_port == fire_port.LEFT:
		new_projectile.global_position = left.global_position
		Input.start_joy_vibration(0,0.2,0.1,0.10)
	else:
		new_projectile.global_position = right.global_position
		Input.start_joy_vibration(0,0.1,0.2,0.10)
	new_projectile.transform.basis = self.transform.basis
	
	

func _on_player_new_player_data_packet(packet):
	self.global_position = packet["global_pos"] 
	self.transform.basis = packet["ship_basis"]
