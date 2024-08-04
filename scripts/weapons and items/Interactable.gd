class_name Interactable

extends CharacterBody3D

signal interact
var priority: bool = false
var highlighted: bool
@export var locked: bool
@export var mat: ShaderMaterial
@export var interactive_mesh: MeshInstance3D

func _ready() -> void:
	mat = interactive_mesh.mesh.material.next_pass
	
func _mouse_enter() -> void:
	priority = true

func _mouse_exit() -> void:
	priority = false

func highlight() -> void:
	highlighted = true
	mat.set_shader_parameter("enabled", true)
	
func lowlight()->void:
	highlighted = false
	mat.set_shader_parameter("enabled", false)
