class_name SceletonSword

extends Area3D

@export var do_atc : bool = false
@export var sword_speed : float
@export var attack_timer : Timer

func _process(delta: float) -> void:
	if do_atc:
		rotate_y(-150)
	else:
		pass

