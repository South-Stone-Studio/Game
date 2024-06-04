extends Node

enum type {none, sample_gun}
var weapon := type.none

@export var arm_point := Vector3()
@onready var hand : Node3D = $"../../Hand"

func pick_up_item(object:Node3D):
	object.get_parent().remove_child(object)
	object.disable_mode = 0
	object.disable_colision()
	object.freeze = true
	object.picked = true
	object.position = arm_point
	hand.add_child(object)
	object.rotation = Vector3(hand.rotation.x, 0,hand.rotation.z)
	if "SampleGun" in object.name:
		weapon = type.sample_gun

func drop_item():
	var object :Node3D = hand.get_child(0)
	if object != null:
		hand.remove_child(object)
		object.disable_mode = 1
		object.disable_colision()
		object.freeze = false
		object.picked = false
		object.position = get_parent().get_parent().position + Vector3(0,-0.5,1.5)
		weapon = type.none
		get_tree().get_current_scene().add_child(object)
