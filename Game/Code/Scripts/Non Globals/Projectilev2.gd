extends CharacterBody3D

@onready var explosion_scene = load("res://Code/Entities/Explosion/Explosion.tscn")

@export var basis_of_projectile_creator = Basis()
@export var projectile_creator_group = "Not Set"
enum type_enum {LASER, MISSILE}
@export var type: type_enum

var distance_traveled
var current_maximum_projectile_range
var current_speed

const SPEED_LASER = 1250.0
const MAX_RANGE_LASER = 1500.0

func _ready() -> void:
	self.basis = basis_of_projectile_creator

func _physics_process(delta: float) -> void:
	# FIXME: The direction vector will need to be flipped, once the player ship is flipped.
	var direction_vector = -self.transform.basis.z.normalized()
	var motion = direction_vector * current_speed * delta
	
	var collision = move_and_collide(motion)
	
	distance_traveled += motion.length()
	if distance_traveled >= current_maximum_projectile_range or collision:
		if collision:
			#print("Collided with body: ",collision.get_collider())
			var collider = collision.get_collider()
			if collider.is_in_group("player") and projectile_creator_group == "enemy":
				print("Player hit by projectile")
			elif collider.is_in_group("enemy") and projectile_creator_group == "player":
				print("Enemy hit by projectile")
				if collider.has_method("damaged_by_projectile"):
					collider.damaged_by_projectile(type)
		#print("I have travelled for my maximum distance")
		var end_explosion = explosion_scene.instantiate()
		get_parent().add_child(end_explosion)
		end_explosion.global_position = self.global_position
		self.queue_free()

func set_up_projectile(projectile_type: type_enum, creator_basis: Basis,creator_group: String):
	basis_of_projectile_creator = creator_basis
	projectile_creator_group = creator_group
	distance_traveled = 0.0
	if projectile_type == type_enum.LASER:
		current_speed = SPEED_LASER
		current_maximum_projectile_range = MAX_RANGE_LASER
	else:
		print("Warning: invalid projectile type")
		current_speed = SPEED_LASER
		current_maximum_projectile_range = MAX_RANGE_LASER
