extends RigidBody3D

@export var speed : float
@export var rotation_speed : float
@export var demage : int
@export var heal : int

func _physics_process(delta : float) -> void:
	translate(Vector3(0, 0, -speed * delta))

func _on_bone_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		body.handle_demage(demage)
		self.queue_free()
	elif "Enemy" in body.name:
		body.handle_heal(heal)
	

func _on_timer_timeout() -> void:
	self.queue_free()
