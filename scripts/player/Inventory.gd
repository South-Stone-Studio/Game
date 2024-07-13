extends Node

@export var opened : bool = false

func _process(delta: float) -> void:
	on_off_window()
	

func on_off_window()->void:
	if Input.is_action_just_pressed("inventory"):
		self.visible = !self.visible
		opened = !opened
