extends Node

var Weapons = {
	1:
	{
		"weapon": WeaponConstants.DEFAULT_LASER_WEAPON
	},
	2:
	{
		"Name": "Laser",
		"rpm": 100,
		"auto": true,
		"range": 500,
		"velocity": 1000,
		"spread": 0,
		"damage": 2,
		"mode": 1
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
