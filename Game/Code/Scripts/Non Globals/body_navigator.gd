extends CharacterBody3D

@onready var _child_look_at := $ChildLookAt

@export var target_position := Vector3(0,5,0)
@export var travel_speed = 15
@export var rotation_speed_multiplier = 0.6

var object_in_the_way = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Figure out if feelers are detecting object.
	# If they are, override target basis interpolation with another interpolation technique that rotates ship properly.
	interpolate_to_new_basis(delta)

func _physics_process(_delta: float) -> void:
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
