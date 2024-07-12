class_name Bullet

extends Area3D
enum who{enemy, player}
var v: float
var damage: int
@export var deal_damage_to: who = who.enemy
var exception: Array[Node3D] = []

func _physics_process(delta):
	translate(Vector3(0, 0, v * delta))

func _on_body_entered(body):
	print("hit: " + body.name)
	if body in exception or is_instance_of(body, Bullet):
		return
	match deal_damage_to:
		who.enemy:
			if is_instance_of(body, Boss):
				body.health -= damage
		who.player:
			if is_instance_of(body, PlayerMovement):
				pass
	self.queue_free()
