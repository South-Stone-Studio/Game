extends Control

@export var slot_details : Panel
@export var slot_usage : Panel

@export_category("Slot Info Nodes")
@export var slot_name : Label
@export var slot_type : Label
@export var slot_quantity : Label
@export var slot_sprite : Sprite2D

var item : Item = null

func set_empty() -> void:
	slot_sprite.texture = null
	slot_quantity.text = ""

func set_item(item : Item) -> void:
	slot_sprite.texture = item.item_sprite
	slot_name.text = item.item_name
	slot_type.text = item.item_type
	slot_quantity.text = item.item_quantity

func _on_button_mouse_exited() -> void:
	#if item != null:
		item_details.visible = false

func _on_button_mouse_entered() -> void:
	#if item != null:
		item_details.visible = true
		item_usage.visible = false

func _on_button_pressed() -> void:
	#if item != null:
		item_usage.visible = !item_usage.visible
