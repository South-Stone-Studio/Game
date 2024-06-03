extends Node3D
@onready var bullet := preload("res://component_scene/weapons/sample_gun/bullet.tscn")
@export var picked : bool = false
@onready var AimPoint : Marker3D = $AimPoint
@onready var Color_Mesh := $CollisionShape3D/MeshInstance3D/MeshInstance3D

func disable_colision():
	$CollisionShape3D.disabled = !$CollisionShape3D.disabled

func _input(event):
	if Input.is_action_just_pressed("attack") and picked:
		var projectile = bullet.instantiate()
		AimPoint.add_child(projectile)

# GLOWING ON MOUSE ENTER #
func _on_mouse_entered():
	if not picked:
		Color_Mesh.visible = true
		
func _on_mouse_exited():
	Color_Mesh.visible = false
