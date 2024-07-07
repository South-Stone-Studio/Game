class_name Portal

extends Node3D

@export var mesh: MeshInstance3D
var player_colliding: bool = false
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_colliding = true

func _process(_delta: float) -> void:
	if player_colliding and Input.is_action_just_pressed("pick_up"):
		Global.map.visible = !Global.map.visible

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_colliding = false
		Global.map.visible = false
