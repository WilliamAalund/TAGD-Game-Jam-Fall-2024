extends Node

@onready var game = $Game
@onready var title_screen = $TitleScreen
@onready var debug = $Debug
@onready var intro = $Intro
@onready var audio = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_title_screen_play_arcade(_player_count):
	audio.play()
	print("Main: User started arcade mode")
	title_screen.hide_ui_elements()
	intro.show()
	await intro.player_moved_past_intro
	audio.play()
	title_screen.show_ui_elements()
	title_screen.hide()
	intro.hide()
	game.start_game(_player_count,0)
	pass # Replace with function body.


func _on_title_screen_play_debug():
	print("Main: User started debug mode")
	title_screen.hide()
	debug.start_debug()
	

func _on_debug_debug_quit():
	print("Main: User quit debug mode")
	title_screen.show()

func _on_title_screen_quit_game(): # End the game
	get_tree().quit()

func _on_game_game_killed():
	print("Main: User killed game")
	title_screen.show()


func _on_title_screen_title_clear_save() -> void:
	print("User requested to delete save data")
	Saving.reset_save_data()
	title_screen.set_farthest_level_label()
