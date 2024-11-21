extends Node

const WEAPONS = [DEFAULT_LASER_WEAPON, GRANDPA_LASER, PEA_SHOOTER, AI_GENERATED_LASER, SAWED_OFF_LASER_SHOT, ACCURO_RAY, DML, SNIPER, EXACTO_BEAM]

#const COMMON_WEAPONS = [DEFAULT_LASER_WEAPON, GRANDPA_LASER, PEA_SHOOTER]

enum port_modes{ALTERNATE,BOTTOM,THREE,ENEMY,CENTER}

func get_name_for_id(weapon_id: int) -> String:
	return WEAPONS[weapon_id]["name"]

const DEFAULT_LASER_WEAPON = {
	"name": "Blaster",
	"type": "Laser",
	"rpm": 550.0,
	"automatic": true,
	"range": 800.0,
	"velocity": 600.0,
	"spread": 0.6,
	"damage": 8,
	"firing_mode": port_modes.ALTERNATE,
	"description": "Standard issue, reliable laser.",
	"cost": 0
}

const GRANDPA_LASER = {
	"name": "Grandpa Laser",
	"type": "Laser",
	"rpm": 360.0,
	"automatic": true,
	"range": 750.0,
	"velocity": 400.0,
	"spread": 0.7,
	"damage": 13,
	"firing_mode": port_modes.ALTERNATE,
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
	"firing_mode": port_modes.ALTERNATE,
	"description": "Fires a quick stream of accurate but weak laser beams.",
	"cost": 170
}

const AI_GENERATED_LASER = {
	"name": "AI Generated Lazer",
	"type": "Laser",
	"rpm": 400,
	"automatic": true,
	"range": 700.0,
	"velocity": 500.0,
	"spread": 0.9,
	"damage": 6,
	"firing_mode": port_modes.BOTTOM,
	"description": "A marvel of modern technology. Soon, all laser manufacturers will be out of business.",
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
	"damage": 5,
	"number_of_pellets": 4,
	"firing_mode": port_modes.BOTTOM,
	"description": "A close range cannon that fires multiple pellets at once.",
	"cost": 640
}

const ACCURO_RAY = {
	"name": "Accuro Ray",
	"type": "Laser",
	"rpm": 1500,
	"automatic": true,
	"range": 1250.0,
	"velocity": 1000.0,
	"spread": 0.0,
	"damage": 7,
	"firing_mode": port_modes.BOTTOM,
	"description": "An advanced weapon platform developed by Dr. Accuro. It fires lasers that are perfectly accurate.",
	"cost": 170
}

const DML = {
	"name": "D.M.L",
	"type": "Laser",
	"rpm": 500,
	"automatic": false,
	"range": 1100.0,
	"velocity": 900.0,
	"spread": 0.3,
	"damage": 14,
	"firing_mode": port_modes.BOTTOM,
	"description": "A semi-automatic laser cannon that serves well at medium to long range.",
	"cost": 300
}

const SNIPER = {
	"name": "Sniper",
	"type": "Laser",
	"rpm": 70,
	"automatic": false,
	"range": 1500.0,
	"velocity": 1300.0,
	"spread": 0.05,
	"damage": 60,
	"firing_mode": port_modes.BOTTOM,
	"description": "A lethal, accurate, long range weapon.",
	"cost": 500
}

const EXACTO_BEAM = {
	"name": "Exacto Beam",
	"type": "Laser",
	"rpm": 3500,
	"automatic": true,
	"range": 600.0,
	"velocity": 750.0,
	"spread": 0.2,
	"damage": 4,
	"firing_mode": port_modes.BOTTOM,
	"description": "A beam of concentrated energy. Need I say more?",
	"cost": 170
}


# NOT IMPLEMENTED
const DEFAULT_LASER_V2 = {
	"name": "Blaster 2",
	"type": "Laser",
	"rpm": 800.0,
	"automatic": true,
	"range": 900.0,
	"velocity": 900.0,
	"spread": 0.3,
	"damage": 11,
	"firing_mode": port_modes.ALTERNATE,
	"description": "Good news folks. They saw Blaster and decided to make Blaster 2.",
	"cost": 170
}

const HEAVY_LASER_SHOT = {
	"name": "Heavy Laser Shot",
	"type": "Shotgun",
	"rpm": 700.0,
	"automatic": true,
	"range": 150.0,
	"velocity": 900.0,
	"spread": 0.3,
	"damage": 9,
	"number_of_pellets": 6,
	"firing_mode": port_modes.ALTERNATE,
	"description": "A heavy laser cannon that melts through enemies at close range, but is utterly useless anywhere else.",
	"cost": 170
}
