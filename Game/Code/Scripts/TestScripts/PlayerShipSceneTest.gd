extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#
func _on_player_new_player_data_packet(packet):
	$Label.text = str(packet["velocity"].length())
	
	# Camera code handled elsewhere
	#camera_pivot.position = packet["global_pos"]
	#camera.rotation = packet["direction"]
