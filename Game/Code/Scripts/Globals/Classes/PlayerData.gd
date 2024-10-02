extends Node
class_name player_data

enum upgrade_types {HEAL_HP,IMPROVE_MAX_HP,IMPROVE_MAX_SHIELD}

const BASE_MAXIMUM_HP = 150
const BASE_SCRAP = 0
const BASE_SHIELD = 0

@export var HP = BASE_MAXIMUM_HP
@export var maximum_HP = BASE_MAXIMUM_HP
@export var shield = 0
@export var maximum_shield = 0
@export var scrap = 0
@export var HP_depleted = false
@export var infinite_scrap = false
@export var score = 0

func change_hp_by(value: int):
	pass # TODO: Implement HP changing logic

func apply_upgrade(upgrade_type: upgrade_types):
	pass # TODO: Implement upgrading stats through a shop
	if upgrade_type == upgrade_types.IMPROVE_MAX_HP:
		pass

func reset_player_stats():
	HP = BASE_MAXIMUM_HP
	maximum_HP = BASE_MAXIMUM_HP
	scrap = BASE_SCRAP
	
