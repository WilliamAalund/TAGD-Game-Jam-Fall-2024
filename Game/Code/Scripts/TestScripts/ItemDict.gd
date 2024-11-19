extends Node

var Items = {
	"Blaster":
	{
		"weapID": 1,
		"image": "image",
		"description": "A powerful blaster",
		"type": "Weapon",
		"modifier": 1.2,
		"reqlvl": 0
		
	},
	"Laser":
	{
		"weapID": 2,
		"image": "res://Resources/Textures/Laser.png",
		"description": "A powerful laser beam",
		"type": "Weapon",
		"modifier": 1.5,
		"reqlvl": 5
	},
	"Missile":
	{
		"price": 3,
		"description": "A powerful missile",
		"type": "Weapon",
		"modifier": 2,
		"reqlvl": 10
	},
	"Speed Boost":
	{
		"weapID": 99,
		"description": "A minor speed boost",
		"type": "Boost",
		"modifier": 1.5,
		"reqlvl": 0	
	},
	"Health Boost":
	{
		"weapID": 99,
		"description": "A minor health boost",
		"type": "Health",
		"modifier": 1.2,
		"reqlvl": 0
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
