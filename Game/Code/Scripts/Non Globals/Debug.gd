extends Node

signal debug_quit

@onready var debug_scene = load("res://Code/Tests/Player/PlayerShipSceneTest.tscn")

var debug_is_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if debug_is_active:
		if Input.is_action_pressed("debug_quit"):
			self.get_child(0).queue_free() # Probably this
			debug_quit.emit()
			debug_is_active = false

func start_debug():
	var debug_test = debug_scene.instantiate()
	self.add_child(debug_test)
	debug_is_active = true
	
