class_name SlimeMovement

extends IMovement
const JUMP_VELOCITY := 4
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_jump: bool

func move(delta:float, target_position: Vector3) -> void:
	var direction = (target_position - global_position).normalized()
	direction.x = snapped(direction.x, 0.001)
	direction.z = snapped(direction.z, 0.001)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	print(velocity)
	check_floor(delta)
	move_and_slide()
	
func stand(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	check_floor(delta)
	move_and_slide()
	
func check_floor(delta: float):
	if not is_on_floor():
		if !is_jump:
			is_jump = true
			on_jump.emit()
		apply_gravity(delta)
	else:
		
		if is_jump:
			is_jump = false
			on_land.emit()
			jump()
			
func apply_gravity(delta: float) -> void:
	velocity.y -= gravity * delta

func jump():
	velocity.y = JUMP_VELOCITY
