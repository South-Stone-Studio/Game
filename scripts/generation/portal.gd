class_name Portal

extends Node3D

@export var num: int
@export var mesh: MeshInstance3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		call_deferred('change',num)

func change(n):
	Global.run_script.changeRoom(n)
	
