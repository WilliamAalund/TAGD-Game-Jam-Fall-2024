extends Sprite2D

@export var target =  Vector2(0,0)

var direction = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Dot product of 1 = Pointing in exact same direction
	# Dot product of -1, pointing in exact opposite direction
	#var navigation_vector = self.global_position - target
	#var navigation_dot_direction = navigation_vector.normalized().dot(direction.normalized())
	#var direction_dot_navigation = direction.normalized().dot(navigation_vector.normalized())
	## Which dot product it is doesn't matter
	#print(self.rotation)
	#print(navigation_dot_direction)
	# When the direction is to the left
	var v = target - self.global_position

	var angle = v.angle()

	var r = self.global_rotation

	self.global_rotation = lerp_angle(r,angle,0.04)
	
