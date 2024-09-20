extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.left_playable_area()


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player ship entered the play area")
		body.entered_playable_area()
