extends Node

const WEAPONS = [DEFAULT_LASER_WEAPON, GRANDPA_LASER, PEA_SHOOTER, AI_GENERATED_LASER, SAWED_OFF_LASER_SHOT, ACCURO_RAY, DML, SNIPER]

const COMMON_WEAPONS = [DEFAULT_LASER_WEAPON, GRANDPA_LASER, PEA_SHOOTER]

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
	"description": "Standard issue, reliable laser.",
	"cost": 0
}

const GRANDPA_LASER = {
	"name": "Grandpa Laser",
	"type": "Laser",
	"rpm": 333.3,
	"automatic": true,
	"range": 750.0,
	"velocity": 400.0,
	"spread": 0.7,
	"damage": 13,
	"firing_mode": "Alternate",
	"description": "An older weapon that packs a punch, but is less reliable at range.",
	"cost": 230
}

const PEA_SHOOTER = {
	"name": "Pea Shooter",
	"type": "Laser",
	"rpm": 700,
	"automatic": true,
	"range": 950.0,
	"velocity": 750.0,
	"spread": 0.5,
	"damage": 6,
	"firing_mode": "Alternate",
	"description": "Fires a quick stream of accurate but weak laser beams.",
	"cost": 170
}

const AI_GENERATED_LASER = {
	"name": "Pea Shooter",
	"type": "Laser",
	"rpm": 400,
	"automatic": true,
	"range": 700.0,
	"velocity": 500.0,
	"spread": 0.7,
	"damage": 7,
	"firing_mode": "Alternate",
	"description": "Behold! A marvel of modern technology. Soon, all laser manufacturers will be out of business.",
	"cost": 640
}

const SAWED_OFF_LASER_SHOT = {
	"name": "Sawed Off Laser Shot",
	"type": "Shotgun",
	"rpm": 150,
	"automatic": true,
	"range": 300.0,
	"velocity": 500.0,
	"spread": 1.2,
	"damage": 4,
	"number_of_pellets": 4,
	"firing_mode": "Bottom",
	"description": "A close range cannon that fires multiple pellets at once.",
	"cost": 640
}

const ACCURO_RAY = {
	"name": "Accuro Ray",
	"type": "Laser",
	"rpm": 1200,
	"automatic": true,
	"range": 1250.0,
	"velocity": 1000.0,
	"spread": 0.0,
	"damage": 7,
	"firing_mode": "Alternate",
	"description": "A highly advanced laser cannon developed by Dr. Accuro. It fires lasers that are completely accurate.",
	"cost": 170
}

const DML = {
	"name": "D.M.L",
	"type": "Laser",
	"rpm": 300,
	"automatic": false,
	"range": 1000.0,
	"velocity": 900.0,
	"spread": 0.4,
	"damage": 14,
	"firing_mode": "Alternate",
	"description": "A semi-automatic laser cannon that serves well at medium to long range.",
	"cost": 300
}

const SNIPER = {
	"name": "Sniper",
	"type": "Laser",
	"rpm": 50,
	"automatic": false,
	"range": 1500.0,
	"velocity": 1300.0,
	"spread": 0.05,
	"damage": 50,
	"firing_mode": "Alternate",
	"description": "A lethal, accurate, long range weapon.",
	"cost": 500
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
