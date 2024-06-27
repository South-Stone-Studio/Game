extends RigidBody3D

@export var speed : float
@export var rotation_speed : float
@export var demage : int
@export var heal : int

func _physics_process(delta):
	translate(Vector3(0, 0, speed * delta))
	rotate_y(rotation_speed*delta)

func _on_bone_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		body.handle_demage(demage)
		self.queue_free()
	elif "Enemy" in body.name:
		body.heal()
		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()
