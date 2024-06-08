class_name Bullets

extends Ammo

var current: int
@export var mags: int
@export var reload_time: float
var time_to_reload: float
var is_reload: bool

func _ready():
	relodable = true
	current = capacity

func reload():
	if mags > 0:
		mags -= 1
		capacity = 0
		time_to_reload = reload_time
		is_reload = true

func reloaded():
	is_reload = false
	current = capacity

func _process(delta):
	if time_to_reload > 0:
		time_to_reload -= delta
	elif is_reload:
		reloaded()

func can_shoot():
	return current > 0
