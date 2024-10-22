extends Node3D
# This script is used by the naivgator node in the AdvancedNavigationAgent test to interpolate betweeh a direction that the node wants to move, and the direction it is currently facing.

@onready var _child_look_at := $MeshInstance3D/ChildLookAt
@onready var mesh := $MeshInstance3D
@export var target_position = Vector3(0,0,-1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	# Figure out if feelers are detecting object.
	# If they are, override target basis interpolation with another interpolation technique that rotates ship properly.
	
	_child_look_at.look_at(target_position)
	var target_rotation = Quaternion(_child_look_at.global_transform.basis)
	var current_rotation = Quaternion(mesh.global_transform.basis)
	var next_rotation = current_rotation.slerp(target_rotation, delta * 1)
	mesh.global_transform.basis = Basis(next_rotation)
	
	mesh.position -= mesh.global_transform.basis.z * delta * 3
	
	#var navigation_vector = target_position - mesh.global_position
	
	
	#mesh.global_position += navigation_vector.normalized() * mesh.global_transform.basis * delta * 4
	#mesh.global_position += Vector3(0,0,-1) * mesh.global_transform.basis
