extends Node3D

signal new_player_data_packet(packet)
signal player_destroyed

@onready var player_ship = $Ship
@onready var camera = $ShipCamera
@onready var stats = $CoreStatsManager

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
	if crosshair_position_2d.y == INF: # Prevents glitch when scene initalizes: crosshair_position_2d is sometimes (nan, inf)
		crosshair_position_2d = DisplayServer.screen_get_size() / 2.0
	player_data_packet["crosshair_position_2d"] = crosshair_position_2d
	player_data_packet["player_3d_crosshair_position"] = player_ship.get_3d_crosshair_position()
	player_data_packet["left_playable_space"] = player_ship.left_playable_space
	player_data_packet["HP"] = stats.HP
	player_data_packet["maximum_HP"] = stats.maximum_HP

	# Further alterations can be done here based on game logic.
	emit_signal("new_player_data_packet", player_data_packet)


func _on_core_stats_manager_player_hp_depleted() -> void:
	player_destroyed.emit()
