class_name Tile

extends Node3D

@export var objects: Array[PlaceHolder]
@export var max_objects: int
@export var min_objects: int

func create(x: float, y: float) -> void:
	self.global_position = Vector3(x, 0, y)
	var num := randi_range(min_objects, max_objects)
	for val in range(num):
		var rand = randi_range(0, len(objects)-1)
		var target: PlaceHolder = objects[rand]
		match target.size_of_object:
			PlaceHolder.size.small:
				var m := randi_range(0, len(Global.small_placable)-1)
				target.replace(Global.small_placable[m].instantiate())
			PlaceHolder.size.medium:
				var m := randi_range(0, len(Global.medium_placable)-1)
				target.replace(Global.medium_placable[m].instantiate())
			PlaceHolder.size.large:
				var m := randi_range(0, len(Global.large_placable)-1)
				target.replace(Global.large_placable[m].instantiate())
		objects.erase(target)
		target.delete()
	for val in objects:
		val.delete()
	objects.clear()
