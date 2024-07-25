class_name Item

extends RigidBody3D

enum types_of_items {resource,weapon,consumable,armor}
var name_of_type := ["Resource", "Weapon", "Consumable", "Armor"]

@export var item_type : types_of_items
@export var item_name : String
@export var item_sprite : Texture2D
@export var item_quantity : int = 1
@export var packed_item : PackedScene

func pick_up_item() -> void:
	#set copy of item
	var copy : Item = Item.new()
	copy.item_type = item_type
	copy.item_name = item_name
	copy.item_sprite = item_sprite
	copy.item_quantity = item_quantity
	copy.packed_item = packed_item

	if Global.player:
		#send copy to inventory and delete node of item
		print(packed_item)
		Global.player.inventory.add_item(copy)
		self.queue_free()
