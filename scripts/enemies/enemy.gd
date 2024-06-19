class_name enemy

extends CharacterBody3D

@onready var player : CharacterBody3D
@export var hp : int
var max_hp : int
@export var speed : float
@export var vision : Area3D
@export var nav_agent : NavigationAgent3D

func _ready():
	max_hp = hp
	player = Global.player

func take_demage(dem):
	hp -= dem

func move_to_player(pos):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(pos)
	var next_nav_point : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()

func _on_vision_timer_timeout():
	var overlaps = vision.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var playerPosition :Vector3 = overlap.global_transform.origin
				vision.look_at(playerPosition, Vector3.UP)
				move_to_player(playerPosition)
