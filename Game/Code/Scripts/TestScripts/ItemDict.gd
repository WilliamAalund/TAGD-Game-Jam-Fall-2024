extends Node

var Items = {
	"Blaster":
	{
		"weapID": 1,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A powerful blaster",
		"type": "Weapon",
		"reqlvl": 0
		
	},
	"Laser":
	{
		"weapID": 2,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A powerful laser beam",
		"type": "Weapon",
		"reqlvl": 0
	},
	"Missile":
	{
		"weapID": 3,
		"image": "sfdsfS",
		"description": "A powerful missile",
		"type": "Weapon",
		"reqlvl": 0
	},
	"Speed Boost":
	{
		"weapID": 99,
		"image": "res://Resources/Images/icon.svg",
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
