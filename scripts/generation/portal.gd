class_name Portal

extends Node3D

signal changeRoom
@export var num: int
var mat: StandardMaterial3D = null

func _ready():
	mat = $Area3D/CollisionShape3D/MeshInstance3D.get('surface_material_override/0').duplicate()
	$Area3D/CollisionShape3D/MeshInstance3D.set('surface_material_override/0', mat)
	
func _on_area_3d_body_entered(body: Node3D):
	if body.name == "Player":
		changeRoom.emit(num)

func disablem():
	mat.albedo_color = Color.CRIMSON
	pass
func activate():
	mat.albedo_color = Color.SKY_BLUE
	pass
