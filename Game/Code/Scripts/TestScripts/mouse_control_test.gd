extends Node2D

const LOWER_THRESHOLD = 10
const UPPER_THRESHOLD = 150

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var window_center_y = get_viewport().size.y / 2
	var window_center_x = get_viewport().size.x / 2
	var mouse_position_y = get_viewport().get_mouse_position().y
	var mouse_position_x = get_viewport().get_mouse_position().x
	
	var vertical_distance = mouse_position_y - window_center_y
	var horizontal_distance = mouse_position_x - window_center_x
	
	var vertical_ratio = 0.0
	var horizontal_ratio = 0.0
	
	if abs(vertical_distance) < LOWER_THRESHOLD:
		vertical_ratio = 0.0
	else:
		vertical_ratio = clamp(vertical_distance / UPPER_THRESHOLD, -1.0, 1.0)
	
	if abs(horizontal_distance) < LOWER_THRESHOLD:
		horizontal_ratio = 0.0
	else:
		horizontal_ratio = clamp(horizontal_distance / UPPER_THRESHOLD, -1.0, 1.0)
	
	print("Vertical distance ratio: ", vertical_ratio)
	print("Horizontal distance ratio: ", horizontal_ratio)
