extends Control

@onready var boost_bar = $VBoxContainer/Boost
@onready var ship_model = $ShipBasisRect/SubViewport/MiniShipModel/Ship
@onready var crosshair = $Crosshair

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
