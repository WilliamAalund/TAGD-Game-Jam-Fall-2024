extends Node

@onready var velocity_label = $Label


var base_velocity = 200.0
var max_velocity = 450.0 # Maximum velocity
var min_velocity = 80.0
var acceleration = 4.0 # Rate of change of velocity

var current_velocity = base_velocity
var target_velocity = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Increase velocity
	if Input.is_action_pressed("debug_press_1"):
		target_velocity = max_velocity
	# Decrease velocity
	elif Input.is_action_pressed("debug_press_2"):
		target_velocity = min_velocity
	else:
		# No buttons pressed, return to 0 velocity
		target_velocity = base_velocity
	
	# Interpolate current velocity towards target velocity
	current_velocity = lerp(current_velocity, target_velocity, acceleration * delta)
	
	# Use current_velocity for movement or other logic here
	print(current_velocity)
	$Node2D.rotation += deg_to_rad(current_velocity) / 10.0
	velocity_label.text = str(current_velocity)
