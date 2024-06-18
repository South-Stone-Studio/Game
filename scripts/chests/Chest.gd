class_name Chest

extends Node3D

var weapon_list := Global.base_weapons
var preaper: bool = true
var weapon: Weapon
@export var point: Node3D
func _ready():
	weapon = weapon_list[randi_range(0, len(weapon_list)-1)].instantiate()
	self.add_child(weapon)
	weapon.global_position = point.global_position
