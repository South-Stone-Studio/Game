class_name MapConnection

extends Line2D

var point_a: Node2D
var point_b: Node2D

func _init(a: Node2D,b: Node2D) -> void:
	point_a = a
	point_b = b
	self.width = 5
	self.add_point(a.global_position)
	self.add_point(b.global_position)

func _process(delta: float) -> void:
	self.points[0] = point_a.global_position
	self.points[1] = point_b.global_position
