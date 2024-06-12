class_name Tile

extends Node3D

@export var objects: Array[PlaceHolder]
@export var max_objects: int
@export var min_objects: int
@export var default_object: PackedScene

func create(x: float, y: float) -> void:
	print("Game")
	self.global_position = Vector3(x, 0, y)
	var num := randi_range(min_objects, max_objects)
	for val in range(num):
		var rand = randi_range(0, len(objects)-1)
		var target: PlaceHolder = objects[rand]
		target.replace(default_object.instantiate())
		objects.erase(target)
		target.delete()
	for val in objects:
		val.delete()
	objects.clear()
