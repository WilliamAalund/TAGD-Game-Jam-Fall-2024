extends Node3D

@onready var spring_arm = $SpringArm3D

var target_basis
var camera_rotate_speed = 12.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	target_basis = self.transform.basis


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	target_basis = target_basis.orthonormalized()
	var new_basis = lerp(self.transform.basis, target_basis, delta * camera_rotate_speed)
	new_basis = new_basis.orthonormalized()
	self.transform.basis = new_basis


func _on_player_new_player_data_packet(packet):
	self.global_position = packet["global_pos"] 
	target_basis = packet["ship_basis"]
	spring_arm.spring_length = 2 + packet["velocity"].length() / 100
