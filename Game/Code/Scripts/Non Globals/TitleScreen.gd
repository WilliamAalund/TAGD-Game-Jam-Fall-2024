extends Node

@onready var background = load("res://Code/PrimaryScenes/TitleScreen/TitleScreenBackground.tscn")
@onready var top_menu_button = $UI/VBoxContainer/Arcade
@onready var level_label = $UI/LevelRecord

signal play_arcade(player_count: int)
signal play_debug
signal quit_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var background_child = background.instantiate()
	self.add_child(background_child)
	top_menu_button.grab_focus()
	set_farthest_level_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hide():
	self.remove_child($Background)
	#$Background.visible = true
	$UI.visible = false

func show():
	var background_child = background.instantiate()
	self.add_child(background_child)
	$UI.visible = true
	set_farthest_level_label()
	top_menu_button.grab_focus()

func set_farthest_level_label():
	var farthest_level = Saving.get_farthest_level_reached()
	if farthest_level == -1:
		level_label.text = ""
	else:
		level_label.text = "Farthest level reached: " + str(Saving.get_farthest_level_reached())

func _on_debug_pressed():
	play_debug.emit()

func _on_quit_pressed():
	quit_game.emit()

func _on_arcade_pressed():
	play_arcade.emit(1)
