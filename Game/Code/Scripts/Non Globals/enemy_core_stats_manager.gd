extends Node3D

signal enemy_HP_depleted

@export var HP = 60
@export var maximum_HP = 60
@export var shield = 0
@export var maximum_shield = 0
@export var HP_depleted = false

func inflict_damage(amount: int, damage_type):
	if damage_type == "projectile":
		HP -= amount
	if HP <= 0:
		HP = 0
		enemy_HP_depleted.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_navigator_hit_by_projectile(_projectile_kind: Variant) -> void:
	inflict_damage(20,"projectile")
