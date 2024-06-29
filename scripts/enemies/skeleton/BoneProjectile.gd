extends RigidBody3D

var speed : float
var demage : int
var enemy_demage : int
var heal : int
var time : float

func _physics_process(delta: float) -> void:
	if time > 0:
		translate(Vector3(0,0,-speed*delta))
		time -= 1

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.handle_demage(demage)
		self.queue_free()
	elif "Enemy" in body.name:
		body.handle_heal(heal)
		self.queue_free()
	
