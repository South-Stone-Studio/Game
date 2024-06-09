class_name BulletBomb

extends Bullet
@export var explosion: PackedScene
var exp_damage: int = 0

func _on_body_entered(body):
	v = 0

func explode():
	var expl: Explosion = explosion.instantiate()
	expl.damage = exp_damage
	get_tree().current_scene.add_child(expl)
	expl.global_position = self.global_position
	self.queue_free()
