class_name Boss

extends CharacterBody3D

@export var boss_health_bar: HealthBar
@export var label: Label
@export_range(1,1000) var max_health: int
@export var boss_tiles: Array[PackedScene]
@export var boss_name: String
var health: int: set = _set_health

func _ready() -> void:
	health = max_health
	label.text = boss_name
	
func _set_health(val):
	health = min(max_health,max(0, val))
	boss_health_bar.health = (health * 100) / max_health
	print((health / max_health) * 100)
	if health == 0:
		self.queue_free()
