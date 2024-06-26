class_name Explosion

extends Area3D

var damage: int
@export var col: CollisionShape3D
@export var mes: MeshInstance3D
@export var max_radius: float = 5
var expansion_speed: float = 20
var current_radius: float = 0.01

func _process(delta):
	if current_radius < max_radius:
		current_radius += delta * expansion_speed
		var c: SphereShape3D = col.shape
		c.radius = current_radius
		mes.mesh.radius = current_radius
		mes.mesh.height = current_radius * 2
	else:
		self.queue_free()
		
func _on_body_entered(body):
	if is_instance_of(body, Boss):
		body.health -= 25
	print(body)
