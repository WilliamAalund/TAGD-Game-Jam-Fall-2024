extends Node

@onready var mesh = $MeshInstance3D
@onready var nagivation_point = $Marker3D

var navigation_point_global_position
var max_net_input = 0.025
var net_input_horizontal
var net_input_vertical
var net_input_rotational
var horizontal_rotate_rate_increase = 2 # FIXME: This is not a good variable name.

var navigation_vector

var navigation_vector_xy_plane
var navigation_vector_z

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	navigation_point_global_position = nagivation_point.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	navigation_point_global_position = nagivation_point.global_position
	move_target_marker()
	navigation_vector = navigation_point_global_position - mesh.global_position
	mesh.look_at(mesh.global_position + navigation_vector)
	print(navigation_vector)
	mesh.global_position += navigation_vector.normalized() * delta * 4
	
	
	
	#navigation_vector_xy_plane = Vector2(navigation_vector.x, navigation_vector.y)
	#var mesh_basis_vector_xy_plane = Vector2(mesh.transform.basis.z.x,mesh.transform.basis.z.y)
	#print(mesh_basis_vector_xy_plane)
	#print(navigation_vector_xy_plane.normalized().dot(mesh_basis_vector_xy_plane))
	#print(navigation_vector)
	#print(navigation_vector.normalized().dot(mesh.transform.basis.z.normalized()))

func move_target_marker():
	if Input.is_action_pressed("debug_left"):
		nagivation_point.position.x -= .1
	if Input.is_action_pressed("debug_right"):
		nagivation_point.position.x += .1
	if Input.is_action_pressed("debug_up"):
		nagivation_point.position.z += -.1
	if Input.is_action_pressed("debug_down"):
		nagivation_point.position.z += .1
	if Input.is_action_pressed("debug_rotate_left"):
		nagivation_point.position.y += -.1
	if Input.is_action_pressed("debug_rotate_right"):
		nagivation_point.position.y += .1


func transform_basis_according_to_current_position():
	pass

func mesh_is_below_target() -> bool:
	pass
	return false

func mesh_is_moving_to_right_of_target() -> bool:
	# TODO: Figure out if the ship would be able to properly navigate to a position
	
	return false

func update_net_input_horizontal(delta): # input is probably not the best term for this variable.
	var input = 0
	if Input.is_action_pressed("debug_left"):
		input = max_net_input * Input.get_action_strength("debug_left")
	elif Input.is_action_pressed("debug_right"):
		input = -max_net_input * Input.get_action_strength("debug_right")
	if input != net_input_horizontal:
		net_input_horizontal += (input - net_input_horizontal) * delta * horizontal_rotate_rate_increase
	
func update_net_input_vertical(delta): # input is probably not the best term for this variable.
	var input = 0
	if Input.is_action_pressed("debug_up"):
		input = max_net_input * Input.get_action_strength("debug_up")
	elif Input.is_action_pressed("debug_down"):
		input = -max_net_input * Input.get_action_strength("debug_down")
	if input != net_input_vertical:
		net_input_vertical += (input - net_input_vertical) * delta * horizontal_rotate_rate_increase

func update_net_input_rotational(delta): # input is probably not the best term for that variable.
	var input = 0
	if Input.is_action_pressed("debug_rotate_right"):
		input = max_net_input * Input.get_action_strength("debug_rotate_right")
	elif Input.is_action_pressed("debug_rotate_left"):
		input = -max_net_input * Input.get_action_strength("debug_rotate_left")
	if input != net_input_rotational:
		net_input_rotational += (input - net_input_rotational) * delta * horizontal_rotate_rate_increase
