class_name IMovement

extends CharacterBody3D

signal on_jump
signal on_land
signal on_movement_start
signal on_movement_stop

var current_speed_cap: float
@export var base_speed_cap: float

func move() -> void:
	pass
	
func jump() -> void:
	pass
