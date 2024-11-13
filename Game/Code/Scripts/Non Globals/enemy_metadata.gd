extends Node3D

@onready var body = $ShipBody
@onready var explosion_scene = load("res://Code/Entities/Explosion/Explosion.tscn")

signal enemy_defeated(defeat_position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_ship_position():
	return body.global_position

func _on_core_stats_manager_enemy_hp_depleted() -> void:
	var explosion_child = explosion_scene.instantiate()
	explosion_child.explosion_type = explosion_child.explosion_types.ENEMY_SHIP
	self.get_parent().add_child(explosion_child)
	explosion_child.global_position = body.global_position
	enemy_defeated.emit(body.global_position)
	self.queue_free()

func _on_new_player_data_packet(packet):
	body.target_position = packet["global_pos"]
