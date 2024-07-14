class_name Item

extends RigidBody3D

enum types_of_items {resource,weapon,consumable,armor}

@export var item_type : types_of_items
@export var item_name : String
@export var item_sprite : Sprite2D

func pick_up_item() -> void:
	var item = {
		"quantity" : 1,
		"item_type" : item_type,
		"item_name" : item_name,
		"item_scene" : self,
		"item_sprite" : item_sprite
	}
	
	if Global.player:
		Global.player.inventory.add_item(item)
		self.queue_free()
