extends Node3D

@onready var spawn_mesh = load("res://Code/Tests/WorldGeneration/SpawnMesh.tscn")
@onready var mesh_parent = $MeshParent

var myfirstAABB = AABB(Vector3(0,0,0), Vector3(1,1,1))
var mysecondAABB = AABB(Vector3(1,0,0), Vector3(2,1,2))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	generate_and_spawn_objects()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_press_1"):
		generate_and_spawn_objects()
	if Input.is_action_just_pressed("debug_press_2"):
		for child in mesh_parent.get_children():
			child.queue_free()

func generate_positions(n: int, boundary_min: Vector3, boundary_max: Vector3, size: float):
	var positions = []
	var attempts = 0
	var max_attempts = n * 10  # Prevent infinite loops

	while positions.size() < n and attempts < max_attempts:
		var new_pos = generate_random_position(boundary_min, boundary_max)
		if is_far_enough(new_pos, positions, size):
			positions.append(new_pos)
		else:
			attempts += 1
	return positions

func generate_random_position(boundary_min, boundary_max):
	return Vector3(randf_range(boundary_min.x, boundary_max.x),
					randf_range(boundary_min.y, boundary_max.y),
					randf_range(boundary_min.z, boundary_max.z))

func is_far_enough(new_pos, positions, size):
	for pos in positions:
		if new_pos.distance_to(pos) < size:
			return false
	return true

func generate_and_spawn_objects():
	var spawn_positions = generate_positions(15,Vector3(0,0,0),Vector3(300,300,300),80)
	print(spawn_positions)
	for pos in spawn_positions:
		var spawn_mesh_child = spawn_mesh.instantiate()
		mesh_parent.add_child(spawn_mesh_child)
		spawn_mesh_child.global_position = pos
