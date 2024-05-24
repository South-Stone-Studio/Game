class_name Player_movement

extends CharacterBody3D

func _ready():
	pass

func _process(delta):
	velocity = Vector3()

# --------------------------- # MOVEMENT AND LOOKING # --------------------------- #
@onready var camera: Camera3D = $"../Camera3D"
var rayOrigin: Vector3 = Vector3()
var rayEnd: Vector3 = Vector3()
@export var max_speed: int = 10
var accel: int = 20
var friction: int = 10
var input: Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Look at cursor
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	rayOrigin = camera.project_ray_origin(mouse_position)
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	var ray_parameters: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd)
	var intersection: Dictionary = space_state.intersect_ray(ray_parameters)
	if not intersection.is_empty():
		var pos: Vector3 = intersection.position
		pos.y = get_global_transform().origin.y
		self.look_at(Vector3(pos.x, pos.y, pos.z), Vector3(0, 1, 0))
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int((Input.is_action_pressed("ui_up")))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector3.ZERO
	else:
		input *= accel
		velocity += Vector3(input.x,0,input.y)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
# ---------------------------------------------------------------------- #
