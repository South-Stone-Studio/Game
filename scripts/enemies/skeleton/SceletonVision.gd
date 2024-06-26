class_name SceletonVision

extends Node

signal player_seen

@export var raycasts : Array[RayCast3D]

func _process(delta: float) -> void:
	for ray in raycasts:
		ray.force_raycast_update()
		if ray.is_colliding():
			var obj : Object = ray.get_collider()
			if obj.name == "Player":
				print("player_seen")
