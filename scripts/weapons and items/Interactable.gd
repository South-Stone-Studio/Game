class_name Interactable

extends CharacterBody3D

signal interact
var priority: bool = false
var highlighted: bool
func _mouse_enter() -> void:
	priority = true

func _mouse_exit() -> void:
	priority = false

func highlight() -> void:
	print("highlight")
	highlighted = true
	
func lowlight()->void:
	print("lowlight")
	highlighted = false
