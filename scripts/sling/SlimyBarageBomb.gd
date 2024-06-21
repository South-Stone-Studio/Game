class_name SlimyBarageBomb

extends Area3D

@export var collider: CollisionShape3D
@export var mesh_instance: MeshInstance3D
var delay: float
func _ready():
	mesh_instance.mesh.material.albedo_color = Color("blue")


func _process(delta):
	if delay > 0:
		delay -= delta
	else:
		mesh_instance.mesh.material.albedo_color = Color("red")
		for i in get_overlapping_bodies():
			if is_instance_of(i, PlayerMovement):
				print("Hit")
				break
		self.queue_free()
