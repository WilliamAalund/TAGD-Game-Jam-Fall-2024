extends Node
# This class handles all of the user input and provides the sum of it via a getter function. Used for the ship
class_name ShipSteeringInput

var using_controller: bool = false

func get_user_input() -> Vector2:
	var net_input: Vector2 = Vector2(0, 0)
	
	if using_controller:
		var input_horizontal = Input.get_action_strength("yaw_right") - Input.get_action_strength("yaw_left")
		var input_vertical =  Input.get_action_strength("pitch_up") - Input.get_action_strength("pitch_down")
		net_input = Vector2(input_horizontal, input_vertical)
	else:
		# Implement mouse and keyboard input detection
		if Input.is_action_pressed("yaw_right"):
			net_input.x += 1
		if Input.is_action_pressed("yaw_left"):
			net_input.x -= 1
		if Input.is_action_pressed("pitch_down"): # FIXME: The pitch down and pitch up
			net_input.y -= 1
		if Input.is_action_pressed("pitch_up"):
			net_input.y += 1
	
	net_input = net_input.normalized()
	return net_input

func get_using_controller() -> bool:
	return using_controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Detect input events
func _input(event) -> void:
	if event is InputEventJoypadMotion:
		using_controller = true
	elif event is InputEventKey or event is InputEventMouseMotion:
		using_controller = false
