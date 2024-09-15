extends Node

@onready var pivot = $Pivot

var point_vector_beginning = Vector3(0,0,1)
var point_vector_end = Vector3(0,-1,0)

var curr_vector = point_vector_beginning

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var target_basis = pivot.transform.basis
	
	
	
	#var new_vector = curr_vector
	if Input.is_action_pressed("debug_up"):
		target_basis = target_basis.rotated(Vector3(1,0,0), 1)
	elif Input.is_action_pressed("debug_down"):
		target_basis = target_basis.rotated(Vector3(1,0,0), -1)
		
	var new_basis = lerp(pivot.transform.basis, target_basis, delta)
	pivot.transform.basis = new_basis
