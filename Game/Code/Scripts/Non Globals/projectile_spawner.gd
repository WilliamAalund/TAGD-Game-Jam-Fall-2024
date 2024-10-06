extends Node3D

@onready var projectile_scene = load("res://Code/Entities/Projectile/v2/Projectile.tscn")
@onready var port_reference = $Marker3D

@export var is_firing = false
@export var always_firing = false
@export var rounds_per_minute = 400
@export var projectile_points = 0 # TODO: Implement some kind of feature that cycles between bullet spawn points

var time_since_last_fire = 0.0
var fire_rate = 60.0 / rounds_per_minute # Time between shots in seconds


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Increment the timer by the time elapsed since the last frame
	time_since_last_fire += delta
	# Check if it's time to fire the next projectile
	if is_firing or always_firing:
		if time_since_last_fire >= fire_rate:
			fire_projectile()
			time_since_last_fire = 0 # Reset the timer after firing

func fire_projectile():
	spawn_projectile()

func spawn_projectile():
	var new_projectile = projectile_scene.instantiate()
	new_projectile.set_up_projectile(3,self.global_transform.basis,"enemy")
	get_parent().get_parent().add_child(new_projectile) # Enables removal of lasers upon deletion of Parent node
	new_projectile.global_position = port_reference.global_position


func _on_player_in_sights_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_firing = true


func _on_player_in_sights_detector_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_firing = false
