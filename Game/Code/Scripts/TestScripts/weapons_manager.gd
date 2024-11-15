extends Node3D

# Weapons manager: Activates, deactivates weaponry
# Spawns in weapons that player utilizes
# Broadcasts current weapon for use in other UI elements

@onready var shotgun = load("res://Code/Tests/Weapons/Shotgun.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	# Use PlayerData to spawn in new weapons


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_up_weapon_v1(weapon: String):
	if weapon == "laser":
		print("Setting up a laser")

func setup_weapon_nodes(weapon):
	pass
