class_name SceletonSword

extends Area3D

signal player_in_sword	# i don't have better name xD

@onready var main_node : CharacterBody3D = get_parent()
@export var do_atc : bool = false
var left_to_right : bool = false

func _process(delta: float) -> void:
	if do_atc:
			if left_to_right:
				rotate_y(-main_node.attack_speed*delta)
			else:
				rotate_y(main_node.attack_speed*delta)
			
			if rotation_degrees.y <= -150:
				left_to_right = false
			elif rotation_degrees.y >= 10:
				left_to_right = true

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_in_sword.emit()
