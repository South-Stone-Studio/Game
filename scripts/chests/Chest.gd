class_name Chest

extends Interactable

var weapon_list := Global.base_weapons
var preaper: bool = true
var weapon: IWeapon
@export var point: Node3D

func _on_interact() -> void:
	print("choose your weapon!")
