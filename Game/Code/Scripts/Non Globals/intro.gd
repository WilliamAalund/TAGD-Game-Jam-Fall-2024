extends Node

var player_input = ShipSteeringInput.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	self.add_child(player_input)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_input.get_using_controller():
		$Control/KeyboardControls.visible = false
		if player_input.controller_used.contains("PS"):
			#print("Player using PS5")
			$Control/PS5Controls.visible = true
			pass
		elif player_input.controllet_used.contains("X"):
			#print("Player using Xbox Controller")
			pass
		else:
			pass
	else:
		#print("Player using computer controls")
		$Control/PS5Controls.visible = false
		pass
		$Control/KeyboardControls.visible = true

func hide():
	pass

func show():
	pass
