class_name BaseWeapon

extends Node

@export_range(0,1000) var time_between_shoots: float
@export var damage: int 
@export_range(0,1000) var bullet_velocity: float
var cur: float = 0

@warning_ignore("unused_parameter")
func primary(can: Callable, start: bool = true):
	pass
	
func alternative():
	pass

@warning_ignore("unused_parameter")
func acuracy(val: float):
	pass

func _process(delta):
	if cur > 0:
		cur -= delta

func set_time_between_shot(val: float):
	cur = val
	
