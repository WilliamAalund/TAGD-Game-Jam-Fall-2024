extends CharacterBody3D
# This script controls the behavior of the player's ship in a 3D space environment. It handles movement, including forward motion and rotational adjustments based on user input. 

#signal ship_left_play_space#
#signal ship_entered_play_space
signal ship_scraping_against_surface

@export var debug_freeze_ship_position = false

const MIN_TRAVEL_SPEED = -15.0
const BASE_TRAVEL_SPEED = 30.0
const MAX_TRAVEL_SPEED = 80.0
const ACCELERATION = 1.5
const MAX_BOOST = 100
const BOOST_ENERGY_REENABLE_THRESHOLD = 25

@export var boost_energy: float = MAX_BOOST # Boost energy controls how long the player can boost for.
@export var boost_depleted: bool = false # If the boost hits a value of 0, it will shut off for a bit until it reaches BOOST_ENERGY_REENABLE_THRESHOLD.
@export var left_playable_space: bool = false

var boost_energy_regeneration_rate = 14
var boost_energy_depletion_rate = 18

var net_input_rate_multiplier = 8 # A constant that scales the rate at which the net input changes. Currently used by all three net values.
var travel_speed = PlayerData.BASE_TRAVEL_SPEED # Speed at which the mesh moves forward in space. Forward for the mesh is defined as the positive z direction.
var max_net_input: float = .5 # Increasing this value increases turn angle of ship # FIXME: This is a poor name for this variable.
var max_rotate_net_input: float = 0.9
var minimum_net_input = 0.0005 # Used as a value to cull extremely small net input values
var net_input_horizontal: float = 0 # The experienced input for horizontal rotation from the user. The raw input is interpolated to produce this value, which makes for a smoother turning experience.
var net_input_vertical: float = 0 # Experienced for vertical
var net_input_rotational: float = 0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _process(delta):
	if Input.is_action_pressed("focus"):
		max_net_input = 0.4
		net_input_rate_multiplier = 10
	elif Input.is_action_pressed("break"):
		max_net_input = 2.2
		net_input_rate_multiplier = 14
	elif Input.is_action_pressed("boost") and not boost_depleted:
		max_net_input = 1.6
		net_input_rate_multiplier = 10
	else:
		max_net_input = 1.4
		net_input_rate_multiplier = 10
	# Update net inputs for movement and rotation
	update_net_input_horizontal(delta)
	update_net_input_vertical(delta)
	update_net_input_rotational(delta)
	# Calculate and apply cumulative rotation based on net inputs
	apply_cumulative_rotation(delta)

func _physics_process(delta):
	if self.get_slide_collision_count() > 0:
		Input.start_joy_vibration(0,0.3,0.3,0.1)
		ship_scraping_against_surface.emit()
	# Handling movement of the character body
	# Adjust travel speed based on user inputs
	adjust_travel_speed_based_on_input(delta)
	# Move the player ship forward
	if !debug_freeze_ship_position:
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
		net_input_horizontal += (directional_input_strength - net_input_horizontal) * delta * net_input_rate_multiplier
	
func update_net_input_vertical(delta):
	var input = 0
	if Input.is_action_pressed("pitch_down"):
		input = -max_net_input * Input.get_action_strength("pitch_down")
	elif Input.is_action_pressed("pitch_up"):
		input = max_net_input * Input.get_action_strength("pitch_up")
	if input != net_input_vertical:
		net_input_vertical += (input - net_input_vertical) * delta * net_input_rate_multiplier

func update_net_input_rotational(delta):
	var input = 0
	if Input.is_action_pressed("debug_rotate_left"):
		input = max_rotate_net_input * Input.get_action_strength("debug_rotate_left")
	elif Input.is_action_pressed("debug_rotate_right"):
		input = -max_rotate_net_input * Input.get_action_strength("debug_rotate_right")
	if input != net_input_rotational:
		net_input_rotational += (input - net_input_rotational) * delta * net_input_rate_multiplier

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
	var direction_vector = -self.transform.basis.z.normalized()
	self.velocity = direction_vector * travel_speed
	move_and_slide()

# Called by player node to build player packet
func get_3d_crosshair_position():
	#print($SpringArm3D/CrosshairPosition.global_position)
	if $SpringArm3D.get_hit_length() <= $LowestCrosshairPositon.position.z * 2:
		return $LowestCrosshairPositon.global_position
	elif $SpringArm3D.get_hit_length() == $SpringArm3D.spring_length:
		return $DefaultCrosshairPosition.global_position
	else:
		return $SpringArm3D/SpringCrosshairPosition.global_position

# Setters for left_playable_space. Called by other nodes on ship node
func left_playable_area():
	print("Ship left playable area")
	left_playable_space = true

func entered_playable_area():
	print("Ship entered playable area")
	left_playable_space = false
