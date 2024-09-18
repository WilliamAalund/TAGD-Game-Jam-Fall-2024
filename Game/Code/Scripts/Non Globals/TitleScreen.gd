extends Node

@onready var background = load("res://Code/PrimaryScenes/TitleScreen/TitleScreenBackground.tscn")

signal play_arcade(player_count: int)
signal play_debug
signal quit_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var background_child = background.instantiate()
	self.add_child(background_child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hide():
	self.remove_child($Background)
	#$Background.visible = true
	$UI.visible = false

func show():
	var background_child = background.instantiate()
	self.add_child(background_child)
	$UI.visible = true

func _on_debug_pressed():
	play_debug.emit()

func _on_quit_pressed():
	quit_game.emit()
