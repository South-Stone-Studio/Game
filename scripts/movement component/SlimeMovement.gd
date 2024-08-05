class_name SlimeMovement

extends IMovement
const JUMP_VELOCITY := 4
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_jump: bool

func move(delta:float, target_position: Vector3) -> void:
	var direction = (target_position - global_position).normalized()
	if check_floor(delta):
		direction.x = snapped(direction.x, 0.001)
		direction.z = snapped(direction.z, 0.001)
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	move_and_slide()
	
func stand(delta: float) -> void:
	if check_floor(delta):
		velocity.x = 0
		velocity.z = 0
	move_and_slide()
	
func check_floor(delta: float) -> bool:
	if not is_on_floor():
		if !is_jump:
			is_jump = true
			on_jump.emit()
		apply_gravity(delta)
		return false
	if is_jump:
		is_jump = false
		on_land.emit()
		jump()
	return true
func apply_gravity(delta: float) -> void:
	velocity.y -= gravity * delta

func jump():
	velocity.y = JUMP_VELOCITY
