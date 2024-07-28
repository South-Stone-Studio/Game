class_name IMovement

extends CharacterBody3D

@export var input_component : InputComponent
@onready var main = get_parent()
var input : Vector2 = Vector2.ZERO

@export var friction : float
@export var max_speed : float

func _process(delta: float) -> void:
	if input_component != null:
		player_movement(delta)

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
		velocity = velocity.limit_length(max_speed)
	move_and_slide()
