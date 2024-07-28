class_name InputComponent

extends Node

# movement inputs
signal move

# interaction input
signal interaction

# attack input
signal attack

func _process(delta: float) -> void:
	if Input != null:
		if Input.is_action_just_pressed("attack"):  #attack
			attack.emit()

		# movement
		if Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"): 
			move.emit()

		if Input.is_action_just_pressed("interact"):  #interaction
			interaction.emit()
