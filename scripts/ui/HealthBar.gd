class_name HealthBar

extends ProgressBar

var health: float : set = _set_health
var damaged: float
var is_timeout: bool = true
@export var timer: Timer
@export var damage_bar: ProgressBar

func _set_health(val: float):
	var prev := health
	health = min(100, max(val, 0))
	update_health_bar()

func update_health_bar() -> void:
	is_timeout = false
	timer.start()
	self.value = health

func _ready() -> void:
	health = 100
	damaged = health

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		health -= 10
	if is_timeout:
		if damaged > health:
			damaged = move_toward(damaged, health, 2)
	damage_bar.value = damaged

func _on_timer_timeout() -> void:
	is_timeout = true