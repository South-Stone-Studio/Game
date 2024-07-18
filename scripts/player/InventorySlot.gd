extends Control

@export var item_details : Panel
@export var item_usage : Panel
@export var item_name : Label
@export var item_type : Label
@export var item_quantity : Label
@export var item_sprite : Sprite2D

var item : Item = null

func _on_button_mouse_exited() -> void:
	if item != null:
		if item_details.visible :  item_details.visible = !item_details.visible
		if item_usage.visible: item_usage.visible = !item_usage.visible

func _on_button_mouse_entered() -> void:
	if item != null:
		item_details.visible = !item_details.visible
		if item_usage.visible: item_usage.visible = !item_usage.visible

func _on_button_pressed() -> void:
	if item != null:
		item_details.visible = !item_details.visible
		item_usage.visible = !item_usage.visible
