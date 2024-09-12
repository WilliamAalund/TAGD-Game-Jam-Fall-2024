extends Node3D

# Script designed to rotate a mesh's basis properly. This will be used to rotate the ship.

# The mesh is "pointing" in the positive z direction, as indicated by the triangle.


@onready var mesh = $MeshInstance3D
var rotation_speed = 0.02


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Inefficient method of rotating the transform for the mesh. The first variable in the rotated() call can be changed to a single vector to create different movement behaviors.
	# Rotation speed could be altered by including the magnitude of the input.
	if Input.is_action_pressed("debug_up"):
		var rotated_transform = mesh.transform.rotated(mesh.transform.basis.x, -rotation_speed)
		mesh.transform = rotated_transform
	if Input.is_action_pressed("debug_down"):
		var rotated_transform = mesh.transform.rotated(mesh.transform.basis.x, rotation_speed)
		mesh.transform = rotated_transform
	if Input.is_action_pressed("debug_left"):
		var rotated_transform = mesh.transform.rotated(mesh.transform.basis.y, rotation_speed)
		mesh.transform = rotated_transform
	if Input.is_action_pressed("debug_right"):
		var rotated_transform = mesh.transform.rotated(mesh.transform.basis.y, -rotation_speed)
		mesh.transform = rotated_transform
	if Input.is_action_pressed("debug_rotate_right"):
		var rotated_transform = mesh.transform.rotated(mesh.transform.basis.z, rotation_speed)
		mesh.transform = rotated_transform
	if Input.is_action_pressed("debug_rotate_left"):
		var rotated_transform = mesh.transform.rotated(mesh.transform.basis.z, -rotation_speed)
		mesh.transform = rotated_transform


# Function copied from an earlier project. 
func grahm_schmidt_3d(y_vector: Vector3) -> Basis:
	# Modified Grahm Schmidt process that returns a positively oriented basis
	#print(y_vector)
	var epsilon = 0.0001
	#Edge cases to account for: Vector3(1,0,0)
	if y_vector.cross(Vector3(0,1,0)).length() < epsilon:
		#print(Basis.IDENTITY)
		#print(y_vector, " Providing basis")
		return Basis.IDENTITY
	elif y_vector.cross(Vector3(1,0,0)).length() < epsilon:
		#print(y_vector, " Providing basis")
		return Basis.IDENTITY
	var u1 := y_vector.normalized() # y vector for basis 

	var u2
	var u3
	if y_vector.x > 0:
		u2 = -u1.cross(Vector3(1,0,0)).normalized() # z vector for basis (?)
		u3 = u1.cross(u2) # x vector for basis
	else:
		u2 = -u1.cross(Vector3(1,0,0)).normalized() # z vector for basis (?)
		u3 = u1.cross(u2) # x vector for basis

	#var u2 := -u1.cross(Vector3(0,1,0)).normalized() # z vector for basis (?)
	#var u3 := u1.cross(u2) # x vector for basis
	var return_basis = Basis(u3,u1,u2)
	#print(y_vector, " ", return_basis)
	return return_basis
