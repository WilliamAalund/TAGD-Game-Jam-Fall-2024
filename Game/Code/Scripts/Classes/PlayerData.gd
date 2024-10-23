extends Node
class_name player_data

signal player_HP_depleted

enum upgrade_types {HEAL_HP,IMPROVE_MAX_HP,IMPROVE_MAX_SHIELD}

const BASE_MAXIMUM_HP := 150
const BASE_SCRAP := 0
const BASE_SHIELD = 0

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
@export var scrap := 0
@export var HP_depleted := false
@export var infinite_scrap := false
@export var score := 0
enum secondary_weapons {NONE,MISSILE,SCOPED,MINIGUN}
@export var secondary_weapon: secondary_weapons
@export var secondary_weapon_selected := false

var scrape_current_invincibility_frames = 0

func _process(_delta: float) -> void:
	if HP_depleted:
		player_HP_depleted.emit()


func _physics_process(_delta: float) -> void:
	if scrape_current_invincibility_frames > 0:
		scrape_current_invincibility_frames -= 1


func inflict_damage(amount: int, damage_type: String):
	if damage_type == "scrape" and scrape_current_invincibility_frames == 0:
		HP -= amount
		scrape_current_invincibility_frames = SCRAPE_INVINCIBILITY_FRAMES
	elif damage_type == "laser":
		HP -= amount
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
	
func prepare_player_stats_for_new_level():
	pass # TODO: Reset any cooldowns, and refresh shield

func enemy_destroyed():
	score += 100
	scrap += 10
