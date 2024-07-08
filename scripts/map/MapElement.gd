class_name MapElement

extends RigidBody2D

enum point_type {not_visited, visited, shop, boss, treassure}
var graph_node: Gnode
var connection_added: bool = false
var type: point_type = point_type.not_visited
var mouse_hovered: bool = false
var current: bool = false:
	set(val):
		current = val
		def.visible = !val
		cur.visible = val
@export var def: MeshInstance2D
@export var cur: MeshInstance2D 
func _process(_delta: float) -> void:
	if mouse_hovered and Input.is_action_just_pressed("attack"):
		print("work")
		Global.map.visible = false
		Global.map.travel(self, self.type)

func _on_mouse_entered() -> void:
	mouse_hovered = true

func _on_mouse_exited() -> void:
	mouse_hovered = false
