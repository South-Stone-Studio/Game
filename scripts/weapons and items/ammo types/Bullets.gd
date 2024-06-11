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
	if is_reload:
		time_to_reload = reload_time
		return
	if mags > 0:
		mags -= 1
		time_to_reload = reload_time
		is_reload = true
	else:
		print("no mags")

func reloaded():
	print("reloaded")
	is_reload = false
	current = capacity
	print(current)

func _process(delta):
	if time_to_reload > 0:
		time_to_reload -= delta
	elif is_reload:
		reloaded()

func can_shoot():
	if current <= 0:
		reload()
		return false
	else:
		current -= 1
		return true
