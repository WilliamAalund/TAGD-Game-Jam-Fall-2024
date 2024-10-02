extends Area3D

signal player_entered_area
signal player_exited_area


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Enemy detected player")
		player_entered_area.emit()


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_exited_area.emit()
