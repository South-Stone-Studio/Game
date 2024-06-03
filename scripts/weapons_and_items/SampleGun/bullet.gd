extends RigidBody3D

@export var speed := 50.0
@export var death_timer := 20
@onready var forward_direction : Vector3 = global_transform.basis.z.normalized()

func _body_entered():
	print("body_entered")
	
func _physics_process(delta):
	global_translate(forward_direction*speed*delta)
	if death_timer <= 0:
		self.queue_free()
	death_timer -= 0.1 
