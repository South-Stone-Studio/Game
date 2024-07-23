class_name Item

extends RigidBody3D

enum types_of_items {resource,weapon,consumable,armor}
var name_of_type := ["Resource", "Weapon", "Consumable", "Armor"]

@export var item_type : types_of_items
@export var item_name : String
@export var item_sprite : Texture2D
@export var item_quantity : int = 1
@export var item_scene : Item = self

func pick_up_item() -> void:
	# create copy of that item
	var to_inv_item = Item.new()
	to_inv_item.item_quantity = item_quantity
	to_inv_item.item_type = str(name_of_type[item_type])
	to_inv_item.item_name = item_name
	to_inv_item.item_scene = item_scene
	to_inv_item.item_sprite = item_sprite
	
	#send copy to inventory manager
	if Global.player:
		Global.player.inventory.add_item(to_inv_item)
		self.queue_free()
