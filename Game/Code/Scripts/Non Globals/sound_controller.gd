extends Node3D

@onready var audio_stream = $LaserFireStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_projectile_handler_projectile_fired(_projectile_name: Variant) -> void:
	pass # Replace with function body.
	audio_stream.play()
