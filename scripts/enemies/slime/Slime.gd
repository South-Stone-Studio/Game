class_name Slime

extends CharacterBody3D

@export var speed : float = 2
@onready var player : CharacterBody3D
@export var nav_agent : NavigationAgent3D
@export var health_points : int
var max_health_points := health_points
@export var demage : int

func _ready():
	player = get_node("%Player")

func _process(delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()
	if health_points <= 0:
		self.queue_free()

func take_demage(dem):
	health_points -= dem

