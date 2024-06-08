class_name HandController

extends Node

var weapon : Weapon

@export var arm_point := Vector3()
@export var hand : Node3D

func pick_up_item(object:Node3D):
	if is_instance_of(object, Weapon):
		object.picked = true
		weapon = object
		object.reparent(hand)
		object.disable_mode = 0
		object.disable_colision()
		object.freeze = true
		object.picked = true
		object.position = arm_point
		object.rotation = Vector3(hand.rotation.x, 0,hand.rotation.z)

func drop_item():
	var object := weapon
	if object != null:
		object.disable_mode = 1
		object.disable_colision()
		object.freeze = false
		object.picked = false
		object.position = get_parent().get_parent().position + Vector3(0,-0.5,1.5)
		object.reparent(get_tree().current_scene)
		weapon = null
