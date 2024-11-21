extends Control

@onready var boost_bar = $VBoxContainer/Boost
@onready var ship_model = $ShipModelContainer/ShipBasisRect/SubViewport/MiniPlayerShipModel/Ship
@onready var player_backview = $RearviewRect/SubViewport/PlayerBackview
@onready var crosshair = $Crosshair
@onready var health = $MarginContainer2/VBoxContainer/Health
@onready var health_label = $MarginContainer2/VBoxContainer/Label
@onready var level_label = $GameMetadata/Level
@onready var velocity_label = $ShipModelContainer/VelocityLabel
@onready var objective_label = $RearviewRect/ObjectiveLabel
@onready var objective_pointers = $ObjectivePointers
@onready var weapon_label = $MarginContainer/HBoxContainer/Label
@onready var tooltip_label = $ToolTipLabel
@onready var tooltip_label_animation = $ToolTipLabel/AnimationPlayer
# Called when the node enters the scene tree for the first time.

var player_input = ShipSteeringInput.new()

func _ready():
	pass # Replace with function body.
	self.add_child(player_input)
	crosshair.position = Vector2(0,0)
	tooltip_label_animation.play("ToolTipPulsate")
	tooltip_label.visible = true
	await get_tree().create_timer(6).timeout
	tooltip_label.visible = false


var audio_stream_played = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	health_label.text = "HP: " + str(PlayerData.HP) + " / " + str(PlayerData.maximum_HP)
	health.value = PlayerData.HP
	health.max_value = PlayerData.maximum_HP
	if float(PlayerData.HP) / PlayerData.maximum_HP < 0.3 and not audio_stream_played:
		low_health_alert()
		audio_stream_played = true
	if player_input.get_using_controller():
		tooltip_label.text = "View enemy positions by pressing Z"
	else:
		
		tooltip_label.text = "View enemy positions by pressing Z"
		

func low_health_alert():
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	$AudioStreamPlayer.play()

# Process information about the player
func _on_player_new_player_data_packet(packet):
	player_backview.global_position = packet["global_pos"]
	player_backview.basis = packet["ship_basis"]
	boost_bar.value = packet["boost_energy"]
	ship_model.basis = packet["ship_basis"]
	crosshair.position = packet["crosshair_position_2d"]
	#print(crosshair.position)
	velocity_label.text = str(packet["velocity"].length()).substr(0,5)
	objective_pointers.global_position = packet["global_pos"]
	weapon_label.text = WeaponConstants.get_name_for_id(PlayerData.primary_weapon_id)


# Process information about the game overall
func _on_game_new_game_data_packet(packet):
	level_label.text = "Level: " + str(packet["level"]) + "\nScore: " + str(PlayerData.score) + "\nScrap: " + str(PlayerData.scrap)
	objective_pointers.update_enemy_position_pointers(packet["enemy_positions"])
	#if packet["enemy_positions"].size() != 0:
		#objective_pointers.look_at(packet["enemy_positions"][0])
	
	if packet["enemies_spawned"] - packet["enemies_defeated"] == 1:
		objective_label.text = str(packet["enemies_spawned"] - packet["enemies_defeated"]) + " enemy remaining"
	elif packet["enemies_spawned"] - packet["enemies_defeated"] != 0:
		objective_label.text = str(packet["enemies_spawned"] - packet["enemies_defeated"]) + " enemies remaining"
	else:
		objective_label.text = "Collect green cylinder"
