extends Node2D

@onready var sprite = $Sprite2D
@onready var cooler_sprite = $Sprite2D2
@onready var navigation_point = $Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	sprite.target = navigation_point.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed = 5
func _process(delta):
	cooler_sprite.target = navigation_point.global_position
	sprite.target = navigation_point.global_position
	pass
	if Input.is_action_pressed("debug_left"):
		navigation_point.position.x -= speed
	if Input.is_action_pressed("debug_right"):
		navigation_point.position.x += speed
	if Input.is_action_pressed("debug_up"):
		navigation_point.position.y -= speed
	if Input.is_action_pressed("debug_down"):
		navigation_point.position.y += speed
