# EnemyCoreStatsManager
# Manages the core statistics of an enemy such as health points (HP), shield, and scrap dropped upon defeat.
# Emits a signal when the enemy's HP is depleted.

extends Node3D

signal enemy_HP_depleted  # Signal emitted when HP reaches 0.

@export var HP = 60  # Current health points of the enemy.
@export var maximum_HP = 60  # Maximum health points of the enemy.
@export var shield = 0  # Current shield points of the enemy.
@export var maximum_shield = 0  # Maximum shield points of the enemy.
@export var HP_depleted = false  # Flag to indicate if HP is depleted.
@export var base_scrap_dropped = 10  # Base amount of scrap dropped upon defeat.

# Inflicts damage to the enemy based on the damage type.
# If HP falls below or equals 0, sets HP to 0 and emits the 'enemy_HP_depleted' signal.
func inflict_damage(amount: int, damage_type):
	if damage_type == "projectile":
		HP -= amount
	if HP <= 0:
		HP = 0
		enemy_HP_depleted.emit()

# Handles the event when the enemy is hit by a projectile.
# Inflicts a fixed amount of damage.
func _on_body_navigator_hit_by_projectile(_projectile_kind: Variant) -> void:
	inflict_damage(20,"projectile")


func _on_enemy_hp_depleted() -> void:
	PlayerData.enemy_destroyed() # Handle updating information that the player needs
	


func _on_ship_body_ship_hit_by_projectile(projectile_kind: Variant) -> void:
	inflict_damage(10, "projectile")
