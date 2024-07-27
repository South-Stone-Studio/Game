class_name Needler

extends IWeapon
var orbs: Array[BulletBomb] = []
@export var nozle: Node3D
@export var bullet_scene: PackedScene
@export var explosion_damage: int 

var bullet: Node3D
func _ready():
	timer.wait_time = time_between_shoots
	timer
	bullet = bullet_scene.instantiate()

	
func primary() -> void:
	pass

func alternative() -> void:
	pass
	
func shoot():
	var _bullet: Node3D = bullet.duplicate()
	get_tree().current_scene.add_child(_bullet)
	_bullet.global_position = nozle.global_position
	_bullet.global_basis = nozle.global_basis
	_bullet.v = bullet_velocity
	_bullet.damage = damage
	_bullet.exp_damage = explosion_damage
	orbs.append(_bullet)

func explosion():
	for orb: BulletBomb in orbs:
		orb.explode()
	orbs.clear()
	
