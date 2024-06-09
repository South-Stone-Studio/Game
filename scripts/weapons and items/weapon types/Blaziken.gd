class_name Blaziken

extends BaseWeapon

var primary_active = false
var cur_ammo: Callable
@export var bullet_scene: PackedScene
@export var nozle: Node3D
var bullet_node: Bullet

# SMG Vibes
func _ready():
	bullet_node = bullet_scene.instantiate()

func primary(can: Callable, start: bool = true):
	cur_ammo = can
	primary_active = start

func shoot():
	if cur_ammo.call():
		var _bullet: Bullet = bullet_node.duplicate()
		get_tree().current_scene.add_child(_bullet)
		_bullet.global_position = nozle.global_position
		_bullet.global_transform.basis = nozle.global_transform.basis
		_bullet.damage = damage
		_bullet.v = bullet_velocity

func _process(delta):
	if cur > 0:
		cur -= delta
	elif primary_active:
		shoot()
		cur = time_between_shoots
