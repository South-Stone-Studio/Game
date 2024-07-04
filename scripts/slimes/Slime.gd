class_name Slime

extends CharacterBody3D


const SPEED = 7.0
const JUMP_VELOCITY = 10

signal landing
signal jumped

enum State{stand_by, patrol, atack, following}
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var target: Node3D
var target_position: Vector3
var slam: bool
var state: State = State.patrol

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	if not is_on_floor():
		velocity.y -= gravity * delta * 2
		if state != State.stand_by:
			velocity.x = move_toward(velocity.x, target_position.x - self.global_position.x, SPEED)
			velocity.z = move_toward(velocity.z, target_position.z - self.global_position.z, SPEED)
		if !slam:
			slam = true
			jumped.emit()
	else:
		target_position = target.global_position
		velocity.y = JUMP_VELOCITY
		if slam:
			slam = false
			landing.emit()

	move_and_slide()
