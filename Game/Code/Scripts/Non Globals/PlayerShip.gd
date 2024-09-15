extends CharacterBody3D
# This script controls the behavior of the player's ship in a 3D space environment. It handles movement, including forward motion and rotational adjustments based on user input. 

var horizontal_rotate_rate_increase = 4 # A constant that scales the rate at which the net input changes. Currently used by all three net values.

const MIN_TRAVEL_SPEED = -200.0
const BASE_TRAVEL_SPEED = 250.0
const MAX_TRAVEL_SPEED = 750.0
const ACCELERATION = 1.0

const MAX_BOOST = 100
const BOOST_ENERGY_REENABLE_THRESHOLD = 30
@export var boost_energy = MAX_BOOST # Boost energy controls how long the player can boost for.
@export var boost_depleted = false # If the boost hits a value of 0, it will shut off for a bit until it reaches BOOST_ENERGY_REENABLE_THRESHOLD.
var boost_energy_regeneration_rate = 14
var boost_energy_depletion_rate = 18

var travel_speed = BASE_TRAVEL_SPEED # Speed at which the mesh moves forward in space. Forward for the mesh is defined as the positive z direction.
var max_net_input = 2.0
var net_input_horizontal = 0 # The experienced input for horizontal rotation from the user. The raw input is interpolated to produce this value, which makes for a smoother turning experience.
var net_input_vertical = 0 # Experienced for vertical
var net_input_rotational = 0

var minimum_net_input = 0.0005




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	pass
	# Update net inputs for movement and rotation
	update_net_input_horizontal(delta)
	update_net_input_vertical(delta)
	update_net_input_rotational(delta)
	# Calculate and apply cumulative rotation based on net inputs
	apply_cumulative_rotation(delta)

func _physics_process(delta):
	# Handling movement of the character body
	# Adjust travel speed based on user inputs
	adjust_travel_speed_based_on_input(delta)
	# Move the player ship forward
	move_ship_forward()

# Adjusts the ship's travel speed based on debug input
func adjust_travel_speed_based_on_input(delta):
	var target_travel_speed: float = BASE_TRAVEL_SPEED
	# Increase velocity
	if Input.is_action_pressed("boost") and boost_energy > 0 and boost_depleted == false:
		target_travel_speed = MAX_TRAVEL_SPEED
		Input.start_joy_vibration(0,0.5,0.2,0.1)
		boost_energy -= boost_energy_depletion_rate * delta
		if boost_energy <= 0.0:
			boost_energy = 0
			boost_depleted = true
	# Decrease velocity
	elif Input.is_action_pressed("break"):
		target_travel_speed = MIN_TRAVEL_SPEED
		Input.start_joy_vibration(0,0.2,0.3,0.1)
		boost_energy += boost_energy_regeneration_rate * delta
		if boost_energy > BOOST_ENERGY_REENABLE_THRESHOLD:
			boost_depleted = false
	else:
		boost_energy += boost_energy_regeneration_rate * delta
		if boost_energy > BOOST_ENERGY_REENABLE_THRESHOLD:
			boost_depleted = false
	if boost_energy > MAX_BOOST:
		boost_energy = MAX_BOOST
	# Interpolate current velocity towards target velocity
	travel_speed = lerp(travel_speed, target_travel_speed, ACCELERATION * delta)

func update_net_input_horizontal(delta):
	var directional_input_strength = 0
	if Input.is_action_pressed("yaw_left"):
		directional_input_strength = max_net_input * Input.get_action_strength("yaw_left")
	elif Input.is_action_pressed("yaw_right"):
		directional_input_strength = -max_net_input * Input.get_action_strength("yaw_right")
	if directional_input_strength != net_input_horizontal:
		net_input_horizontal += (directional_input_strength - net_input_horizontal) * delta * horizontal_rotate_rate_increase
	
func update_net_input_vertical(delta):
	var input = 0
	if Input.is_action_pressed("debug_up"):
		input = max_net_input * Input.get_action_strength("debug_up")
	elif Input.is_action_pressed("debug_down"):
		input = -max_net_input * Input.get_action_strength("debug_down")
	if input != net_input_vertical:
		net_input_vertical += (input - net_input_vertical) * delta * horizontal_rotate_rate_increase

func update_net_input_rotational(delta):
	var input = 0
	if Input.is_action_pressed("debug_rotate_right"):
		input = max_net_input * Input.get_action_strength("debug_rotate_right")
	elif Input.is_action_pressed("debug_rotate_left"):
		input = -max_net_input * Input.get_action_strength("debug_rotate_left")
	if input != net_input_rotational:
		net_input_rotational += (input - net_input_rotational) * delta * horizontal_rotate_rate_increase

# Applies cumulative rotation to the ship based on net input
func apply_cumulative_rotation(delta):
	var cumulative_rotation = calculate_cumulative_rotation()
	
	if cumulative_rotation != Vector3.ZERO:
		apply_rotation(delta)

# Calculates cumulative rotation from net inputs
func calculate_cumulative_rotation() -> Vector3:
	var cumulative_rotation = Vector3.ZERO
	
	# Accumulate rotation if net input is above minimum threshold
	if abs(net_input_horizontal) > minimum_net_input:
		cumulative_rotation.y += net_input_horizontal
	if abs(net_input_vertical) > minimum_net_input:
		cumulative_rotation.x += net_input_vertical
	if abs(net_input_rotational) > minimum_net_input:
		cumulative_rotation.z += net_input_rotational
	
	return cumulative_rotation

# Applies rotation to the ship
func apply_rotation(delta):
	var axis_y = self.transform.basis.y.normalized() 
	var axis_x = self.transform.basis.x.normalized()
	var axis_z = self.transform.basis.z.normalized()
	
	# Rotate basis around each axis based on cumulative rotation
	var rotated_basis = self.transform.basis.rotated(axis_y, net_input_horizontal * delta).rotated(axis_x, net_input_vertical * delta).rotated(axis_z, net_input_rotational * delta)
		
	self.transform.basis = rotated_basis

# Moves the ship forward based on its current orientation
func move_ship_forward():
	var direction_vector = self.transform.basis.z.normalized()
	self.velocity = direction_vector * travel_speed
	move_and_slide()

func get_3d_crosshair_position():
	print($SpringArm3D.get_hit_length())
	return $SpringArm3D/CrosshairPosition.global_position
