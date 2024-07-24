class_name Item

extends RigidBody3D

enum types_of_items {resource,weapon,consumable,armor}
var name_of_type := ["Resource", "Weapon", "Consumable", "Armor"]

@export var item_type : types_of_items
@export var item_name : String
@export var item_sprite : Texture2D
@export var item_quantity : int = 1
@export var item_scene : PackedScene

func pick_up_item() -> void:
	#send copy to inventory manager
	if Global.player:
		Global.player.inventory.add_item(self)
		self.queue_free()
