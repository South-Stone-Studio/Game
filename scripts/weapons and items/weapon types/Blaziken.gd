class_name Blaziken

extends IWeapon

var primary_active = false
var cur_ammo: Callable
@export var bullet_scene: PackedScene
@export var nozle: Node3D
var bullet_node: Bullet
var can_shoot = true
# SMG Vibes
func _ready():
	timer.one_shot = true
	timer.wait_time = time_between_shoots
	timer.timeout.connect(_timeout)
	bullet_node = bullet_scene.instantiate()

func primary():
	if !can_shoot:
		return
	can_shoot = false
	timer.start()
	pass

func shoot():
	if cur_ammo.call():
		var _bullet: Bullet = bullet_node.duplicate()
		get_tree().current_scene.add_child(_bullet)
		_bullet.global_position = nozle.global_position
		_bullet.global_transform.basis = nozle.global_transform.basis
		_bullet.damage_value = damage_value
		_bullet.v = bullet_velocity

func _timeout() -> void:
	can_shoot = true
