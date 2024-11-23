extends Node3D

@onready var boost_stream = $BoostStream
@export var sound_enabled = true

@export var current_speed = 0.0

var upper_speed = 80

var lower_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#$ShipMovementStream.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not sound_enabled:
		boost_stream.stop()
	if not boost_stream.playing:
		boost_stream.play()
	boost_stream.pitch_scale = (current_speed / upper_speed) + 1
	


func _on_player_new_player_data_packet(packet: Variant) -> void:
	current_speed = packet["speed"]
