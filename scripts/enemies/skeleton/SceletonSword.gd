class_name SceletonSword

extends Area3D

@export var do_atc : bool = false
@export var sword_speed : float
@export var attack_timer : Timer
var left_to_right : bool = false

func _process(delta: float) -> void:
	if do_atc:
			if left_to_right:
				rotate_y(-sword_speed*delta)
			else:
				rotate_y(sword_speed*delta)
			
			if rotation_degrees.y <= -150:
				left_to_right = false
			elif rotation_degrees.y >= 10:
				left_to_right = true
