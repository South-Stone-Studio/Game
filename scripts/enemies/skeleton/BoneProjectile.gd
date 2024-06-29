extends RigidBody3D

@export var speed : float
@export var demage : int
@export var heal : int
@export var time : float = 100

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
	
