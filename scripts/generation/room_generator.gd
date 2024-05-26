class_name Room_Generator

extends Node3D
@export var root: Node3D

@export var start: PackedScene 
@export var normal: PackedScene
@export var boos: PackedScene
func _ready():
	pass

func create_room(type:room.room_types):
	match type:
		room.room_types.start:
			pass
