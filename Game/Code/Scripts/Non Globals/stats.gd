extends Node3D

# This node is mostly redundant now, as it is merely an interface with the PlayerData global script now. It originally fufilled nany of the functions the PlayerData script does now. 
# It should probably be deleted, however, it may be useful as an organized way to route damage requests through.
# If this node is deleted, all of the nodes it broadcasts signals to will need to receive the PlayerData signal version of it

signal player_HP_depleted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	PlayerData.player_HP_depleted.connect(self._on_player_data_hp_depleted)

func _on_ship_ship_scraping_against_surface() -> void:
	PlayerData.inflict_damage(2, "scrape")
	#inflict_damage(2, "scrape")


func _on_player_data_hp_depleted() -> void:
	print("Player data global says that HP is depleted")
	player_HP_depleted.emit() # FIXME: This signal is redundant.
