class_name Portal

extends Interactable



func _on_interact() -> void:
	Global.map.visible = !Global.map.visible
