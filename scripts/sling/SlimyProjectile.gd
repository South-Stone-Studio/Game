class_name SlimyProjectile

extends CharacterBody3D


const SPEED = 10
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var target_position: Vector3

@export var shock_wave: PackedScene
var shock_node: Node3D
var radius: float
var obj_to_delete: Node3D
func _ready():
	velocity.y = 20
	shock_node = shock_wave.instantiate()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * 2
		velocity.x = move_toward(0, target_position.x - self.global_position.x, SPEED)
		velocity.z = move_toward(0, target_position.z - self.global_position.z, SPEED)
	move_and_slide()



func _on_area_3d_body_entered(body):
	if is_instance_of(body, SlimyProjectile):
		return
	var a: ShockWave = shock_node.duplicate()
	Global.current_room_root.add_child(a)
	a.global_position = self.global_position
	a.max_radius = radius
	a.speed = 20
	obj_to_delete.queue_free()
	self.queue_free()
