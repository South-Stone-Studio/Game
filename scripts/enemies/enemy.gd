class_name Enemy

extends CharacterBody3D

signal death

@export_category("Stats")
@export var touch_demage : int
@export var hp : int  = 25
var health : int :
	set(value):
		if value <= 0: death.emit()
		health = max(0 ,min(value,hp))
@export var speed : float

func _ready() -> void:
	death.connect(handle_death)
	health = hp

func _process(delta: float) -> void:
	pass

func handle_death() -> void:
	self.queue_free()

func handle_heal(heal_value : int) -> void:
	health += heal_value
