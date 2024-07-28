extends Control

@export var grid_container : GridContainer
@export_category("grid settings")
@export var quantity_of_slots : int
@export var slot_scene : PackedScene

func _ready() -> void:
	Global.inventory.resize(quantity_of_slots)
	inv_update()

func _process(delta: float) -> void:
	on_off_window()

func add_item(item : Item) -> bool :
	for i in range(Global.inventory.size()):
		if Global.inventory[i] != null and Global.inventory[i].item_type == item.item_type and Global.inventory[i].item_name == item.item_name:
			Global.inventory[i].item_quantity += item.item_quantity
			inv_update()
			return true
		elif Global.inventory[i] == null:
			Global.inventory[i] = item
			inv_update()
			return true
	return false

func use_item(item : Item) -> void:
	pass

func drop_item(item : Item) -> bool:
	for i in range(Global.inventory.size()):
		if Global.inventory[i] != null and Global.inventory[i].item_type == item.item_type and Global.inventory[i].item_name == item.item_name:
			var item_node : Item = item.item_scene.instantiate()
			item_node.reparent(Global.current_room_root)
			Global.inventory[i].item_quantity -= 1
			if Global.inventory[i].item_quantity == 0:
				Global.inventory[i] = null
			return true
	return false
	inv_update()

func increse_inv_size(size : int) -> void:
	Global.inventory.resize(len(Global.inventory)+size)
	inv_update()

func on_off_window()->void:						#Freeze time to inv
	if Input.is_action_just_pressed("inventory"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused

func inv_update() -> void:
	clear_grid_container()
	for item in Global.inventory:
		var slot : InventorySlot = slot_scene.instantiate()
		grid_container.add_child(slot)
		if item != null:
			slot.slot_item = Item.new()
			slot.set_item(item)
		else:
			slot.set_empty()
		

func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
