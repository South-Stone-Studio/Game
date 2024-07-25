class_name InventorySlot

extends Control

@export var slot_details : Panel
@export var slot_usage : Panel

@export_category("Slot Info Nodes")
@export var slot_name : Label
@export var slot_type : Label
@export var slot_quantity : Label
@export var slot_sprite : Sprite2D

var slot_item : Item = null

func _on_button_mouse_exited() -> void:
	if slot_item != null:
		slot_details.visible = false

func _on_button_mouse_entered() -> void:
	if slot_item != null:
		slot_details.visible = true
		slot_usage.visible = false

func _on_button_pressed() -> void:
	if slot_item != null:
		slot_usage.visible = !slot_usage.visible

#set empty slot
func set_empty() -> void:
	slot_sprite.texture = null
	slot_name.text = ""
	slot_type.text = ""
	slot_quantity.text = ""
	slot_item = null

#set slot with item
func set_item(new_item : Item) -> void:
	slot_sprite.texture = new_item.item_sprite
	slot_name.text = str(new_item.item_name)
	slot_type.text = str(new_item.item_type)
	slot_quantity.text = str(new_item.item_quantity)
	slot_item = new_item

func _on_drop_button_pressed() -> void:
	#if Global.player.inventory.drop_item(slot_item): # call inventory to drop item
		print(slot_item.item_scene)
		print("Droped")
	

func _on_use_button_pressed() -> void:
	get_parent().use_item(slot_item)
