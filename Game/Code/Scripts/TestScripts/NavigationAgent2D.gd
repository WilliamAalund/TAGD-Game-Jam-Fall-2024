extends Sprite2D

@onready var movement_vector = $RayCast2D

@export var target = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	self.look_at(target)
	#print(self.global_position, target)
	self.global_position += Vector2(100 * delta,0).rotated(self.rotation)
	#var direction_vector = target - self.global_position 

	#movement_vector.target_position = Vector2(0,10)
