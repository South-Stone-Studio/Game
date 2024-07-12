class_name SceletonSword

extends Area3D

signal player_in_sword	# i don't have better name xD

@onready var main_node : CharacterBody3D = get_parent()
@export var do_atc : bool = false
var left_to_right : bool = false
@export var timer : float 
var old_timer : float 

func _ready() -> void:
	old_timer = timer

func _process(delta: float) -> void:
	print(do_atc)
	if do_atc:
		timer -= delta
		if timer <= 0:
			do_atc = false
			timer = old_timer
		else:
			if left_to_right:
				rotate_y(-main_node.attack_speed*delta)
			else:
				rotate_y(main_node.attack_speed*delta)
					
			if rotation_degrees.y <= -150:
				left_to_right = false
				do_atc = false
			elif rotation_degrees.y >= 10:
				left_to_right = true
				do_atc = false

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("Player hit sword")
		player_in_sword.emit()
