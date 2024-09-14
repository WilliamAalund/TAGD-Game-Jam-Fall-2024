extends Node

# This script is designed to simulate how to control the rate of fire for a projectile system. 
# The script keeps track of how much time has passed, and uses that to determine if the player can fire another shot.

@onready var bar = $ProgressBar
@onready var rpm_label = $Label

# Define variables
var rpm = 413 # Rounds per minute
var fire_rate = 60.0 / rpm # Time between shots in seconds
var time_since_last_fire = 0.0 # Timer to track time since last shot

func _ready():
	# Initialize any necessary setup here
	bar.max_value = fire_rate
	bar.value = time_since_last_fire
	rpm_label.text = "RPM: " + str(rpm)
	pass

func _process(delta):
	# Increment the timer by the time elapsed since the last frame
	time_since_last_fire += delta
	
	# Check if it's time to fire the next projectile
	if Input.is_action_pressed("debug_press_3"):
		if time_since_last_fire >= fire_rate:
			fire_projectile()
			time_since_last_fire = 0 # Reset the timer after firing
	bar.value = time_since_last_fire

func fire_projectile():
	# Implement the logic to instantiate and fire a projectile here
	Input.start_joy_vibration(0,0.2,0.1,0.10)
	print("Projectile fired")


func _on_line_edit_text_submitted(new_text):
	print("lol")
	pass # Replace with function body.
	if new_text.is_valid_float():
		rpm = float(new_text) # Rounds per minute
		fire_rate = 60.0 / rpm # Time between shots in seconds
		time_since_last_fire = 0.0 # Timer to track time since last shot
		rpm_label.text = "RPM: " + str(rpm)

