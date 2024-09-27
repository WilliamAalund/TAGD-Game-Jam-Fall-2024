@tool
extends Node3D

signal net_raycast_collision_vector(vector: Vector2)

# Raycast references
@onready var top_right_ray := $TR
@onready var top_middle_ray := $TM
@onready var top_left_ray := $TL
@onready var bottom_right_ray := $BR
@onready var bottom_middle_ray := $BM
@onready var bottom_left_ray := $BL


@export var cast_length := 4.0
@export var frame_width := 2.0
@export var frame_height := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_raycast_positions()
	set_raycast_lengths()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		set_raycast_positions()
		set_raycast_lengths()


# Every time the raycasts update, check them out
func _physics_process(delta: float) -> void: 
	# This vector represents the direction in which the body reading it needs to move in order to avoid a collision.
	var net_avoidance_vector = Vector2(0,0)
	
	# FIXME: This math is only accurate for square frames. Some math could be used to alter what quantities are added to the final vector.
	# Check if raycasts are colliding
	if top_right_ray.is_colliding():
		net_avoidance_vector.x -= 1
		net_avoidance_vector.y -= 1
	if top_middle_ray.is_colliding():
		net_avoidance_vector.y -= 1
	if top_left_ray.is_colliding():
		net_avoidance_vector.x += 1
		net_avoidance_vector.y -= 1
	
	if bottom_right_ray.is_colliding():
		net_avoidance_vector.x -= 1
		net_avoidance_vector.y += 1
	if bottom_middle_ray.is_colliding():
		net_avoidance_vector.y += 1
	if bottom_left_ray.is_colliding():
		net_avoidance_vector.x += 1
		net_avoidance_vector.y += 1

	if net_avoidance_vector != Vector2(0,0):
		net_avoidance_vector = net_avoidance_vector.normalized()
		net_raycast_collision_vector.emit(net_avoidance_vector)
		print(net_avoidance_vector)


func set_raycast_positions() -> void:
	top_right_ray.position.x = frame_width / 2.0
	top_right_ray.position.y = frame_height / 2.0
		
	top_left_ray.position.x = -frame_width / 2.0
	top_left_ray.position.y = frame_height / 2.0
		
	bottom_right_ray.position.x = frame_width / 2.0
	bottom_right_ray.position.y = -frame_height / 2.0
	
	bottom_left_ray.position.x = -frame_width / 2.0
	bottom_left_ray.position.y = -frame_height / 2.0
	
	top_middle_ray.position.x = 0.0
	top_middle_ray.position.y = frame_height / 2.0
	
	bottom_middle_ray.position.x = 0.0
	bottom_middle_ray.position.y = -frame_height / 2.0

func set_raycast_lengths() -> void: 
	top_right_ray.target_position.z = -cast_length
	top_left_ray.target_position.z = -cast_length
	top_middle_ray.target_position.z = -cast_length
	
	bottom_right_ray.target_position.z = -cast_length
	bottom_left_ray.target_position.z = -cast_length
	bottom_middle_ray.target_position.z = -cast_length
