extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_exited(body):
	pass # Replace with function body.
	print("Body exited play area")


func _on_body_entered(body):
	pass # Replace with function body.
	print("Body entered play area")
