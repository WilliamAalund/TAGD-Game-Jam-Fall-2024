extends Node3D

@onready var projectile_scene = load("res://Code/Entities/Projectile/v2/Projectile.tscn")

enum port_modes{ALTERNATE,BOTTOM,THREE,ENEMY}
@export var port_mode: port_modes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_projectile(spread: float, velocity: float, range: float, damage: float, enemy_projectile: bool) -> void:
	pass
	var projectile_to_spawn = projectile_scene.instantiate()
	print("Spawning Projectile")
