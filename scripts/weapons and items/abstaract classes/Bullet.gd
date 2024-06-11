class_name Bullet

extends Area3D

var v: float
var damage: int
func _physics_process(delta):
	translate(Vector3(0, 0, v * delta))

func _on_body_entered(body):
	print("hit: " + body.name)
	self.queue_free()
