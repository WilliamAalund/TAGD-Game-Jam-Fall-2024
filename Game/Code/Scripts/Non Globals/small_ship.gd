extends Node3D

@onready var body = $BodyNavigator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_new_player_data_packet(packet):
	#print(packet)
	body.target_position = packet["global_pos"]

func _on_core_stats_manager_enemy_hp_depleted() -> void:
	self.queue_free()
