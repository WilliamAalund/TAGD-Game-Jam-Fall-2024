extends Control

@onready var boost_bar = $VBoxContainer/Boost
@onready var ship_model = $ShipBasisRect/SubViewport/MiniPlayerShipModel/Ship
@onready var crosshair = $Crosshair
@onready var health = $MarginContainer2/VBoxContainer/Health
@onready var health_label = $MarginContainer2/VBoxContainer/Label
@onready var level_label = $GameMetadata/Level
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	crosshair.position = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	health_label.text = "HP: " + str(PlayerData.HP) + " / " + str(PlayerData.maximum_HP)
	health.value = PlayerData.HP
	health.max_value = PlayerData.maximum_HP

# Process information about the player
func _on_player_new_player_data_packet(packet):
	boost_bar.value = packet["boost_energy"]
	ship_model.basis = packet["ship_basis"]
	crosshair.position = packet["crosshair_position_2d"]


# Process information about the game overall
func _on_game_new_game_data_packet(packet):
	level_label.text = "Level: " + str(packet["level"])
	
