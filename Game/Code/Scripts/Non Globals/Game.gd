extends Node

signal new_game_data_packet(packet)
signal game_killed

@onready var game_objects = $GameObjects # Reference to node where objects are stored
@onready var pause_screen = $PauseScreenPlaceholder
@onready var player_ship = load("res://Code/Entities/Player/v1/Player.tscn")
@onready var arcade_level = load("res://Code/Levels/ArcadeLevel.tscn")
@onready var ship_hud = load("res://Code/UI/InGame.tscn")
@onready var level_complete_item = load("res://Code/Entities/Items/LevelComplete/LevelComplete.tscn")
@onready var small_enemy_ship = load("res://Code/Entities/Enemies/v2/EnemyScenes/BabyShip/BabyShip.tscn")
@export var debug_enabled = false

var game_is_active = false # Boolean used to control when the quit button is listening for user input.
var player_reference = null
# Game metadata
var number_of_players = 1
enum game_modes {ARCADE,COOP,DEATHMATCH}

# Singleplayer game metadata
var game_score := 0
var game_level := 1
var singleplayer_game_data_packet = {}
var enemies_spawned = 0
var enemies_defeated = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#PlayerData.player_HP_depleted.connect(self._on_player_destroyed())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if debug_enabled and game_is_active:
		if Input.is_action_just_pressed("debug_quit"):
			quit_game()
	if game_is_active:
		if Input.is_action_just_pressed("toggle_pause"):
			print("Pause toggled")
			if game_objects.process_mode == Node.PROCESS_MODE_INHERIT:
				pause_game(game_modes.ARCADE)
			elif game_objects.process_mode == Node.PROCESS_MODE_DISABLED:
				unpause_game(game_modes.ARCADE)
	singleplayer_game_data_packet["score"] = game_score
	singleplayer_game_data_packet["level"] = game_level
	new_game_data_packet.emit(singleplayer_game_data_packet)
	

func start_game(_number_of_players, _game_mode: game_modes) -> void:
	PlayerData.reset_player_stats()
	game_level = 1
	game_is_active = true
	if _game_mode == game_modes.ARCADE:
		# Initialize a single viewport
		
		load_level(game_modes.ARCADE)
		
	else:
		print("Other game modes not implemented")
	pass

func pause_game(_game_mode: game_modes):
	game_objects.process_mode = Node.PROCESS_MODE_DISABLED
	pause_screen.visible = true
	pass

func unpause_game(_game_mode: game_modes):
	game_objects.process_mode = Node.PROCESS_MODE_INHERIT
	pause_screen.visible = false
	pass

func quit_game():
	# Kill all child nodes in the GameObjects node
	game_is_active = false
	unload_level()
	game_killed.emit()

func load_level(_game_mode: game_modes):
	# Load player
	var player_child = player_ship.instantiate()
	player_reference = player_child
	# Load UI
	var hud_child = ship_hud.instantiate()
	
	# Level complete
	#var level_complete_child = level_complete_item.instantiate()
	
	# Connect UI to player object
	player_child.new_player_data_packet.connect(hud_child._on_player_new_player_data_packet)
	
	# Connect UI to game
	self.new_game_data_packet.connect(hud_child._on_game_new_game_data_packet)
	
	# Connect player destroyed to game over
	player_child.player_destroyed.connect(self._on_player_destroyed)
	
	# Connect player data packet to game
	player_child.new_player_data_packet.connect(self._on_new_player_data_packet)
	
	# Connect level complete to complete function
	#level_complete_child.position.z = 100
	#level_complete_child.body_entered.connect(self._on_level_complete_item_touched)
	
	# Spawn children
	game_objects.add_child(hud_child)
	game_objects.add_child(player_child)
	player_child.position.z = 300
	#game_objects.add_child(level_complete_child)
	
		# Load level # TODO: Make tutorial levels, then randomly generate them
	var arcade_level_child = arcade_level.instantiate()
	game_objects.add_child(arcade_level_child)
	enemies_spawned = 0
	enemies_defeated = 0
	for i in range(game_level):
		spawn_enemy(Vector3(randi_range(-200,200),randi_range(-200,200),0))
	

func unload_level():
	unpause_game(game_modes.ARCADE)
	for node in game_objects.get_children():
		print("Killing node: ", node)
		node.queue_free()

func game_over(_game_mode: game_modes):
	quit_game()
	
func spawn_enemy(spawn_position: Vector3):
	pass # TODO: Make enemy entities spawn in the level
	var enemy_instance = small_enemy_ship.instantiate()
	enemies_spawned += 1
	#enemy_instance.global_position = spawn_position
	player_reference.new_player_data_packet.connect(enemy_instance._on_new_player_data_packet)
	enemy_instance.enemy_defeated.connect(self._on_enemy_defeated)
	game_objects.add_child(enemy_instance)
	enemy_instance.global_position = spawn_position

func spawn_complete_object(spawn_position: Vector3):
	var level_complete_child = level_complete_item.instantiate()
	level_complete_child.position = spawn_position
	level_complete_child.body_entered.connect(self._on_level_complete_item_touched)
	game_objects.add_child(level_complete_child)

func _on_level_complete_item_touched(body):
	if body.is_in_group("player"):
		print("Player collected level complete item")
		unload_level()
		game_level += 1
		load_level(game_modes.ARCADE)

func _on_enemy_defeated(position_perished):
	pass # TODO: Make enemy entities broadcast a signal to this function. Then, score and other veriables can be altered.
	enemies_defeated += 1
	if enemies_defeated >= enemies_spawned:
		spawn_complete_object(position_perished)
		pass # Spawn the level complete item

func _on_player_destroyed():
	game_over(game_modes.ARCADE)

func _on_new_player_data_packet(_packet):
	pass
