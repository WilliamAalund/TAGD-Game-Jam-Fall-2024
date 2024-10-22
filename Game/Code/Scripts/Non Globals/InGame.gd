extends Control

@onready var boost_bar = $VBoxContainer/Boost
@onready var ship_model = $ShipModelContainer/ShipBasisRect/SubViewport/MiniPlayerShipModel/Ship
@onready var player_backview = $RearviewRect/SubViewport/PlayerBackview
@onready var crosshair = $Crosshair
@onready var health = $MarginContainer2/VBoxContainer/Health
@onready var health_label = $MarginContainer2/VBoxContainer/Label
@onready var level_label = $GameMetadata/Level
@onready var velocity_label = $ShipModelContainer/VelocityLabel
@onready var objective_label = $ShipModelContainer/ObjectiveLabel
@onready var objective_pointers = $ObjectivePointers
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
	player_backview.global_position = packet["global_pos"]
	player_backview.basis = packet["ship_basis"]
	boost_bar.value = packet["boost_energy"]
	ship_model.basis = packet["ship_basis"]
	crosshair.position = packet["crosshair_position_2d"]
	velocity_label.text = str(packet["velocity"].length()).substr(0,5)
	objective_pointers.global_position = packet["global_pos"]


# Process information about the game overall
func _on_game_new_game_data_packet(packet):
	level_label.text = "Level: " + str(packet["level"])
	if packet["enemy_positions"].size() != 0:
		objective_pointers.look_at(packet["enemy_positions"][0])
	
	if packet["enemies_spawned"] - packet["enemies_defeated"] == 1:
		objective_label.text = str(packet["enemies_spawned"] - packet["enemies_defeated"]) + " enemy remaining"
	elif packet["enemies_spawned"] - packet["enemies_defeated"] != 0:
		objective_label.text = str(packet["enemies_spawned"] - packet["enemies_defeated"]) + " enemies remaining"
	else:
		objective_label.text = "Collect green cylinder"
