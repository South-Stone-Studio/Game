class_name Map

extends Node2D

var current_node: MapElement: set = _change_current
@export var element_scene: PackedScene
var center_of_gravity: Vector2
func _ready() -> void:
	center_of_gravity = get_viewport_rect().size * Vector2(0.5, 0.5)
	if Global.map == null:
		Global.map = self
	else:
		self.queue_free()

func _change_current(element: MapElement):
	current_node = element
	if element.type == element.point_type.not_visited and !element.connection_added:
		element.connection_added = true
		var counter := 0
		for con in element.graph_node.connections:
			if con.added_to_map:
				continue
			var a := add_to_map(con)
			a.global_position = element.global_position + Vector2(randf_range(-1,1), randf_range(-1,1))
			counter += 1

func add_to_map(node: Gnode) -> MapElement:
	node.added_to_map = true
	var element: MapElement = element_scene.instantiate()
	element.graph_node = node
	self.add_child(element)
	if current_node == null:
		return element
	var connection: MapConnection = MapConnection.new(current_node, element)
	self.add_child(connection)
	return element


func init_map(node: Gnode) -> void:
	var a := add_to_map(node)
	a.global_position = center_of_gravity
	a.mass = 5
	current_node = a

func travel(element: MapElement, type: MapElement.point_type) -> bool:
	current_node.type = type
	current_node.current = false
	current_node = element
	Global.run_script.change_room(element.graph_node)
	return true
