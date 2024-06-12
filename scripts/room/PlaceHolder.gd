class_name PlaceHolder

extends Node3D

enum size{small, medium, big}
@export var size_of_object: size

func replace(obj: Node3D) -> Node3D:
	var o = obj.duplicate()
	o.global_position = self.global_position
	return o

func delete():
	self.queue_free()
