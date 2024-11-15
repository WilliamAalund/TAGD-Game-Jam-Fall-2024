extends Node

const WEAPONS = [DEFAULT_LASER_WEAPON, GRANDPA_LASER]

const DEFAULT_LASER_WEAPON = {
	"name": "Baby Laser",
	"type": "Laser",
	"rpm": 500.0,
	"automatic": true,
	"range": 800.0,
	"velocity": 600.0,
	"spread": 0.6,
	"damage": 8,
	"firing_mode": "Alternate",
	"description": "Standard issue, reliable laser."
}

const GRANDPA_LASER = {
	"name": "Grandpa Laser",
	"type": "Laser",
	"rpm": 300.0,
	"automatic": true,
	"range": 750.0,
	"velocity": 400.0,
	"spread": 0.7,
	"damage": 13,
	"firing_mode": "Alternate",
	"description": "An older laser model that packs more of a punch, but is less reliable at range."
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
