class_name IWeapon

extends Node

signal on_shot
signal on_reload
signal on_hit
signal on_alternative


@export var time_between_shoots: float
@export var bullet_velocity: float
@export var damage: int
@export var ammo: IAmmo
var timer: Timer # to time between shots

func primary() -> void:
	# if holding wait for time then shoot when time is right
	pass

func alternative() -> void:
	pass

func reload() -> void:
	#reload cant be interupted
	pass
