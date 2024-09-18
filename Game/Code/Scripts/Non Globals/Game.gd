extends Node

@onready var game_objects = $GameObjects

@onready var player_ship = load("res://Code/Entities/Player/v1/Player.tscn")
@onready var arcade_level = load("res://Code/Levels/ArcadeLevel.tscn")

@export var debug_enabled = false

var number_of_players = 1
enum game_modes {ARCADE,COOP,DEATHMATCH}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_game(number_of_players, game_mode: game_modes) -> void:
	# If game_mode is ARCADE:
	# Initialize a single viewport
	# load level one
	pass

func pause_game(game_mode: game_modes):
	pass

func unpause_game(game_mode: game_modes):
	pass

func quit_game():
	# Kill all child nodes in the GameObjects node
	pass

func load_level(game_mode: game_modes):
	pass

func game_over(game_mode: game_modes):
	pass
