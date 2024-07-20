class_name InventorySlot

extends Control

@export var slot_details : Panel
@export var slot_usage : Panel

@export_category("Slot Info Nodes")
@export var slot_name : Label
@export var slot_type : Label
@export var slot_quantity : Label
@export var slot_sprite : Sprite2D

var item : Item = null

func _on_button_mouse_exited() -> void:
	if item != null:
		slot_details.visible = false

func _on_button_mouse_entered() -> void:
	if item != null:
		slot_details.visible = true
		slot_usage.visible = false

func _on_button_pressed() -> void:
	if item != null:
		slot_usage.visible = !slot_usage.visible

func set_empty() -> void:
	slot_sprite.texture = null
	slot_name.text = ""
	slot_type.text = ""
	slot_quantity.text = ""
	item = null

func set_item(new_item : Item) -> void:
	slot_sprite.texture = new_item.item_sprite
	slot_name.text = str(new_item.item_name)
	slot_type.text = str(new_item.item_type)
	slot_quantity.text = str(new_item.item_quantity)
	item = new_item
