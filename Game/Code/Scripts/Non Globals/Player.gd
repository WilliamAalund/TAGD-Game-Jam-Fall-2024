extends Node3D

signal new_player_data_packet(packet)

@onready var player_ship = $Ship
@onready var camera = $ShipCamera

var player_data_packet = {"global_pos": Vector3(), "velocity": Vector3(), "direction": Vector3()}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Initial setup can be done here.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	construct_player_data_packet()

# Function to construct and optionally alter the player data packet.
func construct_player_data_packet():
	player_data_packet["global_pos"] = player_ship.global_position
	player_data_packet["velocity"] = player_ship.velocity
	player_data_packet["direction"] = player_ship.transform.basis.z
	player_data_packet["ship_basis"] = player_ship.transform.basis
	player_data_packet["boost_energy"] = player_ship.boost_energy
	player_data_packet["boost_depleted"] = player_ship.boost_depleted
	var crosshair_position_2d = camera.get_unprojected_position_from_camera(player_ship.get_3d_crosshair_position())
	player_data_packet["crosshair_position_2d"] = crosshair_position_2d
	player_data_packet["player_3d_crosshair_position"] = player_ship.get_3d_crosshair_position()
	player_data_packet["left_playable_space"] = player_ship.left_playable_space
	# Example alteration: Add a timestamp or any other relevant data.
	#player_data_packet["timestamp"] = OS.get_
	# Further alterations can be done here based on game logic.
	emit_signal("new_player_data_packet", player_data_packet)
