class_name Player

extends CharacterBody3D

signal death

@export_category("Stats")
@export var hp : int = 30
var current_hp : int :
	set(value):
		if value <= 0: death.emit()
		current_hp = max(0 ,min(value,hp))
@export var speed : float

func _ready() -> void:
	death.connect(handle_death)
	current_hp = hp

func _process(delta: float) -> void:
	pass

func handle_death() -> void:
	print("you died")
	self.queue_free()

func handle_demage(dem : int) -> void:
	current_hp -= dem
