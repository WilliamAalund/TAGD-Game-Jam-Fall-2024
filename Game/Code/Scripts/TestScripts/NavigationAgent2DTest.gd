extends Node2D

@onready var sprite = $Sprite2D
@onready var navigation_point = $Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	sprite.target = navigation_point.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
