extends Node
# This class handles all of the user input and provides the sum of it via a getter function. Used for the ship
class_name ShipSteeringInput

const LOWER_THRESHOLD = 8
const BASE_UPPER_THRESHOLD = 500

var curr_upper_threshold = BASE_UPPER_THRESHOLD

var using_controller: bool = false
var controller_used := ""

var net_input: Vector2 = Vector2(0, 0)

func _ready():
	var window_center = get_viewport().size / 2


func get_user_input() -> Vector2:
	return net_input


func update_user_input() -> void:
	#curr_upper_threshold = get_viewport().size.y / 2
	#print("updating user input")
	if using_controller:
		var input_horizontal = Input.get_action_strength("yaw_right") - Input.get_action_strength("yaw_left")
		var input_vertical =  Input.get_action_strength("pitch_up") - Input.get_action_strength("pitch_down")
		net_input = Vector2(-input_horizontal, input_vertical)
	else:
		var window_center_y = get_viewport().size.y / 2
		var window_center_x = get_viewport().size.x / 2
		var mouse_position_y = get_viewport().get_mouse_position().y
		var mouse_position_x = get_viewport().get_mouse_position().x
		#print(window_center_y, " ",window_center_x," ", mouse_position_y," ", mouse_position_x)
		var vertical_distance = mouse_position_y - window_center_y
		var horizontal_distance = mouse_position_x - window_center_x
		var vertical_ratio = 0.0
		var horizontal_ratio = 0.0
		if abs(vertical_distance) < LOWER_THRESHOLD:
			vertical_ratio = 0.0
		else:
			vertical_ratio = clamp(vertical_distance / curr_upper_threshold, -1.0, 1.0)
	#
		if abs(horizontal_distance) < LOWER_THRESHOLD:
			horizontal_ratio = 0.0
		else:
			horizontal_ratio = clamp(horizontal_distance / curr_upper_threshold, -1.0, 1.0)
		
		net_input = Vector2(-horizontal_ratio,-vertical_ratio)
	
	#net_input = net_input.normalized()
	#print(net_input)

func get_using_controller() -> bool:
	return using_controller


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Input process running")
	update_user_input()

# Detect input events
func _input(event) -> void:
	if event is InputEventJoypadMotion:
		using_controller = true
		controller_used = Input.get_joy_name(0)
	elif event is InputEventKey or event is InputEventMouseMotion:
		using_controller = false
