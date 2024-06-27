class_name SceletonVision

extends Node3D

signal player_seen

@export var raycasts : Array[RayCast3D]

func _process(delta: float) -> void:
	for ray in raycasts:
		ray.force_raycast_update()
		if ray.is_colliding():
			if ray.get_collider().name == "Player":
				player_seen.emit()
				
