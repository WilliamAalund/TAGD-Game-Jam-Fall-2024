extends Node

signal game_killed

@onready var game_objects = $GameObjects # Reference to node where objects are stored
@onready var player_ship = load("res://Code/Entities/Player/v1/Player.tscn")
@onready var arcade_level = load("res://Code/Levels/ArcadeLevel.tscn")
@onready var ship_hud = load("res://Code/UI/InGame.tscn")
@export var debug_enabled = false

var game_is_active = false

var number_of_players = 1
enum game_modes {ARCADE,COOP,DEATHMATCH}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if debug_enabled and game_is_active:
		if Input.is_action_just_pressed("debug_quit"):
			quit_game()

func start_game(_number_of_players, _game_mode: game_modes) -> void:
	game_is_active = true
	if _game_mode == game_modes.ARCADE:
		# Initialize a single viewport
		
		# Load player
		var player_child = player_ship.instantiate()
		
		
		# Load UI
		var hud_child = ship_hud.instantiate()
		
		# Connect UI to player object
		player_child.new_player_data_packet.connect(hud_child._on_player_new_player_data_packet)
		
		game_objects.add_child(hud_child)
		game_objects.add_child(player_child)
		
		
		# Load level # TODO: Make tutorial levels, then randomly generate them
		var arcade_level_child = arcade_level.instantiate()
		game_objects.add_child(arcade_level_child)
	else:
		print("Other game modes not implemented")
	pass

func pause_game(_game_mode: game_modes):
	pass

func unpause_game(_game_mode: game_modes):
	pass

func quit_game():
	# Kill all child nodes in the GameObjects node
	game_is_active = false
	for node in game_objects.get_children():
		print("Killing node: ", node)
		node.queue_free()
	game_killed.emit()

func load_level(_game_mode: game_modes):
	pass

func game_over(_game_mode: game_modes):
	pass
