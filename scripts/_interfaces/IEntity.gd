class_name IEntity

extends Node3D


var health: int
@export var max_health: int

func take_damage(_dmg: damage) -> void:
	pass

func recive_heal(_val: int) -> void:
	pass
