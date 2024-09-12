extends Node

# This script is designed to interpolate between the signal the user is providing the game, and the actual value that the game will use.
# This is so that there can be smooth transitions between a low and high state.

@onready var mesh = $MeshInstance3D
var current_experienced_input_x = 0
var speed = 4 # Speed at which object rotates.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_x = 0
	if Input.is_action_pressed("debug_left"):
		input_x = 1
	elif Input.is_action_pressed("debug_right"):
		input_x = -1
	if input_x != current_experienced_input_x:
		current_experienced_input_x += (input_x - current_experienced_input_x) * delta * speed
	print(current_experienced_input_x)
	
	mesh.rotation.y = current_experienced_input_x
	
	
