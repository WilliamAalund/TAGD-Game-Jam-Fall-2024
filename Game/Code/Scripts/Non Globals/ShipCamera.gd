extends Node3D

@export var camera_following_player := true

@onready var spring_arm = $SpringArm3D
@onready var camera = $SpringArm3D/Camera3D
@onready var front_camera_animation = $SpringArm3D/Camera3D/AnimationPlayer

var target_basis
var base_camera_rotate_speed = 30.0 ##
var focus_camera_rotate_speed = 200.0 # FIXME: These Values dont do anything!!! The real values are hardcoded into the animation player
var base_camera_fov = 65.0

var focus_camera_fov = 45.0
@export var fov_control = 1.0 # Used to control camera zoom in.
@export var camera_control_enabled = true
var zoomed_in = false
var breaking = true
var speeding = false

@export var current_camera_rotate_speed: float = base_camera_rotate_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	target_basis = self.transform.basis
	camera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	camera.fov = base_camera_fov * fov_control
	if camera_control_enabled:
		if Input.is_action_pressed("boost"):
			if speeding == false:
				front_camera_animation.play("accelerate")
			speeding = true
		else:
			if speeding == true:
				front_camera_animation.play("decelerate")
			speeding = false
		if Input.is_action_pressed("focus"):
			if zoomed_in == false:
				pass
				front_camera_animation.play("front_camera_zoom_in")
			zoomed_in = true
		else:
			if zoomed_in == true:
				pass
				front_camera_animation.play("front_camera_zoom_out")
			zoomed_in = false
		if Input.is_action_pressed("break") and not zoomed_in:
			if breaking == false:
				pass
				#front_camera_animation.play("break_start")
			breaking = true
		else:
			if breaking == true:
				pass
				#front_camera_animation.play("break_end")
			breaking = false
		target_basis = target_basis.orthonormalized()
		var new_basis = self.transform.basis.slerp(target_basis, delta * current_camera_rotate_speed)
		new_basis = new_basis.orthonormalized()
		self.transform.basis = target_basis.orthonormalized() #new_basis
		#$Label.text = "Prev basis: " + str(self.transform.basis) + " New Basis: " + str(new_basis)

func get_unprojected_position_from_camera(coordinate: Vector3):
	return camera.unproject_position(coordinate)

func _on_player_new_player_data_packet(packet):
	if camera_following_player:
		self.global_position = packet["global_pos"] 
		target_basis = packet["ship_basis"]
	spring_arm.spring_length = 8 # + packet["velocity"].length() / 10
