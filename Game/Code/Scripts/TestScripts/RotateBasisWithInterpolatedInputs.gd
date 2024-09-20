extends Node

# The purpose of this script is to combine the results of InterpolateUserInput with RotateBasisWithKeyboard. 
# The script will process user input and return variables that represent how the mesh is allowed to rotate.
# Then, the basis of the mesh will be transformed depending on these inputs.

@onready var debug_label = $DebugLabel
@onready var mesh = $MeshInstance3D

var travel_speed = 200 # Speed at which the mesh moves forward in space. Forward for the mesh is defined as the positive z direction.
var net_input_horizontal = 0 # The experienced input for horizontal rotation from the user. The raw input is interpolated to produce this value, which makes for a smoother turning experience.
var net_input_rate_multiplier = 4 # A constant that scales the rate at which the net input changes. Currently used by all three net values.
var net_input_vertical = 0 # Experienced for vertical
var net_input_rotational = 0
var max_net_input = 0.04
var minimum_net_input = 0.0005

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	print_to_debug_label()

func print_to_debug_label():
	debug_label.text = "Net input horizontal: " + str(net_input_horizontal) + "\nNet input vertical: " + str(net_input_vertical) + "\nNet input rotational: " + str(net_input_rotational)

func _physics_process(delta): # FIXME: When a particular net input reaches the max net input.
	if Input.is_action_pressed("debug_press_2"):
		travel_speed = 80
	elif Input.is_action_pressed("debug_press_1"):
		travel_speed = 450
	else:
		travel_speed = 200
	print(travel_speed)
	var prev_net_input_horizontal = net_input_horizontal
	var prev_net_input_vertical = net_input_vertical
	var prev_net_input_rotational = net_input_rotational
	update_net_input_horizontal(delta)
	update_net_input_vertical(delta)
	update_net_input_rotational(delta)
	# Initialize cumulative rotation
	var cumulative_rotation = Vector3.ZERO
	
	# Check if the net input is significant for rotation
	if abs(net_input_horizontal) > minimum_net_input:
		cumulative_rotation.y += net_input_horizontal
	if abs(net_input_vertical) > minimum_net_input:
		cumulative_rotation.x += net_input_vertical
	if abs(net_input_rotational) > minimum_net_input:
		cumulative_rotation.z += net_input_rotational
	
	if cumulative_rotation != Vector3.ZERO:
		var axis_y = mesh.transform.basis.y.normalized() # Ensure that vectors are normalized before using them in calculations.
		var axis_x = mesh.transform.basis.x.normalized()
		var axis_z = mesh.transform.basis.z.normalized()
		var rotated_basis = mesh.transform.basis.rotated(axis_y, net_input_horizontal).rotated(axis_x, net_input_vertical).rotated(axis_z, net_input_rotational)
		mesh.transform.basis = rotated_basis
	var movement_vector = mesh.transform.basis.z
	mesh.position += movement_vector * delta * travel_speed


func update_net_input_horizontal(delta): # input is probably not the best term for this variable.
	var input = 0
	if Input.is_action_pressed("debug_left"):
		input = max_net_input * Input.get_action_strength("debug_left")
	elif Input.is_action_pressed("debug_right"):
		input = -max_net_input * Input.get_action_strength("debug_right")
	if input != net_input_horizontal:
		net_input_horizontal += (input - net_input_horizontal) * delta * net_input_rate_multiplier
	
func update_net_input_vertical(delta): # input is probably not the best term for this variable.
	var input = 0
	if Input.is_action_pressed("debug_up"):
		input = max_net_input * Input.get_action_strength("debug_up")
	elif Input.is_action_pressed("debug_down"):
		input = -max_net_input * Input.get_action_strength("debug_down")
	if input != net_input_vertical:
		net_input_vertical += (input - net_input_vertical) * delta * net_input_rate_multiplier

func update_net_input_rotational(delta): # input is probably not the best term for that variable.
	var input = 0
	if Input.is_action_pressed("debug_rotate_right"):
		input = max_net_input * Input.get_action_strength("debug_rotate_right")
	elif Input.is_action_pressed("debug_rotate_left"):
		input = -max_net_input * Input.get_action_strength("debug_rotate_left")
	if input != net_input_rotational:
		net_input_rotational += (input - net_input_rotational) * delta * net_input_rate_multiplier
