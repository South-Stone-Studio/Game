class_name Room_Generator

extends Node3D
@export var root: Node3D

@export var start: PackedScene 
@export var normal: PackedScene
@export var boss: PackedScene
var loaded_scene: Node3D
func _ready():
	pass

func create_room(type:room.room_types):
	match type:
		room.room_types.start:
			instantiate_room(start)
		room.room_types.normal:
			instantiate_room(normal)
		room.room_types.boss:
			instantiate_room(boss)

func instantiate_room(r: PackedScene):
	loaded_scene = r.instantiate()
	root.add_child(loaded_scene)

func get_ref():
	return loaded_scene

func delete_room():
	loaded_scene.free()
