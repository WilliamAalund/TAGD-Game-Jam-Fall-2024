extends Control

@onready var boost_bar = $VBoxContainer/Boost
@onready var ship_model = $ShipBasisRect/SubViewport/MiniShipModel/Ship
@onready var crosshair = $Crosshair
@onready var health = $MarginContainer2/VBoxContainer/Health
@onready var health_label = $MarginContainer2/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	crosshair.position = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_new_player_data_packet(packet):
	boost_bar.value = packet["boost_energy"]
	ship_model.basis = packet["ship_basis"]
	crosshair.position = packet["crosshair_position_2d"]
	health_label.text = "HP: " + str(packet["HP"]) + " / " + str(packet["maximum_HP"])
	health.value = packet["HP"]
	health.max_value = packet["maximum_HP"]
	
	
