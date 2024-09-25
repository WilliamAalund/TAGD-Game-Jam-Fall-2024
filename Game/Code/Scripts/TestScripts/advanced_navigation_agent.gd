extends Node3D

@onready var navigation_point = $Marker3D
@onready var navigator = $Navigator

var weight = .01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	navigator.target_position = navigation_point.global_position
	move_target_marker()
	#rotate_smoothly_to_target()
	
	
func move_target_marker():
	if Input.is_action_pressed("debug_left"):
		navigation_point.position.x -= .1
	if Input.is_action_pressed("debug_right"):
		navigation_point.position.x += .1
	if Input.is_action_pressed("debug_up"):
		navigation_point.position.z += -.1
	if Input.is_action_pressed("debug_down"):
		navigation_point.position.z += .1
	if Input.is_action_pressed("debug_rotate_left"):
		navigation_point.position.y += -.1
	if Input.is_action_pressed("debug_rotate_right"):
		navigation_point.position.y += .1

func rotate_smoothly_to_target(): # This is probably the wrong approach
	#cache the current rotation
	var rot = Quaternion(Vector3.UP, navigator.rotation)
	# use look_at to look at the desired location
	look_at(navigation_point.global_position, Vector3.UP)
	# cache the new "target" rotation
	var target_rot = Quaternion(Vector3.UP, navigator.rotation)
	#use Quat.Slerp to perform spherical interpolation to the target rotation
	#a weight like 0.1 works well
	#then set the rotation by converting the Quat back to a Eule
	navigator.rotation = navigator.rotation.slerp(target_rot, weight).get_euler()
