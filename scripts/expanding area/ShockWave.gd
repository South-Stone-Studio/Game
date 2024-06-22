class_name ShockWave

extends Area3D
@export var colider: CollisionShape3D
@export var mesh: MeshInstance3D 
var width: float = 0.5
var current_radius: float = 0.5
var max_radius: float
var speed: float = 5

func _ready():
		mesh.mesh.inner_radius = current_radius - width + 0.001
		mesh.mesh.outer_radius = current_radius
		
func _physics_process(delta):
	if current_radius < max_radius:
		current_radius += delta * speed
		mesh.mesh.inner_radius = current_radius - width
		mesh.mesh.outer_radius = current_radius
		colider.shape.radius = current_radius
	else:
		self.queue_free()

func _on_body_entered(body):
	if is_instance_of(body, PlayerMovement):
		var dist: float = self.global_position.distance_to(body.global_position)
		if dist > current_radius - width*2:
			print("Player hit!")
