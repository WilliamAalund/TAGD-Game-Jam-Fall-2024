extends Node

var Items = {
	"Slightly-Modified Blaster":
	{
		"weapID": 1,
		"image": "res://Resources/Textures/Laser.png",
		"description": "An older weapon that packs a punch, but is less reliable at range.",
		"type": "Weapon",
		"reqlvl": 0
		
	},
	"Pea Shooter":
	{
		"weapID": 2,
		"image": "res://Resources/Textures/Laser.png",
		"description": "Fires a quick stream of accurate but weak laser beams.",
		"type": "Weapon",
		"reqlvl": 0
	},
	"AI Generated Laser":
	{
		"weapID": 3,
		"image": "res://Resources/Textures/Laser.png",
		"description": "Behold! A marvel of modern technology. Soon, all laser manufacturers will be out of business.",
		"type": "Weapon",
		"reqlvl": 3
	},
	"Sawed Off Laser Shot":
	{
		"weapID": 4,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A close range cannon that fires multiple pellets at once.",
		"type": "Weapon",
		"reqlvl": 3
	},
	"Accuro Ray":
	{
		"weapID": 5,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A highly advanced laser cannon developed by Dr. Accuro. It fires lasers that are completely accurate.",
		"type": "Weapon",
		"reqlvl": 7
	},
	"D.M.L.":
	{
		"weapID": 6,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A semi-automatic laser cannon that serves well at medium to long range.",
		"type": "Weapon",
		"reqlvl": 5
	},
	"Sniper":
	{
		"weapID": 7,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A lethal, accurate, long range weapon.",
		"type": "Weapon",
		"reqlvl": 5
	},
	"Exacto-Beam":
	{
		"weapID": 8,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A beam of concentrated energy. Need I say more?",
		"type": "Weapon",
		"reqlvl": 9
	},
	"Speed Boost":
	{
		"weapID": 98,
		"image": "res://Resources/Textures/speed.png",
		"description": "A minor speed boost",
		"type": "Boost",
		"reqlvl": 0
	},
	"Health Boost":
	{
		"weapID": 99,
		"image": "res://Resources/Textures/health.png",
		"description": "A minor health boost",
		"type": "Health",
		"reqlvl": 0
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
