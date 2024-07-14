class_name PlayerCamera

extends Camera3D

@export var target : = Node3D
@export var offset := Vector3()
var rayOrigin := Vector3.ZERO
var rayEnd := Vector3.ZERO

func get_intersection() -> Dictionary:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	rayOrigin = self.project_ray_origin(mouse_position)
	var ray_normal:= self.project_ray_normal(mouse_position)
	ray_normal = ray_normal.limit_length(1)
	rayEnd = rayOrigin + ray_normal * 2000

	position = target.position + Vector3(offset.x,0,offset.z)
	position += ray_normal*4
	position.y = offset.y
	
	var ray_parameters: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd)
	
	return space_state.intersect_ray(ray_parameters)
