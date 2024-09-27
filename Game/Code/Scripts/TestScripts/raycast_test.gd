extends Node3D

@onready var ray = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ray.position.y -= 0.1 * delta

# Note: Raycasts ONLY update every physics frame, so accessing their contents needs to be done through _physics_process
func _physics_process(delta: float) -> void:
	print(ray.get_collision_point())
	print(ray.is_colliding())
