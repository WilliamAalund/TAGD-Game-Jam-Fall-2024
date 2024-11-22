extends Node

@onready var background = load("res://Code/PrimaryScenes/TitleScreen/TitleScreenBackground.tscn")
@onready var top_menu_button = $UI/VBoxContainer/Arcade
@onready var level_label = $UI/LevelRecord
@onready var ui = $UI

signal play_arcade(player_count: int)
signal play_debug
signal quit_game
signal title_clear_save

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

func hide_ui_elements():
	ui.visible = false

func show_ui_elements():
	ui.visible = true

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
	var high_score = Saving.get_high_score()
	if farthest_level == -1 or high_score == -1:
		level_label.text = "No save file yet"
	else:
		level_label.text = "Farthest level reached: " + str(farthest_level) + "\nHighest Score: " + str(high_score)

func _on_debug_pressed():
	play_debug.emit()

func _on_quit_pressed():
	quit_game.emit()

func _on_arcade_pressed():
	play_arcade.emit(1)

func _on_button_pressed() -> void:
	title_clear_save.emit()
