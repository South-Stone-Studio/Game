class_name MapElement

extends Node2D

enum point_type {not_visited, visited, shop, boss, treassure}
var graph_node: Gnode
var connection_added: bool = false
var type: point_type = point_type.not_visited

@export var rig: RigidBody2D
var mouse_hovered: bool = false
var current: bool = false

func _process(delta: float) -> void:
	if mouse_hovered and Input.is_action_just_pressed("attack"):
		current = Global.map.travel(self, self.type)
	self.position

func _on_rigid_body_2d_mouse_entered() -> void:
	mouse_hovered = true

func _on_rigid_body_2d_mouse_exited() -> void:
	mouse_hovered = false
