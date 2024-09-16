extends Node3D

@onready var spawn_point = $ProjectileSpawnPoint

@onready var projectile_scene = load("res://Code/Entities/Projectile/Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_press_1"):
		spawn_projectile()

func spawn_projectile():
	pass
	var new_projectile = projectile_scene.instantiate()
	spawn_point.add_child(new_projectile)
