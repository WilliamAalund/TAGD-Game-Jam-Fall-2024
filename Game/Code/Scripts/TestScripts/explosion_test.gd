extends Node3D

@onready var explosion_scene = load("res://Code/Entities/Explosion/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var explosion_child = explosion_scene.instantiate()
	self.add_child(explosion_child)
	pass # Replace with function body.
