extends Node3D

@onready var body = $ShipBody

signal enemy_defeated(defeat_position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_ship_position():
	return body.global_position

func _on_core_stats_manager_enemy_hp_depleted() -> void:
	enemy_defeated.emit(body.global_position)
	self.queue_free()

func _on_new_player_data_packet(packet):
	body.target_position = packet["global_pos"]
