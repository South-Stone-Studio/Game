extends Control

@export var grid_container : GridContainer
@export var slot_scene : PackedScene

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

func remove_item(item : Item) -> void:
	inv_update()

func increse_inv_size(size : int) -> void:
	inv_update()

func _ready() -> void:
	Global.inventory.resize(12)
	inv_update()

func _process(delta: float) -> void:
	on_off_window()

func on_off_window()->void:
	if Input.is_action_just_pressed("inventory"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused

func inv_update() -> void:
	clear_grid_container()
	for item in Global.inventory:
		var slot : InventorySlot = slot_scene.instantiate()
		grid_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()
		
	print(Global.inventory)

func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
