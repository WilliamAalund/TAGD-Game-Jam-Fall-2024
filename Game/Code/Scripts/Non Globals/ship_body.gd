@tool
extends CharacterBody3D

# Script that handles navigation for a generic ship class. Export variables will be changed to alter aggressiveness/competency. of an individual ship, etc.

signal ship_hit_by_projectile(projectile_kind)

# Ship mesh paths are found in the Resources directory
@export var ship_mesh_path = "res://Resources/Meshes/Placeholder/SmallShip.tscn"
@export var travel_speed := 25
@export var rotation_speed_multiplier := 1.0
@export var avoids_collisions = false # TODO: Implement this variable

@onready var target_direction_node = $TargetDirectionNode
@onready var ship_mesh = load(ship_mesh_path)

var target_position := Vector3(0,5,0)
@export var active_target_position: Vector3 = Vector3(0,0,0)
@export var idle_target_position := Vector3(0,0,0)
var pursuing_active_target_position := false
var object_in_the_way := false # TODO: Implement RaycastGrid

func _ready():
	idle_target_position = self.global_position
	# Spawn in mesh as a child of the ship body
	var ship_mesh_child = ship_mesh.instantiate()
	self.add_child(ship_mesh_child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Figure out if feelers are detecting object.
	# If they are, override target basis interpolation with another interpolation technique that rotates ship properly.
	if not Engine.is_editor_hint():
		interpolate_to_new_basis(delta)


func _physics_process(_delta: float) -> void:
	# Set target ship is pursuing to the ocrrect value
	if not Engine.is_editor_hint():
		if pursuing_active_target_position:
			target_position = active_target_position
		else:
			target_position = idle_target_position
		if object_in_the_way:
			pass
		else:
			move_ship_forward()


func interpolate_to_new_basis(delta):
	target_direction_node.look_at(target_position)
	var target_rotation := Quaternion(target_direction_node.global_transform.basis)
	var current_rotation := Quaternion(self.global_transform.basis)
	var next_rotation := current_rotation.slerp(target_rotation, delta * rotation_speed_multiplier)
	self.global_transform.basis = Basis(next_rotation)


func move_ship_forward():
	var direction_vector := -self.transform.basis.z.normalized()
	self.velocity = direction_vector * travel_speed
	move_and_slide()


func damaged_by_projectile(projectile_kind): # Called by a colliding projectile area on the body navigator.
	ship_hit_by_projectile.emit(projectile_kind)


func _on_player_new_player_data_packet(packet):
	active_target_position = packet["global_pos"]


func _on_player_detector_player_entered_area() -> void:
	print("Ship spotted player")
	pursuing_active_target_position = true


func _on_player_detector_player_exited_area() -> void:
	print("Ship lost sight of player")
	pursuing_active_target_position = false
