extends Node3D

@onready var raycast_grid = $RaycastGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	raycast_grid.position.z -= 1 * delta
