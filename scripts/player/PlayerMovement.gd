class_name PlayerMovement


extends CharacterBody3D

# --------------------------- # MOVEMENT AND LOOKING # --------------------------- #
@onready var camera: Camera3D = $"../Camera3D"
var rayOrigin: Vector3 = Vector3()
var rayEnd: Vector3 = Vector3()
@export var max_speed: int = 10
var accel: int = 20
var friction: int = 10
var input: Vector2 = Vector2.ZERO
@export var hand_controller: HandController
var grab_items_area :int = 5
@export var Mouse_Gobal_Position : Vector3 = Vector3.ZERO

func _ready() -> void:
	if Global.player == null:
		Global.player = self
		
func _physics_process(delta):
	
	velocity = Vector3()
	var intersection: Dictionary = camera.get_intersection()

	# cursor position 
	if not intersection.is_empty():
		var pos: Vector3 = intersection.position
		pos.y = get_global_transform().origin.y
		self.look_at(Vector3(pos.x, pos.y, pos.z), Vector3(0, 1, 0))

		# get object under mouse
		var obj_under_mouse: Node3D = intersection.collider

		# check if pickable and pick up an weapon 
		if Input.is_action_just_pressed("pick_up") and obj_under_mouse != null and position.distance_to(obj_under_mouse.position) <= grab_items_area:
			hand_controller.pick_up_item(obj_under_mouse)
		
		elif Input.is_action_just_pressed("drop"):
			hand_controller.drop_item()

	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int((Input.is_action_pressed("move_up")))
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
