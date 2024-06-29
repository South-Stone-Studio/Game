class_name  SceletonBone

extends Node3D

@export var bone_scene : PackedScene
@onready var main_node : CharacterBody3D = get_parent()
var demage : int
var heal : int
var enemy_demage : int
var speed : float
@export var do_atc : bool = false
@export var attack_timer : Timer
var bone_ready : bool = false

func _process(delta: float) -> void:
	if do_atc and bone_ready and main_node.current_hp > 10:
		spawn_bone()

func spawn_bone():
	var bone : RigidBody3D = bone_scene.instantiate()
	bone.demage = demage
	bone.heal = heal
	bone.enemy_demage = enemy_demage
	bone.speed = speed
	add_child(bone)
	main_node.handle_demage(enemy_demage)
	bone_ready = false

func _on_attack_timer_timeout() -> void:
	bone_ready = true
