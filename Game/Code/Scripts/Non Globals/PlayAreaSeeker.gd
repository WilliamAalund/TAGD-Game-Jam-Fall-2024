extends Node3D

@onready var mesh = $Arrow
@onready var animation_player = $Arrow/AnimationPlayer

@export var play_area_position = Vector3(0,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	animation_player.play("PlayAreaSeekerPulsate")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var navigation_vector = play_area_position - self.global_position
	print(navigation_vector)
	self.look_at(navigation_vector)

func _on_player_new_player_data_packet(packet):
	#self.global_position = packet["global_pos"]
	self.transform.basis = packet["ship_basis"]
