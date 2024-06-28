class_name  SceletonBone

extends Node3D

@export var bone_scene : PackedScene
@onready var main_node : CharacterBody3D = get_parent()
@export var bone_demage_to_enemy : int 
@export var do_atc : bool = false
@export var attack_timer : Timer
var bone_ready : bool = false

func _process(delta: float) -> void:
	if do_atc and bone_ready and main_node.current_hp > 10:
		spawn_bone()

func spawn_bone():
	var bone : RigidBody3D = bone_scene.instantiate()
	get_parent().add_child(bone)
	main_node.handle_demage(bone_demage_to_enemy)
	bone_ready = false
	print("bone")

func _on_attack_timer_timeout() -> void:
	bone_ready = true
