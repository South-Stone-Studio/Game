class_name PlaceHolder

extends Node3D

enum size{small, medium, large}
@export var size_of_object: size

func replace(obj: Node3D) -> void:
	var o = obj.duplicate()
	self.get_parent().add_child(o)
	o.global_position = self.global_position
	self.queue_free()

func delete() -> void:
	self.queue_free()
