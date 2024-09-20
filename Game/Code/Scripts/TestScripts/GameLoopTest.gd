extends Node

@onready var label = $Label

enum GameState {LOADING, PLAYING, SHOP, WIN, LOSE}
var current_state = GameState.LOADING
var current_level = 1 # Step 1: Add a variable to keep track of the level

func _ready():
	transition_to(GameState.LOADING)

func _process(_delta):
	match current_state:
		GameState.PLAYING:
			if Input.is_action_just_pressed("debug_press_1"):
				transition_to(GameState.WIN) # Change to WIN state when debug_press_1 is pressed in PLAYING state
			elif Input.is_action_just_pressed("debug_press_2"):
				transition_to(GameState.LOSE)
		GameState.SHOP:
			if Input.is_action_just_pressed("debug_press_1"):
				transition_to(GameState.LOADING)

func transition_to(state):
	current_state = state
	match state:
		GameState.LOADING:
			var loading_text = "Loading level %d..." % current_level
			print(loading_text)
			label.text = loading_text
			transition_to(GameState.PLAYING) # Automatically transition to PLAYING after loading
		GameState.PLAYING:
			var playing_text = "Level %d: Game is now in playing state. Press 1 to win, 2 to lose." % current_level
			print(playing_text)
			label.text = playing_text
		GameState.SHOP:
			var shop_text = "Welcome to the shop! Press 1 to load another level."
			print(shop_text)
			label.text = shop_text
		GameState.WIN:
			var win_text = "You've won level %d! Congratulations!" % current_level
			print(win_text)
			label.text = win_text
			current_level += 1
			transition_to(GameState.SHOP) # After winning, go to the shop
		GameState.LOSE:
			var lose_text = "You've lost on level %d. Better luck next time!" % current_level
			print(lose_text)
			label.text = lose_text

func _on_win_pressed():
	if current_state == GameState.PLAYING:
		transition_to(GameState.WIN)

func _on_lose_pressed():
	if current_state == GameState.PLAYING:
		transition_to(GameState.LOSE)
