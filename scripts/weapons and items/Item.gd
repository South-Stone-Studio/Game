class_name Item

extends RigidBody3D

enum types_of_items {resource,weapon,consumable,armor}

@export var item_type : types_of_items
@export var item_name : String
@export var item_sprite : Texture
@export var item_quantity : int = 1
@export var item_scene : RigidBody3D = self

func pick_up_item() -> void:
	# create copy of that item
	var to_inv_item = Item.new()
	to_inv_item.item_quantity = item_quantity
	to_inv_item.item_type = item_type
	to_inv_item.item_name = item_name
	to_inv_item.item_scene = item_scene
	to_inv_item.item_sprite = item_sprite
	
	#send copy to inventory manager
	if Global.player:
		Global.player.inventory.add_item(to_inv_item)
		self.queue_free()
