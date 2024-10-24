extends Area3D

@export var basis_of_projectile_creator = Basis()
@export var projectile_creator_group = "Not Set"
enum type_enum {LASER, MISSILE}
@export var type: type_enum


var base_projectile_speed = 400
var projectile_speed_falloff = 0 # Amount per second. For example, a projectile with a base_projecile_speed of 5 and a projectile_speed_falloff of 2.5 would last for two seconds
var maximum_projectile_range = 2500

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
	var direction_vector = self.transform.basis.z.normalized()
	self.position += direction_vector * current_speed * delta
	distance_traveled += current_speed * delta
	if distance_traveled >= maximum_projectile_range:
		#print("I have travelled for my maximum distance")
		self.queue_free()
	current_speed -= projectile_speed_falloff * delta
	if current_speed <= 0:
		print("I have lost all of my velocity")
		self.queue_free()


func _on_body_entered(body):
	print("Collided with body",projectile_creator_group,body.is_in_group(projectile_creator_group))
	
	if body.is_in_group("player") and projectile_creator_group == "enemy":
		print("Player hit by projectile")
	elif body.is_in_group("enemy") and projectile_creator_group == "player":
		print("Enemy hit by projectile")
		if body.has_signal("hit_by_projectile"):
			body.hit_by_projectile.emit("projectile")
	# FIXME: There is likely a better way to implement the code below.
	if not body.is_in_group(projectile_creator_group):
		print("Body is in not my creator")
	self.queue_free()
