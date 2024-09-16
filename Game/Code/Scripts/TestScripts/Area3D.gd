extends Area3D

@export var basis_of_projectile_creator = Basis()
@export var projectile_creator_group = "Booger"
enum type_enum {LASER, MISSILE}
@export var type: type_enum


var base_projectile_speed = 5
var projectile_speed_falloff = 2.5 # Amount per second. For example, a projectile with a base_projecile_speed of 5 and a projectile_speed_falloff of 2.5 would last for two seconds
var maximum_projectile_range = 5

var distance_traveled
var current_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	self.transform.basis = basis_of_projectile_creator
	current_speed = base_projectile_speed
	distance_traveled = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.z += current_speed * delta
	distance_traveled += current_speed * delta
	if distance_traveled >= maximum_projectile_range:
		print("I have travelled for my maximum distance")
		self.queue_free()
	current_speed -= projectile_speed_falloff * delta
	if current_speed <= 0:
		print("I have lost all of my velocity")
		self.queue_free()


func _on_body_entered(body):
	print("Collided with body")
	if not body.is_in_group(projectile_creator_group):
		print("Body is in not my creator")
		
	self.queue_free()
