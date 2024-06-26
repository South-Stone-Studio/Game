class_name HandController

extends Node

var weapon : Weapon

@export var arm_point := Vector3()
@export var hand : Node3D

func pick_up_item(object:Node3D):
	if weapon != null:
		drop_item()
	if is_instance_of(object, Weapon):
		object.picked = true
		weapon = object
		object.reparent(hand)
		object.disable_mode = CollisionObject3D.DISABLE_MODE_REMOVE
		object.disable_colision()
		object.freeze = true
		object.picked = true
		object.position = arm_point
		object.rotation = Vector3(hand.rotation.x, 0,hand.rotation.z)

func drop_item():
	var object := weapon
	if object != null:
		object.disable_mode = CollisionObject3D.DISABLE_MODE_MAKE_STATIC
		object.disable_colision()
		object.freeze = false
		object.picked = false
		object.position = hand.position + Vector3(0,-0.5,1.5)
		object.reparent(get_tree().current_scene)
		weapon = null
