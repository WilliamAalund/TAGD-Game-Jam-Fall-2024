@tool
extends Node3D

@onready var animation = $AnimationPlayer
@onready var explosive_mesh = $MeshInstance3D

@export var beginning_size = 0.01
@export var end_size = 1.5
@export var beginning_transparency := 0.1
@export var end_transparency := 1.1
@export var interpolation_time := 0.0
enum explosion_types {LASER,MISSILE,ENEMY_SHIP,PLAYER_SHIP,LARGE_SHIP,LARGE_EXPLOSION}
@export var explosion_type: explosion_types = explosion_types.LASER 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	explosive_mesh.scale = Vector3(1,1,1) * lerp(beginning_size,end_size,interpolation_time)
	explode()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	explosive_mesh.scale = Vector3(1,1,1) * lerp(beginning_size,end_size,interpolation_time)
	explosive_mesh.transparency = lerp(beginning_transparency,end_transparency,interpolation_time)
	#explosive_mesh.transparency = lerp(beginning_transparency,end_transparency,interpolation_time)


func explode():
	if explosion_type == explosion_types.LASER:
		animation.play("quick_explosion")
	


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if not Engine.is_editor_hint():
		queue_free()
