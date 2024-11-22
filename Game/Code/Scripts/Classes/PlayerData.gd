extends Node
class_name player_data

signal player_HP_depleted
signal player_bought_weapon(id)

enum upgrade_types {HEAL_HP,IMPROVE_MAX_HP,IMPROVE_MAX_SHIELD}

const BASE_MAXIMUM_HP := 100
const BASE_SCRAP := 0
const BASE_SHIELD = 0

# Scrap values
const ENEMY_DESTROYED_SCRAP_VALUE = 5
const LEVEL_COMPLETED_SCRAP_VALUE = 10
const LEVEL_PERFECT_SCRAP_VALUE = 5

# Ship
const MIN_TRAVEL_SPEED := -10.0
const BASE_TRAVEL_SPEED := 20.0
const MAX_TRAVEL_SPEED := 80.0
const ACCELERATION := 1.0
const MAX_BOOST := 100
const BOOST_ENERGY_REENABLE_THRESHOLD := 25
const BOOST_ENERGY_REGENERATION_RATE := 14
const BOOST_ENERGE_DEPETION_RATE := 18

# Projectiles
const LASER_RPM := 413.0

# Frame times
const SCRAPE_INVINCIBILITY_FRAMES := 4
const SHIELD_TIME_TO_REGENERATE_BEGIN := 300

@export var HP := BASE_MAXIMUM_HP
@export var maximum_HP := BASE_MAXIMUM_HP
@export var shield := 0
@export var maximum_shield := 0
@export var speed_boost := 1.0
@export var health_boost := 1.0
@export var scrap := 0
@export var HP_depleted := false
@export var infinite_scrap := false
@export var score := 0
#enum secondary_weapons {NONE,MISSILE,SCOPED,MINIGUN}
@export var primary_weapon_id = 0
@export var secondary_weapon_id = -1
@export var secondary_weapon_selected := false

@export var hit_sound_effect_needs_to_be_played = false

var level_complete_item_position := Vector3()
var level_complete_item_avaliable := false

var player_hit_during_current_level = false

var scrape_current_invincibility_frames = 0

func _process(_delta: float) -> void:
	if HP_depleted:
		player_HP_depleted.emit()


func _physics_process(_delta: float) -> void:
	if scrape_current_invincibility_frames > 0:
		scrape_current_invincibility_frames -= 1


func inflict_damage(amount: int, damage_type: String):
	player_hit_during_current_level = true
	if damage_type == "scrape" and scrape_current_invincibility_frames == 0:
		HP -= amount
		scrape_current_invincibility_frames = SCRAPE_INVINCIBILITY_FRAMES
	elif damage_type == "laser":
		HP -= amount
	elif damage_type == "outofbounds":
		HP = 0
	if HP <= 0: # Death will be taken care of in process loop
		HP = 0
		HP_depleted = true


func apply_upgrade(upgrade_type: upgrade_types):
	pass # TODO: Implement upgrading stats through a shop
	if upgrade_type == upgrade_types.IMPROVE_MAX_HP:
		maximum_HP += 10
		HP += 10

# Function called in the Game scene when a level begins.
func reset_player_stats(): 
	HP_depleted = false
	HP = BASE_MAXIMUM_HP
	maximum_HP = BASE_MAXIMUM_HP
	scrap = BASE_SCRAP
	score = 0
	primary_weapon_id = 0
	secondary_weapon_id = -1
	speed_boost = 1.0
	
func prepare_player_stats_for_new_level():
	pass # TODO: Reset any cooldowns, and refresh shield
	player_hit_during_current_level = false
	level_complete_item_avaliable = false

func enemy_destroyed():
	score += 100
	scrap += ENEMY_DESTROYED_SCRAP_VALUE

func award_scrap_for_level_completion(game_level):
	scrap += LEVEL_COMPLETED_SCRAP_VALUE + game_level * 2
	print("Was player hit? ",player_hit_during_current_level)
	if not player_hit_during_current_level:
		scrap += LEVEL_PERFECT_SCRAP_VALUE

func buyWeapon(weapon, price):
	if canBuy(price):
		scrap -= price
		primary_weapon_id = weapon.weapID
	
func buyItem(item_name, price):
	if canBuy(price):
		scrap -= price
		if (item_name == "Speed Boost"):
			speed_boost += 0.2
		else:
			health_boost += 0.2
			maximum_HP = BASE_MAXIMUM_HP
			maximum_HP *= health_boost
			HP = maximum_HP

func canBuy(price):
	#check if player can buy item
	if(scrap < price):
		return false
	return true

func hit_registered(): # Runs when the player successfully hits something
	pass
	hit_sound_effect_needs_to_be_played = true
	
func killPlayer():
	inflict_damage(1, "outofbounds")
