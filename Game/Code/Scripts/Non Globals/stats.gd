extends Node3D

signal player_HP_depleted

@export var HP = 150
@export var maximum_HP = 150
@export var shield = 0
@export var maximum_shield = 0
@export var scrap = 0
@export var HP_depleted = false
@export var infinite_scrap = false

func get_health():
	return HP
func get_maximum_health():
	return maximum_HP
func get_scrap():
	return scrap
func attempt_purchase(scrap_price: int) -> bool:
	if infinite_scrap:
		return true
	if scrap < scrap_price:
		return false
	else:
		scrap -= scrap_price
		return true
func inflict_damage(amount: int, damage_type):
	if damage_type == "scrape" and scrape_current_invincibility_frames == 0:
		HP -= amount
		scrape_current_invincibility_frames = SCRAPE_INVINCIBILITY_FRAMES
	else:
		print("Damage type not implemented")
	if HP < 0: # Death will be taken care of in process loop
		HP = 0


const SCRAPE_INVINCIBILITY_FRAMES = 4
var scrape_current_invincibility_frames = 0

func decrement_invincibility_frames():
	if scrape_current_invincibility_frames > 0:
		scrape_current_invincibility_frames -= 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if HP <= 0:
		HP = 0
		HP_depleted = true
	if HP_depleted == true:
		player_HP_depleted.emit()

func _physics_process(delta: float) -> void:
	decrement_invincibility_frames()

func _on_ship_ship_scraping_against_surface() -> void:
	inflict_damage(2, "scrape")
