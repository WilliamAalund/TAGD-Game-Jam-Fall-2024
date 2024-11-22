extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	self.pitch_scale = randf_range(0.9,1.1)
	#print("I have entered the scene tree")
	self.play()
	await self.finished
	#print("I am leaving the scene tree")
	self.queue_free()
