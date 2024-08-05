class_name IMovement

extends CharacterBody3D

signal on_jump
signal on_land
signal on_movement_start
signal on_movement_stop

@export var speed: float

func move(_delta: float, _position: Vector3) -> void:
	pass
	
func jump() -> void:
	pass

func stand(_delta: float) -> void:
	pass
