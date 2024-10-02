extends CharacterBody3D

signal hit_by_projectile(projectile_kind)

@onready var _child_look_at := $ChildLookAt

@export var target_position := Vector3(0,5,0)
@export var travel_speed = 15
@export var rotation_speed_multiplier = 0.3

# Positions target position switches between
var active_target_position: Vector3 = Vector3(0,0,0)
var idle_target_position: Vector3
var pursuing_active_target_position = false

var object_in_the_way = false

func ready():
	idle_target_position = self.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Figure out if feelers are detecting object.
	# If they are, override target basis interpolation with another interpolation technique that rotates ship properly.
	interpolate_to_new_basis(delta)

func _physics_process(_delta: float) -> void:
	# Set target ship is pursuing to the ocrrect value
	if pursuing_active_target_position:
		target_position = active_target_position
	else:
		target_position = idle_target_position
	if object_in_the_way:
		pass
	else:
		move_ship_forward()

func interpolate_to_new_basis(delta):
	_child_look_at.look_at(target_position)
	var target_rotation = Quaternion(_child_look_at.global_transform.basis)
	var current_rotation = Quaternion(self.global_transform.basis)
	var next_rotation = current_rotation.slerp(target_rotation, delta * rotation_speed_multiplier)
	self.global_transform.basis = Basis(next_rotation)

func move_ship_forward():
	var direction_vector = -self.transform.basis.z.normalized()
	self.velocity = direction_vector * travel_speed
	move_and_slide()

func _on_player_new_player_data_packet(packet):
	active_target_position = packet["global_pos"]


func _on_player_detector_player_entered_area() -> void:
	print("Ship spotted player")
	pursuing_active_target_position = true


func _on_player_detector_player_exited_area() -> void:
	print("Ship lost sight of player")
	pursuing_active_target_position = false
