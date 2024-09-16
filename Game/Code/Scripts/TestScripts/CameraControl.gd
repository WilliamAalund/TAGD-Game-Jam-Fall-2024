extends Node

@onready var pivot = $Pivot

var increment_speed = 0.02

var target_basis
var camera_speed = 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	target_basis = pivot.transform.basis


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("debug_up"):
		target_basis = target_basis.rotated(Vector3(1,0,0), increment_speed)
	elif Input.is_action_pressed("debug_down"):
		target_basis = target_basis.rotated(Vector3(1,0,0), -increment_speed)
	if Input.is_action_pressed("debug_left"):
		target_basis = target_basis.rotated(Vector3(0,1,0), increment_speed)
	elif Input.is_action_pressed("debug_right"):
		target_basis = target_basis.rotated(Vector3(0,1,0), -increment_speed)

	target_basis = target_basis.orthonormalized()
	var new_basis = lerp(pivot.transform.basis, target_basis, delta * camera_speed)
	new_basis = new_basis.orthonormalized()
	pivot.transform.basis = new_basis
