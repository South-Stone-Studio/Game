class_name IMovement

extends CharacterBody3D

@export var input_component : InputComponent
@onready var main = get_parent()
var input : Vector2 = Vector2.ZERO
@onready var nav_agent = NavigationAgent3D.new()

# Take that from main script (later)
@export var friction : float
@export var camera : Camera3D
@export var speed : float

func _ready() -> void:
	if input_component == null: # not player
		self.add_child(nav_agent)

func _process(delta: float) -> void:
	if input_component != null: # if player
		player_movement(delta)
		if camera != null and camera.target == Global.player: 
			player_rotation()
	else: # not player
		pass

func get_input() -> Vector2:
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int((Input.is_action_pressed("move_up")))
	return input.normalized()

func player_movement(delta : float) -> void:
	input = get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector3.ZERO
	else:
		velocity += Vector3(input.x,0,input.y)
		velocity = velocity.limit_length(speed)
	move_and_slide()

func player_rotation() -> void:
	# Look at cursor
	velocity = Vector3()
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var rayOrigin : Vector3 = camera.project_ray_origin(mouse_position)
	var ray_normal : Vector3 = camera.project_ray_normal(mouse_position)
	ray_normal = ray_normal.limit_length(1)
	var rayEnd : Vector3 = rayOrigin + ray_normal * 2000
	
	# Camera operations / Camera follow cursor / Camera offset from player
	camera.position = position
	camera.position += ray_normal*4
	camera.position.y = 10
	camera.position.z += 2

	var ray_parameters: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd)
	var intersection: Dictionary = space_state.intersect_ray(ray_parameters)

	# cursor position 
	if not intersection.is_empty():
		var pos: Vector3 = intersection.position
		pos.y = get_global_transform().origin.y
		self.look_at(Vector3(pos.x, pos.y, pos.z), Vector3(0, 1, 0))
