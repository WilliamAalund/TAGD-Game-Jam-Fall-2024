extends Node3D

@onready var objective_pointer = load("res://Code/UI/ObjectivePointer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # No need to do anything here for now.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("expand_hud"):
		self.visible = true
	else:
		self.visible = false

# Function to update the enemy position pointers.
func update_enemy_position_pointers(enemy_positions: Array) -> void:
	# If no enemy positions are provided, clear all existing children
	var positions_to_point_to := enemy_positions
	if PlayerData.level_complete_item_avaliable:
		positions_to_point_to.append(PlayerData.level_complete_item_position)
	
	if enemy_positions.size() == 0:
		# Remove all children
		for child in get_children():
			child.queue_free()
		return
	
	# Get the current list of children
	var current_children = get_children()
	var current_count = current_children.size()
	var target_count = positions_to_point_to.size()

	# If we have fewer children than positions, spawn new children
	if target_count > current_count:
		for i in range(current_count, target_count):
			var new_pointer = objective_pointer.instantiate()  # Spawn a new pointer
			add_child(new_pointer)  # Add to the scene tree

	# If we have more children than positions, remove the extra children
	if target_count < current_count:
		# Loop backward to safely queue the extra children for removal
		for i in range(current_count - 1, target_count - 1, -1):
			current_children[i].queue_free()  # Remove the extra children

	# Now, update the remaining children to point at the corresponding enemy positions
	current_children = get_children()  # Re-fetch the updated list of children
	for i in range(target_count):
		var child = current_children[i]
		var target_position = positions_to_point_to[i]
		child.look_at(target_position)  # Point the child towards the target position
